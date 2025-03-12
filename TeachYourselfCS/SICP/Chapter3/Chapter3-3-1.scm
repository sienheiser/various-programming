;Exerice 3.12
(require rnrs/mutable-pairs-6)

(define (append x y)
    (if (null? x)
        y
        (cons (car x) (append (cdr x) y))))

(define (append! x y)
    (set-mcdr! (last-pair x) y)
    x)

(define (last-pair x)
    (if (null? (cdr x)) x (last-pair (cdr x))))

(define x (mcons 'a (mcons 'b '())))
(define y (mcons 'c (mcons 'd '())))


;Exercise 3.13
(define (make-cycle x)
    (set-mcdr! (last-pair x) x)
    x)
; We we apply (last-pair (make-cycle (list 'a 'b))) it gets stuck in a loop since 
; The new data structure has not null.


;Exercise 3.14
(define (mystery x)
    (define (loop x y)
        (if (null? x)
        y
        (let ((temp (cdr x)))
            (set-cdr! x y)
            (loop temp x))))
        (loop x '()))

