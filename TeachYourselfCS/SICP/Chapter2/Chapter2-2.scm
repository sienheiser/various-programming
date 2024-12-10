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
