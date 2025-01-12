(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
    (car datum)
    (error "Bad tagged datum: TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
    (cdr datum)
    (error "Bad tagged datum: CONTENTS" datum)))

;data directed programing
(define (install-rectangular-package)
  ;;internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
  (sqrt (+ (square (real-part z))
  (square (imag-part z)))))
  (define (angle z)
  (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
  (cons (* r (cos a)) (* r (sin a))))

  ;;interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part ('rectangular) real-part)
  (put 'imag-part ('rectangular) imag-part)
  (put 'magnitude ('rectangular) magnitude)
  (put 'angle ('rectangular) angle)
  (put 'make-from-real-imag ('rectangular)
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang ('rectangular)
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)


(define (install-polar-package)
  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z) (* (magnitude z) (cos (angle z))))
  (define (imag-part z) (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y)
  (cons (sqrt (+ (square x) (square y)))
  (atan y x)))
  
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'magnitude ('polar) magnitude)
  (put 'angle ('polar) angle)
  (put 'real-part ('polar) real-part)
  (put 'imag-part ('polar) imag-part)
  (put 'make-from-mag-ang ('polar)
       (lambda (r a) (tag (make-from-mag-ang r a))))
  (put 'make-from-real-imag ('polar)
       (lambda (x y) (tag (make-from-real-imag x y))))
  'done)


(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (error "No method for these types: APPLY-GENERIC" (list op type-tags))))))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))
(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))


;Exercise 
(define (install-derive-sum)
  ;internal procedures
  (define (make-expre a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2))
           (+ a1 a2))
          (else (list '+ a1 a2))))

  (define (derive expre var)
    (make-expre (derive (a1 expre)
                        (a2 expre))))
  ;interface
  (put 'derive ('+) derive)
  'done)

(define (install-derive-product)
  (define (make-product m1 m2)
    (cond ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((=number? m1 0) 0)
          ((=number? m2 0) 0)
          ((and (number? m1) (number? m2))
           (* m1 m2))
          (else (list '* m1 m2))))

  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2))
           (+ a1 a2))
          (else (list '+ a1 a2))))

  (define (derive expre var)
    (make-sum (make-product (m1 expre) (derive (m2 expre) var))
              (make-product (m2 expre) (derive (m1 expre) var))))
  ;interface
  (put 'derive ('*) derive)
  'done)

(define (=number? m n)
  (eq? m n))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define a1 cadr)
(define (a2 expre)
  (if (> (length expre) 3)
    (cons '+ (cddr expre))
    (caddr expre)))

(define (make-product m1 m2)
  (cond ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((=number? m1 0) 0)
        ((=number? m2 0) 0)
        ((and (number? m1) (number? m2))
         (* m1 m2))
        (else (list '* m1 m2))))

(define m1 cadr)
(define (m2 expre)
  (if (> (length expre) 3)
    (cons '* (cddr expre))
    (caddr expre)))

(define variable? atom?)

(define (same-variable var1 var2)
  (if (and (variable? var1) (variable? var2))
    (eq? var1 var2)
    #f))

(define (sum? expr)
  (eq? (car expr) '+))

(define (product? expr)
  (eq? (car expr) '*))

(define (operation? expr)
  (or (sum? expr)
      (product? expr)
      (exponentiation? expr)))

(define (make-exponent e1 e2)
  (cond ((=number? e1 1) 1)
        ((=number? e2 1) e1)
        ((=number? e2 0) 1)
        ((and (number? e1) (number? e2))
         (exp e1 e2))
        (else (list '** e1 e2))))

(define e1 cadr)
(define e2 caddr)

(define (exponentiation? expr)
  (eq? (car expr) '**))

(define (exponent? expr var)
  (eq? (e2 expr) var))

(define (base? expr var)
  (eq? (e1 expr) var))

(define (derive expre var)
  (cond ((variable? expre) 
         (if (same-variable expre var) 1 0))
        ((sum? expre) (make-sum (derive (a1 expre) var)
                                (derive (a2 expre) var)))
        ((product? expre) (make-sum (make-product (m1 expre) (derive (m2 expre) var))
                                    (make-product (m2 expre) (derive (m1 expre) var))))
        ((exponentiation? expre) (if (base? expre var)
                                   (make-product (make-product (e2 expre) (make-exponent (e1 expre) (- (e2 expre) 1)))
                                                 (derive (e1 expre) var))
                                   (make-product (list 'ln (e1 expre)) expre)))
        (else (error "Unkown expression: DERIVE" expre))))
