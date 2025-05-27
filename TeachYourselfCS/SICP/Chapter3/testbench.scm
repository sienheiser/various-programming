(define (stream-enumerate-interval low high)
    (if (> low high)
        empty-stream
        (cons-stream low
                     (stream-enumerate-interval (+ 1 low) high))))

(define (cons-stream a b)
    (cons a (delay b)))

(define (delay exp)
    (lambda () (exp)))

(define (stream-car s)
    (car s))

(define (stream-cdr s)
    (force (cdr s)))

(define (force exp)
    (exp))

(define (stream-empty? s)
    (eq? empty-stream s))