;representing adder

(define (adder a1 a2 sum)
  (define (process-value)
    (cond ((and (has-value? a1) (has-value? a2))
           (set-value! sum
                       (+ (get-value a1) (get-value a2))
                       dispatcher))
          ((and (has-value? sum) (has-value? a2))
           (set-value! a1 
                       (- (get-value sum) (get-value a2))
                       dispatcher))
          ((and (has-value? sum) (has-value? a1))
           (set-value! a2
                       (- (get-value sum) (get-value a1))
                       dispatcher))))


  (define (forget-value)
    (forget-value! a1 dispatcher)
    (forget-value! a2 dispatcher)
    (forget-value! sum dispatcher)
    (process-value))

  (define (dispatcher request)
    (cond ((eq? request 'process-value) (process-value))
          ((eq? request 'forget-value) (forget-value))
          (else (error "Unknown request: ADDER" request))))
  (connect a1 dispatcher)
  (connect a2 dispatcher)
  (connect sum dispatcher)
  dispatcher)
            


(define (make-connector)
  (let ((value false)
        (informant false)
        (constraints '()))

       (define (has-value?)
         (if informant true false))


       (define (set-value! new-value setter)
         (cond ((not (has-value?))
                (set! informant setter)
                (set! value new-value)
                (for-each-except setter
                                 inform-about-value
                                 constraints))
               ((not (eq? value new-value))
                (error "Contradiction: " (list value new-value)))
               (else 'ignore)))

       (define (forget-value! retractor)
         (if (eq? informant retractor)
           (being (set! informant false)
                  (set! value false)
                  (for-each-except retractor
                                   inform-about-no-value
                                   constraints))
           'ignore))
      (define (connect new-constraint)
        (if (not (memq new-constraint constraints))
          (set! constraints
          (cons new-constraint constraints))
          'ignore)
        (if (has-value?)
          (inform-about-value new-constraint)
          'ignore)
      'done)

       (define (dispatcher request)
         (cond ((eq? request 'has-value?) has-value?)
               ((eq? request 'get-value) value)
               ((eq? request 'set-value!) set-value!)
               ((eq? request 'forget-value!) forget-value)
               ((eq? request 'connect) connect)
               (else (error "Unknown request: CONNECTOR" request))))

       dispatcher))

(define (for-each-except exception proc list)
  (define (loop items)
    (cond ((null? items) 'done)
          ((eq? exception (car items))
           (loop (cdr items)))
          (else (proc (car items))
                (loop (cdr items)))))
  (loop list))

(define (inform-about-value constraint)
  (constraint 'process-value))
(define (inform-about-no-value constraint)
  (constraint 'forget-value))

(define (has-value? connector) 
  (connector 'has-value?))
(define (get-value connector)
  (connector 'get-value))
(define (set-value! connector new-val setter)
  ((connector 'set-value!) new-val setter))
(define (forget-value! connector retractor)
  ((connector 'forget-value) retractor))
(define (connect connector constraint)
  ((connector 'connect) constraint))

(define (constant value connector)
  (define (me request)
    (error "Unknown request: CONSTANT" request))
  (connect connector me)
  (set-value! connector value me)
  me)
; Test

(define a1 (make-connector))
(define a2 (make-connector))
(define sum (make-connector))

(define c1 (constant 1 a1))
(define c2 (constant 2 a2))

(define test (adder a1 a2 sum))





