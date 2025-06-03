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

(define (stream-filter pred s)
    (cond ((stream-empty? s) empty-stream)
          ((pred (stream-car s))
           (cons-stream (stream-car s)
                        (stream-filter pred (stream-cdr s))))
          (else (stream-filter pred (stream-cdr s)))))

(define (stream-enumerate-interval low high)
    (if (> low high)
        empty-stream
        (cons-stream low
                     (stream-enumerate-interval (+ 1 low) high))))

(define (display-stream s)
    (stream-for-each display-line s))

(define (display-line x)
    (newline) (display x))

;Constructing a stream
(define (cons-stream a b)
    (cons a (delay b)))

(define (delay exp)
    (lambda () exp))

(define (stream-car s)
    (car s))

(define (stream-cdr s)
    (force (cdr s)))

(define (force exp)
    (exp))


;Prime numbers
; Finding the second prime number
(define (prime? p)
    (define (is_divisible? i)
        (= (modulo p i) 0))
    
    (define s (stream-enumerate-interval 2 (- p 1)))

    (cond ((= p 1) #t)
          ((= p 2) #t)
          (else (stream-empty? (stream-filter is_divisible? s)))))

(define (even? n) (= (modulo n 2) 0))

(define s (stream-enumerate-interval 2 5))

(define primes (stream-filter prime?
                              (stream-enumerate-interval 1 10)))


;Infinite streams
(define (integers-starting-from n)
    (cons-stream n (integers-starting-from (+ n 1))))

;(define integers (integers-starting-from 1))

;(define (divisible? x y) (= (remainder x y) 0))
;
;(define (no-seven s)
;    (stream-filter (lambda (x) (not (divisible? x 7)))
;                   integers))