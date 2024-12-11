(define (appen list1 list2)
  (if (null? list1)
    list2
    (cons (car list1) (append (cdr list1) list2))))


;Exercise 2.17 define procedure last-pair
; (last-pair (list 23 72 149 34)) = 34
(define (last-pair list1)
  (if (null? (cdr list1))
    list1
    (last-pair (cdr list1))))

(define test-list (list 23 72 149 34))

;Exercise 2.18 define reverse
(define (reverse list1)
  (define (iter list2 list3)
    (if (null? list2)
      list3
      (iter (cdr list2) (cons (car list2) list3))))
  (iter list1 null))

;Exercise 2.20 define same-parity
;(same-parity 1 2 3 4 5 6 7) = (1 3 5 7)
;(same-parity 2 3 4 5 6 7) = (2 4 6)

(define (same-parity x . y)
  (define (even-elem list1)
    (cond ((null? list1) null)
          ((even? (car list1)) (cons (car list1) (even-elem (cdr list1))))
          (else (even-elem (cdr list1)))))
  (define (odd-elem list1)
    (cond ((null? list1) null)
          ((odd? (car list1)) (cons (car list1) (odd-elem (cdr list1))))
          (else (odd-elem (cdr list1)))))
  (if (even? x)
    (cons x (even-elem y))
    (cons x (odd-elem y))))
;-----------------------------------------

(define (mapp proc xs)
  (if (null? xs)
    null
    (cons (proc (car xs)) (mapp proc (cdr xs)))))

;Exercise 2.21 square-list
(define (square-list xs)
  (mapp (lambda (x) (* x x))
        xs))


;Exercise 2.23 for-each
(define (for-each proc xs)
  (unless (null? xs)
    (proc (car xs))
    (for-each proc (cdr xs))))
;----------------------------------------

(define (lengthh xs)
  (if (null? xs)
    0
    (+ 1 (lengthh (cdr xs)))))



(define (count-leaves xs)
  (cond ((null? xs) 0)
        ((not (pair? xs) 1))
        (else (+ (count-leaves (car xs)) 
                 (count-leaves (cdr xs))))))

;Exercise 2.27 deep-reverse
;(deep-reverse ((1 2) (3 4))) = ((4 3) (2 1))

(define (deep-reverse xs)
  (define (iter ys zs)
    (cond ((null? ys) zs)
          ((not (pair? (car ys))) (iter (cdr ys) (cons (car ys) zs)))
          (else (iter (cdr ys) (cons (iter (car ys) null) zs)))))
  (iter xs null))

;Exercise 2.28 fringe
; (fringe ((list 1 2) 3 4)) = (1 2 3 4)
(define (fringe xs)
  (cond ((null? xs) null)
        ((not (pair? (car xs))) (cons (car xs) (fringe (cdr xs))))
        (else (fringe (append (car xs) (cdr xs))))))


;Exercise 2.29 Binary-Mobile 
(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

;Exercise 2.29.a selectors
(define (select-left-branch bm)(car bm))
(define (select-right-branch bm)(cdr bm))
(define (select-branch-length) b (car b))
(define (select-branch-structure) b (cdr b))

;Exercise 2.29.b total-weight of a binary mobile 
(define (total-weight bm)
  (cond ((null? bm) 0)
        ((not (pair? bm)) (select-branch-structure))
        (else (+ (total-weight (select-left-branch bm))
                 (total-weight (select-right-branch bm))))))

(define (test-mobile)
  (make-mobile 5 5))