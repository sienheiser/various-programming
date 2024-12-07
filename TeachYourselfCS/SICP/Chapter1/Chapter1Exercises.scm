(define tol 0.001)

(define (fixed-point f first-guess)

  (define (good-enough a b)
    (< (abs (- a b)) tol))

  (define (try-guess guess)
    (let ((next (f guess)))
      (if (good-enough guess next)
        next
        (try-guess next))))

  (try-guess first-guess))

(define (average a b) (/ (+ a b) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (sqrt x) 
  (define (update-function y) (/ x y))
  (fixed-point (average-damp update-function) 1.0))
