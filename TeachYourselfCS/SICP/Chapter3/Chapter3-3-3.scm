(require racket/mpair)
;1D table example
(define rec1 (mcons 'a 1))
(define rec2 (mcons 'b 2))
(define rec3 (mcons 'c 3))

(define table (mlist '*table* rec1 rec2 rec3))

;2D table example
;; Subtable 1
(define mrec1 (mcons '+ 43))
(define mrec2 (mcons '- 45))
(define mrec3 (mcons '* 42))
(define math (mlist 'math mrec1 mrec2 mrec3))

;; Subtable 2
(define lrec1 (mcons 'a 97))
(define lrec2 (mcons 'a 98))
(define letters (mlist 'letters lrec1 lrec2))

(define table2D (mlist '*table* letters math))



;functions
(define (assoc key records)
    (cond ((null? records) #f)
          ((equal? (mcar (mcar records)) key) (mcar records))
          (else (assoc key (mcdr records)))))

(define (lookup key table)
    (let ((record (assoc key (mcdr table))))
        (if record
            (mcdr record)
            #f)
    )
)

(define (lookup key1 key2 table)
    (let ((subtable (assoc key1 (mcdr table))))
        (if subtable
            (let ((record (assoc key2 (mcdr subtable))))
                (if record
                    (mcdr record)
                    #f))
            #f)))

(define (insert! key value table)
    (let ((record (assoc key (mcdr table))))
        (if record
            (set-mcdr! record value)
            (set-mcdr! table
                (mcons (mcons key value) (mcdr table))))
            'ok
    )
)
