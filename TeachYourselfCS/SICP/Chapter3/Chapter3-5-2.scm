(require racket/stream)

(define (stream-enumerate-interval a b)
    (if (> a b)
        empty-stream
        (stream-cons a
                     (stream-enumerate-interval (+ a 1) b))))

(define (stream-filter pred s)
    (cond ((stream-empty? s) empty-stream)
          ((pred (stream-first s))
           (stream-cons (stream-first s)
                        (stream-filter pred (stream-rest s))))
          (else (stream-filter pred (stream-rest s)))))

(define (prime? p)
    (define s (stream-enumerate-interval 2 (- p 2)))
    (cond ((= p 1) #t)
          ((= p 2) #t)
          (else
            (stream-empty? (stream-filter (lambda (x) (divisible? p x))
                                          s)))))

(define (even? n)
    (divisible? n 2))

(define (divisible? x y)
    (= (remainder x y) 0))
                                          
(define s (stream-enumerate-interval 1 10))


(define s2 (stream-enumerate-interval 10000 1000000))
;(define primes (stream-filter prime? s2))


; Infinite streams
(define (integers-from n)
    (stream-cons n (integers-from (+ n 1))))

(define integers (integers-from 1))

(define (sieve s)
    (let ((head (stream-first s))
          (tail (stream-rest s))
          (pred (lambda (x) (not (divisible? x (stream-first s))))))
         (stream-cons head
                      (sieve 
                        (stream-filter pred
                                       tail)))))

(define primes (sieve (integers-from 2)))


; Defining stream implicitly
(define (stream-map proc . argstreams)
    (if (stream-empty? (car argstreams))
        the-empty-stream
        (stream-cons
            (apply proc (map stream-first argstreams))
            (apply stream-map
                   (cons proc (map stream-rest argstreams))))))

(define ones (stream-cons 1 ones))

(define (add-streams s1 s2)
    (stream-map + s1 s2))

(define integers (stream-cons 1 (add-streams ones integers)))
    

     