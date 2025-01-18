(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((equal? 'real-part op) x)
          ((equal? 'imag-part op) y)
          ((equal? 'magnitude op) (sqrt (+ (square x) (square y))))
          ((equal? 'angle op) (atan (/ y x)))
          (else (error "Unkown operation MAKE-FROM-REAL-IMAG: " op))))
  dispatch)

(define (apply-generic op arg) (arg op))

;Exercise 2.75
(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((equal? 'real-part op) (* r (cos a)))
          ((equal? 'imag-part op) (* r (sin a)))
          ((equal? 'magnitude op) r)
          ((equal? 'angle op) a)
          (else (error "Unkown operation MAKE-FROM-MAG-ANG: " op))))
  dispatch)


;Exercise 2.76
;We have three methods for dealing with data that have multiple representations
;;Explicit dispatch: For each representations define procdures with unique name.
;;                   Need to define a master function that calls the correct 
;;                   procedure depending on the type of data.

;;data directed programming: Define a package for each representation that have
;;                           the procedures defined. The name does not matter 
;;                           as we specify under which row and column of the
;;                           data type table the procedure falls under.

;;message passing: Define a procedure for each representation that returns
;;                 a dispacther procedure which contains information about
;;                 all the possible procedures and what must be done in each
;;                 case.


;Suppose we have to add new type i.e. new representation
;;Explicit dispatch: Need to define new procedures with unique names to handle
;;                   the base operation. Need to update the master function
;;                   that acts as a dispatcher with the new procedures.

;;Data directed programming: Define a new package with the procedures for the 
;;                           representation. This adds a new field to the data
;;                           procudre table.

;;message passing: Define a new procudure that returns the dispatcher.

;Suppose we have to add a new procedure
;;Explicit dispatch: Create the new procedure for each type making sure that
;;                   there are not naming conflicts.

;;data directed programming: Add the new procedure to each package. Create a
;;                           new row for the procedure                             


;;message passing: In each procedure that returns a dispacther add a new cond
;;                 that explains what to do in case the operation is the new 
;;                 procedure.



