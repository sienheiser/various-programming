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
(define (make-branch len structure)
  (list len structure))

;Exercise 2.29.a selectors
(define (select-left-branch bm)(car bm))
(define (select-right-branch bm)(car (cdr bm)))
(define (select-branch-length b) (car b))
(define (select-branch-structure b) (car (cdr b)))

;Exercise 2.29.b total-weight of a binary mobile 
(define (total-weight bm)
  (cond ((null? bm) 0)
        ((not (pair? (car bm))) (select-branch-structure bm))
        (else (+ (total-weight (select-left-branch bm))
                 (total-weight (select-right-branch bm))))))

(define test-mobile
  (make-mobile (make-branch 5 10) 
               (make-mobile (make-branch 5 10) (make-branch 5 10))))

;Exercise 2.29.c balanced trees



;Exercise 2.30 map for trees
;Define square-tree



(define (square x) (* x x))
(define test-tree(list (list 1 2) (list 3 4)))
(define (square-treeV1 tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (square tree))
        (else (cons (square-treeV1 (car tree))
                    (square-treeV1 (cdr tree))))))

(define (square-treeV2 tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (square-treeV2 sub-tree)
           (square sub-tree)))
       tree))

;Exercise 2.31 tree-map
(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (tree-map proc sub-tree)
           (proc sub-tree)))
       tree))

(define (square-treeV3 tree) (tree-map (lambda (x) (* x x)) tree))

;Chapter 2.2.3 Interfaces
(define (filter predicate sequence)
  (cond ((null? sequence) null)
        ((predicate (car sequence))
         (cons (car sequence) (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumelator bin-op base-case sequence)
  (if (null? sequence)
    base-case
    (bin-op (car sequence) (accumelator bin-op base-case (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
    null
    (cons low (enumerate-interval (+ 1 low) high))))

(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

;Exercise 2.33 basic list-manipulation operations as accumulations
(define (map-accum p sequence)
  (accumelator 
    (lambda (x y) (cons (p x) y))
    null
    sequence))

(define (append-accum seq1 seq2)
  (accumelator cons seq2 seq1))

(define (length-accum sequence)
  (accumelator (lambda (x y) (+ 1 y)) 0 sequence))

;Exercise 2.34 Horner evalution of polynomials
(define (horner-eval x coefficient-sequence)
  (accumelator (lambda (this-coeff higher-terms)
                 (+ this-coeff (* x higher-terms)))
               0
               coefficient-sequence))
;Exercise 2.35 Count Leaves in terms of accumelator
;(define (count-leaves t)
;(accumulate ⟨??⟩ ⟨??⟩ (map ⟨??⟩ ⟨??⟩)))

;(define (count-leaves xs)
;  (cond ((null? xs) 0)
;        ((not (pair? xs) 1))
;        (else (+ (count-leaves (car xs)) 
;                 (count-leaves (cdr xs))))))

(define (count-leaves-accum t)
(accumelator (lambda (x y) (+ 1 y)) 
            0 
            (map (lambda (x)
                  (if (not (pair? x))
                       x
                      (cons (lambda (car x)) (lambda (cdr x))))) 
            t)))
