;Primitive function boxes

(define (get-signal wire))
(define (set-signal! wire new-value))
(define (add-action! wire f-no-args))
(define (after-delay time-delay f))


;logic gates
(define (inverter input output)
    (define (invert-input)
        (let ((new-value (logic-not (get-signal input))))
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

(define (or-gate2 a1 a2 output)
    (let ((s1 (make-wire))
          (s2 (make-wire)))
         (inverter a1 s1)
         (inverter a2 s2)
         (and-gate s1 s2 output)))
        