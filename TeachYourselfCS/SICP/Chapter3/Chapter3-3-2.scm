(require racket/mpair)
;queue
(define (set-car! x item) (set-mcar! x item))
(define (set-cdr! x item) (set-mcdr! x item))

; A queue is a pair that point to the front and end of a list.
(define (make-queue) (mcons null null))

(define (front-ptr queue) (mcar queue))
(define (rear-ptr queue) (mcdr queue))

(define (empty-queue? queue) (eq? (front-ptr queue) null))

(define (set-front-ptr! queue item)(set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (insert-queue queue item)
    (let ((new-pair (mcons item null)))
        (cond ((empty-queue? queue) 
               (set-front-ptr! queue new-pair)
               (set-rear-ptr! queue new-pair)
               queue)
               (else
                (set-cdr! (rear-ptr queue) new-pair)
                (set-rear-ptr! queue new-pair)
                queue))))

(define (delete-queue queue)
    (cond ((empty-queue? queue)
           (error "Tried delete-queue on empty queue" queue))
           (else 
            (set-front-ptr! queue (mcdr (front-ptr queue)))
            queue)))


;Exercise 2.21 Make queue representation for printing
;Why does the standard print out not work?
;The example given in exercise 3.22 shows an issue with the standard
;printing method. When you insert two items and then delete the queue,
;the cdr pointer still points to the last item.
(define (print-queue queue)
    (if (empty-queue? queue)
        (print "(mcons '() '())")
        (print queue)))

;Exercise 2.22 Build queue as a procedure with local state. The procedure will 
;have form
(define (make-queue)
    (let ((front-ptr null)
          (rear-ptr null))
        
        (define (empty-queue?)(eq? front-ptr null))

        (define (get-front-ptr) front-ptr)

        (define (get-rear-ptr) rear-ptr)

        (define (set-front-ptr! new-val)
            (set! front-ptr new-val)
            )

        (define (set-rear-ptr! new-val)
            (set! rear-ptr new-val)
            )

        (define (delete!)
            (cond ((empty-queue?) (error "Nothing to delete in empty queue"))
                  (else (set-front-ptr! (mcdr front-ptr))
                  front-ptr)))

        (define (insert! item)
            (let ((new-pair (mcons item null)))
                (cond ((empty-queue?)
                       (set-front-ptr! new-pair)
                       (set-rear-ptr! new-pair)
                       front-ptr)
                      (else
                       (set-cdr! rear-ptr new-pair)
                       (set-rear-ptr! new-pair)
                       front-ptr)
                       )))

        (define (dispatch m)
            (cond ((eq? m 'get-front-ptr) (get-front-ptr))
                  ((eq? m 'get-rear-ptr) (get-rear-ptr))
                  ((eq? m 'set-front-ptr!) set-front-ptr!)
                  ((eq? m 'set-rear-ptr!) set-rear-ptr!)
                  ((eq? m 'delete!) (delete!))
                  ((eq? m 'insert!) insert!)
                  (else (error "Undefined action for message" m))))
        dispatch))

(define x (make-queue))
(define y (mlist 1 2 3))

;Exercise 3.23 Make deque
(define (make-deque)
    (let ((front-ptr null)
          (rear-ptr null))
        (define (set-front-ptr! new-val)
            (set! front-ptr new-val))
        (define (set-rear-ptr! new-val)
            (set! rear-ptr new-val))
        (define (delete-front!)
            (cond ((empty-queue?) (error "Nothing to delete in empty deque"))
                  (else (set-front-ptr! (mcdr front-ptr))
                  front-ptr)))
        (define (delete-rear!)
            (cond ((empty-queue?) (error "Nothing to delte in empty deque"))
                  (else (set-rear-ptr ...))))          
        (define (insert-front! new-val))
        (define (insert-rear! new-val))
        ))