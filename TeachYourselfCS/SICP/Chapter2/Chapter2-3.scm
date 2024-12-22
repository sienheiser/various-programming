;Differential programm example
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

;Sets programe
;; Sets as unordered lists
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
    set
    (cons x set)))


(define (intersect-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersect-set (cdr set1) set2)))
        (else (intersect-set (cdr set1) set2))))

;Exercise 2.59 define union-set
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2) (union-set (cdr set1) set2))
        (else (cons (car set1) (union-set (cdr set1) set2)))))


;; Sets as ordered lists
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((< x (car set)) #f)
        ((= x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (intersect-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((= (car set1) (car set2)) 
         (cons (car set1) (intersect-set (cdr set1) (cdr set2))))
        ((> (car set1) (car set2)) (intersect-set set1 (cdr set2)))
        ((< (car set1) (car set2)) (intersect-set (cdr set1) set2))))
;Exercise 2.61 define adjoin set with the new representation
(define (adjoin-set x set)
  (cond ((null? set) (cons x null))
        ((>= x (car set)) 
         (cons (car set) (adjoin-set x (cdr set))))
        (else (cons x set))))


(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((= (car set1) (car set2))
         (cons (car set1) (union-set (cdr set1) (cdr set2))))
        ((> (car set1) (car set2)) (cons (car set2) (union-set set1 (cdr set2))))
        ((< (car set1) (car set2)) (cons (car set1) (union-set (car set1) set2)))))

;; Sets as binary trees
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))


(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((> x (car set)) (element-of-set? x (right-branch)))
        ((= x (car set)) #t)
        ((< x (car set)) (element-of-set? x (left-branch)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set) set))
        ((> x (entry set) (make-tree (car set) (left-branch set) (adjoin-set x (right-branch set)))))
        ((< x (entry set) (make-tree (car set) (adjoin-set x (left-branch set)) (right-branch set))))))
