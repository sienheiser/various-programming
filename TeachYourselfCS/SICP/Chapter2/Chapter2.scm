
(define (remainder a b)
  (cond ((< a b) a)
        ((= a b) 0)
        (else (remainder (- a b) b))))


(define (gcd a b) 
  (if (= b 0)
    a
    (gcd b (remainder a b))))

;Defining rational number arithmetic
;; Defining rational numbers
(define (numer x) (car x))
(define (denom x) (cdr x))

;(define (make-rat n d)
;  (let ((g (gcd (abs n) (abs d))))
;    (cons (/ n g) (/ d g))))

;Exercise 2.1
(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d))))
    (cond ((and (< n 0) (> d 0)
                (cons n d)))
          ((and (< n 0) (< d 0)
                (cons (abs n) (abs d))))
          ((and (> n 0) (< d 0)
                (cons (- n) (abs d))))
          (else (cons n d)))))

;; Defining rational numbers operations
(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y)) (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y)) (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
;; Printing rational numbers
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))


;Exercise 2.2
;Make line segments from points and make points

;;Making points
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (print-point p) 
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

;;Making segments
(define (make-segment q p) (cons q p))
(define (start-segment l) (car l))
(define (end-segment l) (cdr l))

(define (mid-point l)

  (define (average x y)
    (/ (+ x y) 2))

  (define (coordinate-avg l point)
    (average
      (point (start-segment l))
      (point (end-segment l))))

  (make-point
    (coordinate-avg l x-point)
    (coordinate-avg l y-point)))

;Exercise 2.3
;Make rectanle from segments. Use constructors and selectors
;defines in Exercise 2.2
;; Representation 1: 2 corners

(define (width-rec rec)
  (abs (- (x-point (point1 rec)) 
          (x-point (point2 rec)))))

(define (height-rec rec)
  (abs (- (y-point (point1 rec)) 
          (y-point (point2 rec)))))

(define (area rec)
  (* (width-rec rec) (height-rec rec)))
 
(define (perimeter rec)
  (+ 
    (* (width-rec rec) 2) 
    (* (height-rec rec) 2)))

(define make-rec cons)
(define (point1 rec)
  (car rec))
(define (point2 rec)
  (cdr rec))

;; Representation 2: point, height, width
(define (make-rec2 p h w)
  (cons p (cons h w)))



(define rec (make-rec (make-point 1 2) (make-point 3 4)))

;Exercise 2.4
;Make cons as a procedure

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))


;Exercise 2.5
;Represent pair a b as integer of form 2^a*3^b
(define (cons-int a b)
  (* (expt 2 a) (expt 3 b)))

(define (iter k i counter)
  (if (= (modulo k i) 0)
    (iter (/ k i) i (+ counter 1))
    counter))

(define (car-int n)
  (iter n 2 0))

(define (cdr-int n)
  (iter n 3 0))

;Exercise 2.6 Integers as functions
(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define (add n m)
  (lambda (f) (lambda (x) ((n f) ((m f) x)))))

(define (id x) (+ x 1))

;Exercise 2.7 Define upper-bound and lower-bound selectors for interval
(define (make-interval a b) (cons a b))

(define (lower-bound x) (car x))
(define (test-lower-bound)
  (define test-int (make-interval 1 2))
  (= (lower-bound test-int) 1))

(define (upper-bound x) (cdr x))
(define (test-upper-bound)
  (define test-int (make-interval 1 2))
  (= (upper-bound test-int) 2))

(define (sub-interval x y)
  (make-interval
     (- (lower-bound x) (upper-bound y))
     (- (upper-bound x) (lower-bound y))))
(define (test-sub-interval)
  (define test-int1 (make-interval 1 2))
  (define test-int2 (make-interval 3 4))
  (define result (sub-interval test-int1 test-int2))
  (let 
    ((lower (lower-bound result))
     (upper (upper-bound result)))
    (and (= lower -3)
         (= upper -1))))

(define (mul-interval x y)
  (let 
    ((p1 (* (lower-bound x) (lower-bound y)))
     (p2 (* (lower-bound x) (upper-bound y)))
     (p3 (* (upper-bound x) (lower-bound y)))
     (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

(define (test-mul-interval)
  (define test-int1 (make-interval 1 2))
  (define test-int2 (make-interval 3 4))
  (define result (mul-interval test-int1 test-int2))
  (let 
    ((lower-res (lower-bound result))
     (upper-res (upper-bound result))
     (lower-exp 3)
     (upper-exp 8))
    (and (= lower-res lower-exp)
         (= upper-res upper-exp))))


(define (div-interval x y)
  (if  (and (< (lower-bound y) 0) (> (upper-bound y) 0))
    (error "an interval spans zero")
    (mul-interval x 
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y))))))

(define test-int1 (make-interval 1 2))
(define test-int2 (make-interval 3 4))
(define (test1-div-interval)
  (define test-int1 (make-interval 1 2))
  (define test-int2 (make-interval 3 4))
  (define result (div-interval test-int1 test-int2))
  (let
    ((lower-res (lower-bound result))
     (upper-res (upper-bound result))
     (lower-exp (/ 1.0 4.0))
     (upper-exp (/ 2.0 3.0)))
    (and (= lower-res lower-exp)
         (= upper-res upper-exp))))

(define (test2-div-interval)
  (define test-int1 (make-interval 1 2))
  (define test-int2 (make-interval -1 4))
  (div-interval test-int1 test-int2))
    
