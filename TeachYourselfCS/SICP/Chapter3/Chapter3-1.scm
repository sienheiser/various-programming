;Example with global state
;(define balance 100)
;
;(define (withdraw amount)
;  (if (>= balance amount)
;    (begin 
;      (set! balance (- balance amount)) 
;      balance)
;    ("Insufficient funds cannot withdraw")))


;Example with local state
(define new-withdraw
  (let ((balance 100))
    (lambda (amount)
      (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "Insufficient funds cannot withdraw"))))


(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
      (begin
        (set! balance (- balance amount))
        balance)
      "Insufficient funds cannot withdraw")))


;;Commented out because same function used in exercies
;; 3.3
;(define (make-account balance)
;  (define (withdraw amount)
;    (if (>= balance amount)
;      (begin
;        (set! balance (- balance amount))
;        balance)
;      "Insufficient funds cannot withdraw"))
;
;  (define (deposite amount)
;    (set! balance (+ balance amount))
;    balance)
;
;  (define (dispatch m)
;    (cond ((eq? m 'withdraw) withdraw)
;          ((eq? m 'deposite) deposite)
;          (else (error "Unkown requer: MAKE-ACCOUNT:" m))))
;
;  dispatch)



;Exercise 3.1
(define (make-accumulate num)
  (lambda (addend)
    (begin (set! num (+ num addend))
           num)))


;Exercise 3.2
(define (make-monitored f)
  (define calls 0)
  (define (dispatch m)
    (cond ((eq? m 'how-many-calls) calls)
          ((eq? m 'reset-count) (set! calls 0))
          (else (begin (set! calls (+ calls 1))
                       (f m)))))
  dispatch)



;Exercise 3.3
(define (make-account password balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin
        (set! balance (- balance amount))
        balance)
      "Insufficient funds cannot withdraw"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (dispatch input-password m)
    (if (= password input-password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request: MAKE-ACCOUNT:" m)))
        "Incorrect password"))

  (define accessed 0)
  (define (call-cops? input-password m)
    (begin 
      (set! accessed (+ accessed 1))
      (if (>= accessed 3)
          (lambda (amount) "Calling the cops")
          (dispatch input-password m))))
  call-cops?)

  
(define (test-state balance)
  (let ((called 0))
    (begin 
      (set! called (+ called 1))
      (if (>= called 3)
        "Blabla"
        balance))))







