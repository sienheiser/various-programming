(define (integers-from n)
    (cons-stream n (integers-from (+ n 1))))

(define (cons-stream a b)
    (cons a (dela b)))

(define-syntax dela
  (syntax-rules ()
    ((dela exp) (lambda () exp))))

(define (stream-car s)
    (car s))

(define (stream-cdr s)
    (force (cdr s)))

;(define integers (integers-from 1))
(define s (cons-stream 1 (cons-stream 2 empty-stream)))