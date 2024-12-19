(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))
;Exercise 2.53
;(list 'a 'b 'c) -> (a b c)
;(list (list 'george)) -> ((george))
;(cdr '((x1 x2) (y1 y2))) -> ((y1 y2))
;(cadr '((x1 x2) (y1 y2))) -> y1
;(pair? (car '(a short list))) -> #f
;(memq 'red '((red shoes) (blue socks))) -> #f
;(memq 'red '(red shoes blue socks)) -> (red shoes blue socks)

;Exercise 2.54 define equal?
(define (atom? sym)
  (if (and (not (pair? sym))
           (not (null? sym)))
    #t
    #f))


(define (equal? sym1 sym2)
  (cond ((atom? sym1)
         (cond ((not (atom? sym2)) #f)
               (else (eq? sym1 sym2))))
        ((null? sym1)
         (if (null? sym2) #t #f))
        ((null? sym2)
         (if (null? sym1) #t #f))
        ((not (eq? (car sym1) (car sym2))) #f)
        (else (equal? (cdr sym1) (cdr sym2)))))


;Differentiation program
(define (=number? m n)
  (eq? m n))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define a1 cadr)
(define a2 caddr)

(define (make-product m1 m2)
  (cond ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((=number? m1 0) 0)
        ((=number? m2 0) 0)
        ((and (number? m1) (number? m2))
         (* m1 m2))
        (else (list '* m1 m2))))

(define m1 cadr)
(define m2 caddr)

(define variable? atom?)

(define (same-variable var1 var2)
  (if (and (variable? var1) (variable? var2))
    (eq? var1 var2)
    #f))

(define (sum? expr)
  (eq? (car expr) '+))

(define (product? expr)
  (eq? (car expr) '*))

(define (derive expre var)
  (cond ((variable? expre) 
         (if (same-variable expre var) 1 0))
        ((sum? expre) (make-sum (derive (a1 expre) var)
                                (derive (a2 expre) var)))
        ((product? expre) (make-sum (make-product (m1 expre) (derive (m2 expre) var))
                                    (make-product (m2 expre) (derive (m1 expre) var))))
        (else (error "Unkown expression: DERIVE" expre))))
