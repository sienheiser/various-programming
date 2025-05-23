(define (stream-ref s n)
    (if (= n 0)
        (stream-car s)
        (stream-ref (cdr s) (-n 1))))

(define (stream-map proc s)
    (if (stream-empty? s)
        empty-stream
        (stream-map proc (stream-cdr s))))

(define (stream-for-each proc s)
    (if (stream-empty? s)
        'done
        (begin (proc (stream-car s))
               (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
    (stream-for-each display-line s))

(define (display-line x)
    (newline) (display x))

;Constructing a stream
(define (cons-stream a b)
    (cons a (delay b)))

(define (stream-car s)
    (car s))

(define (stream-cdr s)
    (force (cdr s)))

(define (delay exp)
    (lambda () (exp)))

(define (force delayed-object)
    (delayed-object))



;Prime numbers
; Finding the second prime number
(stream-car
    (stream-cdr 
        (stream-filter prime?
                       (stream-enumerate-interval 
                       10000 1000000))))

(define (stream-filter pred s)
    (cond ((stream-null? s) the-empty-stream)
          ((pred (car-stream s))
           (cons-stream (car-stream s)
                        (stream-filter pred (cdr-stream s))))
          (else (stream-filter pred (cdr-stream s)))))

(define (stream-enumerate-interval low high)
    (if (> low high)
        empty-stream
        (cons-stream low
                     (stream-enumerate-interval (+ 1 low) high))))


(define (prime? p)
    (define (is_divisible? i)
        (= (modulo p i)))
    
    (define s (stream-enumerate-interval 2 p))

    (stream-empty (stream-filter is_divisible? s)))


    
    
    

