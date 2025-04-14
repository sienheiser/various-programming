#lang racket/base
(require racket/mpair)
;(require racket/time)
;Primitive function boxes

;(define (get-signal wire))
;(define (set-signal! wire new-value))
;(define (add-action! wire f-no-args))
;(define (after-delay time-delay f))

(define (get-signal wire) (wire 'get-signal))
(define (set-signal! wire value) ((wire 'set-signal) value))
(define (add-action! wire action-procedure) ((wire 'add-action!) action-procedure))
(define (after-delay delay action)
    (add-to-aggenda! (+ delay (current-time the-agenda))
                     action
                     the-agenda))


;logic gates
(define (inverter input output)
    (define (invert-input)
        (let ((new-value (logical-not (get-signal input))))
            (after-delay inverter-delay
                        (lambda ()(set-signal! output new-value)))))
    (add-action! input invert-input)
    'ok)
(define (logical-not s)
    (cond ((= s 0) 1)
          ((= s 1) 0)
          (else (error "Invalid signal" s))))

(define (and-gate a1 a2 output)
    (define (and-action-procedure)
        (let ((new-value (logical-and (get-signal a1)
                                      (get-signal a2))))
             (after-delay and-gate-delay
                          (lambda () (set-signal! output new-value)))))
    (add-action! a1 and-action-procedure)
    (add-action! a2 and-action-procedure)
    'ok)
(define (logical-and a1 a2)
    (and a1 a2))

(define (or-gate a1 a2 output)
    (define (or-action-procedure)
        (let ((new-value (logical-or (get-signal a1)
                                     (get-sginal a2))))
             (after-delay or-gate-delay
                          (lambda () (set-signal! output new-value)))))
    (add-action! a1 or-action-procedure)
    (add-action! a2 or-action-procedure)
    'ok)
(define (logical-or a1 a2)
    (or a1 a2))

;Exercise 3.29
(define (or-gate2 a1 a2 output)
    (let ((s1 (make-wire))
          (s2 (make-wire)))
         (inverter a1 s1)
         (inverter a2 s2)
         (and-gate s1 s2 output)))
;; The delay is 2*inverter-delay + and-gate-delay        



;Exercise 3.30: n-bit ripple carry adder
;Suppose we have procedure for full add 
;   (full-adder a b c-in sum c-out)

;(define (ripple-carry-adder as bs ss c-in c-out)
;    (full-adder (mcar as)
;                (mcar bs)
;                c-in
;                (mcar ss)
;                c-out)
;    (define c (make-wire))
;    (define (iterator as bs ss c-in c-out)
;        (cond ((null? as) )
;              (else
;                (let ((a (mcar as))
;                      (b (mcar bs))
;                      (s (mcar ss))
;                      (c (make-wire)))
;                     (full-adder a
;                                 b
;                                 c-in
;                                 s
;                                 c-out)
;                     (iterator (mcdr as) (mcdr bs) (mcdr ss) c-out c)))))
;    (iterator (mcdr as)
;              (mcdr bs)
;              (mcdr ss)
;              c-out
;              c))

(define (ripple-carry-adder as bs ss init-c-in)
    (define init-c-out (make-wire))
    (define init-c-out2 (make-wire))
    (define (iterator as bs c-in ss c-out)
        (cond ((null? as) )
              (else
                (let ((a (mcar as))
                      (b (mcar bs))
                      (s (mcar ss))
                      (new-cout (make-wire)))
                     (full-adder a
                                 b
                                 c-in
                                 s
                                 c-out)
                    (iterator (mcdr as)
                              (mcdr bs)
                              c-out
                              (mcdr ss)
                              new-cout)))))
    (full-adder (mcar as)
                (mcar bs)
                init-c-in
                (mcar ss)
                init-c-out)
    (iterator (mcdr as) (mcdr bs) init-c-out (mcdr ss) init-c-out2))

;; For an n-bit ripple-carry-adder we have n*full-carry-adder-delay
;; Each full-carry-adder-delay is equal to 
;; 2*half-adder-delay+or-gate-delay
;; each half-adder-delay equals to 2*and-gate-delay + or-gate-delay + inverter-delay
;; So 
;; n*full-carry-adder-delay = n*(2*half-adder-delay+or-gate-delay)
;;                          = n*(2*(2*and-gate-delay+or-gate-delay+inverter-delay)+or-gate-delay)
;;                          = n*(4*and-gate-delay+3*or-gate-delay+inverter-delay)



;Representing a wire
(define (make-wire)
    (let ((signal-value 0)
          (action-procedures '()))

         (define (set-my-signal! new-value)
            (if (not (= signal-value new-value))
                (begin
                    (set! signal-value new-value)
                    (call-each action-procedures))
                'done))

         (define (accept-action-procedure! proc)
            (set! action-procedures
                  (cons proc action-procedures))
            (proc))

         (define (dispatch m)
            (cond ((eq? m 'get-signal) signal-value)
                  ((eq? m 'set-my-signal!) set-my-signal!)
                  ((eq? m 'add-action!) accept-action-procedure!)
                  (else (error "Unkown operation: WIRE" m))))
         dispatch))

(define (call-each procedures)
    (if (null? procedures)
        'done
        (begin ((mcar procedures))
               (call-each (mcdr procedures)))))


(define (propagate)
    (if (empty-agenda? the-agenda)
         'done
         (let ((first-item (first-agenda-item the-agenda)))
              (first-item)
              (remove-first-agenda-item! the-agenda)
              (propagate))))

(define (probe name wire)
    (add-action! wire
                 (lambda ()
                    (newline)
                    (display name) (display " ")
                    (display (current-time the-agenda))
                    (display " New-value = ")
                    (display (get-signal wire)))))

;(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

;(probe 'sum sum)
;(probe 'carry carry)

;Implementing the agenda
(define (make-time-segment time queue)
    (cons time queue))
(define (segment-time s) (car s))
(define (segment-queue s) (cdr s))
