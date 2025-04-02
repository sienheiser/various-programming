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

;Creating local table
(define (make-table)
    (let ((local-table (mlist '*table*)))
        (define (insert! key-1 key-2 value)
            (let ((subtable
                (assoc key-1 (mcdr local-table))))
                (if subtable
                    (let ((record (assoc key-2 (mcdr subtable))))
                        (if record
                            (set-mcdr! record value)
                            (set-mcdr! subtable
                                      (mcons (mcons key-2 value)
                                            (mcdr subtable)))))
                (set-mcdr! local-table
                          (mcons (mlist key-1 (mcons key-2 value))
                                (mcdr local-table)))))
            'ok)
        (define (lookup key1 key2)
            (let ((subtable (assoc key1
                                   (mcdr local-table))))
                (if subtable
                    (let ((record (assoc key2
                                         (mcdr subtable))))
                        (if record
                            (mcdr record)
                            #f))
                    #f)))
        (define (dispatch m)
            (cond ((eq? m 'lookup) lookup)
                ((eq? m 'insert!) insert!)
                (else (error "Unkown message for table:" m))))
        dispatch
    ))

(define operation-table (make-table))
(define get (operation-table 'lookup))
(define put (operation-table 'insert!))


;Exercise 3.24 approximate match. In the assoc procedure we have use
;equal? to check for equality. Lets loosen this check for the case 
;numeric keys. We match when we are in a tolerance of a key
(define (same-key? key1 key2)
    (let ((tol 1))
        (<= (abs (- key1 key2))
                tol)))

(define (assoc2 key records)
    (cond ((null? records) #f)
          ((same-key? (mcar (mcar records)) key) (mcar records))
          (else (assoc2 key (mcdr records)))))

(define test-tbl (mlist '*table* (mcons 1 'a) (mcons 5 'b) (mcons 8 'c)))

(define (lookup2 key table)
    (let ((record (assoc2 key
                          (mcdr table))))
        (if record
            (mcdr record)
            #f)))

(define (make-table2 same-key?)
    (define (assoc key records)
        (cond ((null? records) #f)
            ((same-key? (mcar (mcar records)) key) (mcar records))
            (else (assoc key (mcdr records)))))

    (let ((local-table (mlist '*table*)))
        (define (insert! key-1 key-2 value)
            (let ((subtable
                (assoc key-1 (mcdr local-table))))
                (if subtable
                    (let ((record (assoc key-2 (mcdr subtable))))
                        (if record
                            (set-mcdr! record value)
                            (set-mcdr! subtable
                                      (mcons (mcons key-2 value)
                                            (mcdr subtable)))))
                (set-mcdr! local-table
                          (mcons (mlist key-1 (mcons key-2 value))
                                (mcdr local-table)))))
            'ok)
        (define (lookup key1 key2)
            (let ((subtable (assoc key1
                                   (mcdr local-table))))
                (if subtable
                    (let ((record (assoc key2
                                         (mcdr subtable))))
                        (if record
                            (mcdr record)
                            #f))
                    #f)))
        (define (dispatch m)
            (cond ((eq? m 'lookup) lookup)
                ((eq? m 'insert!) insert!)
                (else (error "Unkown message for table:" m))))
        dispatch
    ))

;Exercise 3.25 contruct make-table that can deal with arbitrary amount of keys.
(define (assoc-gen keys table)
    (define (assoc key records)
        (cond ((null? records) #f)
            ((equal? (mcar (mcar records)) key) (mcar records))
            (else (assoc key (mcdr records)))))

    (cond ((null? mcdr keys)
            (let ((record (assoc (mcar keys)
                                 (mcdr table))))
                record))
          (else 
            (let ((subtable (assoc (mcar keys)
                                   (mcdr table))))
                (if subtable
                    (assoc-gen (mcdr keys) subtable)
                    #f)))))
          
(define (make-table3)
    (let ((local-table (mlist '*table*)))
        (define (lookup keys)
            (let ((record (assoc-gen keys local-table)))
                (if record
                    (mcdr record)
                    #f)))))
        (define (insert! keys value))
    