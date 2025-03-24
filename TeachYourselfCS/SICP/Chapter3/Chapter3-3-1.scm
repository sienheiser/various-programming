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

(define (eq-pair p1 p2)
    (let ((p1l (car p1))
          (p1r (cdr p1))
          (p2l (car p2))
          (p2r (cdr p2)))
      (and (= p1l p2l)
           (= p1r p2r)))
)



;3.18
(define (count-pairs x)
    (let ((storage '()))
      (define (iter x)
        (if (or (not (pair? x)) (memq x storage))
          0
          (begin
            (set! storage (cons x storage))
            (+ (iter (car x))
               (iter (cdr x))
               1))))
      (iter x)))        

;3.19 write a procedure that determines if it is a cycle.
;Use Flyod's algorithm for finding cycles.



