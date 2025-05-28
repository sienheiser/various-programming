(define (stream-enumerate-interval low high)
    (if (> low high)
        empty-stream
        (construct-stream low
                          (stream-enumerate-interval (+ 1 low) high))))
(define (construct-stream a b)
    (cons a (hamper b)))

(define (hamper exp)
    (lambda () exp))

(define (stream-head s)
    (car s))

(define (stream-tail s)
    (pressure (cdr s)))

(define (pressure delayed-obj)
    (delayed-obj))

(define s (stream-enumerate-interval 1 10))
