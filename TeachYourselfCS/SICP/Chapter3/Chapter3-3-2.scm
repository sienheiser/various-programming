(require racket/mpair)
;queue
; A queue is a pair that point to the front and end of a list.
(define (set-cdr! q item)
    (set-mcdr! q item))
(define (set-car! q item)
    (set-mcar! q item))

;; Conctructor
(define (make-queue)
    (mcons null null))

;; getters
(define (front-ptr q)
    (mcar q))
(define (rear-ptr q)
    (mcdr q))

;; setters
(define (set-front-ptr! q item)
    (set-car! q item))
(define (set-rear-ptr! q item)
    (set-cdr! q item))

;; types of queues
(define (empty-queue? q)
    (null? (front-ptr q)))

;; update queue methods
(define (delete-queue! q)
    (cond ((empty-queue? q)
           (error "DELETE! called with an empty queue" q))
           (else (set-front-ptr! q (mcdr (front-ptr q)))
                 q)))


(define (insert-queue! q item)
    (let ((new-pair (mcons item null)))
        (cond ((empty-queue? q)
            (set-front-ptr! q new-pair)
            (set-rear-ptr! q new-pair)
            q)
            (else (set-cdr! (rear-ptr q) new-pair)
                  (set-rear-ptr! q new-pair)
                  q))))


;Exercise 3.22 Make queue representation for printing
;Why does the standard print out not work?
;The example given in exercise 3.22 shows an issue with the standard
;printing method. When you insert two items and then delete the queue,
;the cdr pointer still points to the last item.
(define (print-queue queue)
    (if (empty-queue? queue)
        (print "(mcons '() '())")
        (print queue)))
