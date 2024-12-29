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

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
      result-list
      (copy-to-list (left-branch tree)
                    (cons (entry tree)
      (copy-to-list
        (right-branch tree)
        result-list)))))
  (copy-to-list tree '()))

;Exercise 2.64
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
    (cons '() elts)
    (let ((left-size (quotient (- n 1) 2)))
      (let ((left-result 
              (partial-tree elts left-size)))
        (let ((left-tree (car left-result)) 
              (non-left-elts (cdr left-result)) 
              (right-size (- n (+ left-size 1))))
          (let ((this-entry (car non-left-elts)) 
                (right-result 
                  (partial-tree 
                    (cdr non-left-elts) 
                    right-size)))
            (let ((right-tree (car right-result))
                  (remaining-elts
                    (cdr right-result)))
              (cons (make-tree this-entry
                               left-tree
                               right-tree)
                    remaining-elts))))))))

;Exercise 2.65 Use the tree->list-2 and list->tree to
;define union and intersection between two balanced tree
(define (intersect-set-b set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((= (entry set1) (entry set2)) 
         (make-tree (entry set1) 
                    (intersect-set-b (left-branch set1) (left-branch set2))
                    (intersect-set-b (right-branch set1) (right-branch set2))))
        ((> (entry set1) (entry set2)) (intersect-set-b set1 (right-branch set2)))
        ((< (entry set1) (entry set2)) (intersect-set-b set1 (left-branch set2)))))

(define (inter-set-b set1 set2)
  (list->tree
    (intersect-set (tree->list-2 set1)
                   (tree->list-2 set2))))

;Information retrival
(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((equal? given-key (key (car set-of-records)))
                                (car set-of-records))
        (else (lookup given-key (cdr set-of-records)))))
;Exercise 2.66: Implement look-up for ordered and balanced binary trees
;; Ordered list
(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((eq? given-key (key (car set-of-records))) true)
        ((< given-key (key (car set-of-records))) false)
        (else (lookup given-key (cdr set-of-records)))))

;; Balanced binary tree
(define (lookup given-key set-of-records)
  (let ((record-key (key (entry (car set-of-records)))))
    ((cond ((null? set-of-records) false)
           ((eq? given-key record-key) true)
           ((> given-key record-key) (lookup given-key (right-branch set-of-records)))
           ((< given-key record-key) (lookup given-key (left-branch set-of-records)))))))

; Huffmann encoding tree
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object) (eq? 'leaf (car object)))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))


(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
    (list (symbol-leaf tree))
    (caddr tree)))

(define (weight tree)
    (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

;; Decoding the tree
(define (choose-branch bit branch)
  (cond ((= 0 bit) (left-branch branch))
        ((= 1 bit) (right-branch branch))
        (else (error "invalid bit " bit))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
      null
      (let ((next-branch (choose-branch (car bits) current-branch)))
        (if (leaf? next-branch)
          (cons (symbol-leaf next-branch)
                (decode-1 (cdr bits) tree))
          (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs) 
      null
      (let* ((pair (car pairs))
             (symbol (car pair))
             (weight (cadr pair)))
        (adjoin-set (make-leaf symbol weight) (make-leaf-set (cdr pairs))))))


;Exercise 2.67 use the defined sample tree to decode the sample message
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
  (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree
      (make-leaf 'D 1)
      (make-leaf 'C 1)))))
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;Exercise 2.68 Define encode-symbol
(define (encode-symbol symbol tree)
  (define (encode-symbol-1 bits symbol tree)
    (cond ((leaf? tree) (cdr bits))
          ((equal? (car (symbols tree)) symbol)
           (encode-symbol-1 (append bits (list 0)) symbol (left-branch tree)))
          (else (encode-symbol-1 (append bits (list 1)) symbol (right-branch tree)))))
  (encode-symbol-1 (list 'm ) symbol tree))

(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

;Exercise 2.69 Define generate-huffmann-tree
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge set)
  (if (null? (cdr set))
    (car set)
    (let* ((fst-elem (car set))
           (snd-elem (cadr set))
           (rest-of-elem (cddr set))
           (new-tree (make-code-tree fst-elem snd-elem)))
      (successive-merge (adjoin-set new-tree rest-of-elem)))))

;Exercise 2.70 Rock song encoding
(define rock-set
  (list (list 'A 2)
        (list 'GET 2)
        (list 'SHA 3)
        (list 'WAH 1)
        (list 'BOOM 1)
        (list 'JOB 2)
        (list 'NA 16)
        (list 'YIP 9)))
(define rock-huffman-tree (generate-huffman-tree rock-set))

(define rock-msg (list 'GET 'A 'JOB
                       'SHA 'NA 'NA 'NA 'NA 'NA 'NA 'NA 'NA
                       'GET 'A 'JOB
                       'SHA 'NA 'NA 'NA 'NA 'NA 'NA 'NA 'NA
                       'WAH 'YIP 'YIP 'YIP 'YIP 'YIP 'YIP 'YIP 'YIP 'YIP
                       'SHA 'BOOM))
