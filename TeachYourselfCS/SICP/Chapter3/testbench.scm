
(define (adder a1 a2 sum)
    (define (process-value)
        (cond ((and (has-value? a1) (has-value? a2))
               (set-value! sum (+ (get-value a1)
                                  (get-value a2))))
              ((and (has-value? sum) (has-value? a1))
               (set-value! sum (- (get-value sum)
                                  (get-value a1))))
              ((and (has-value? sum) (has-value? a2))
               (set-value! sum (- (get-value sum)
                                  (get-value a2))))))
    (define (dispatch m)
        (cond ((eq? m 'process-value) process-value)
              (else (error "Unkown case: ADDER" m))))
    dispatch)

(define (process-value operator)
    ((operator 'process-value)))
          
(define (has-value? connector)
    ((connector 'has-value?)))

(define (set-value! connector value)
    ((connector 'set-value!) value))

(define (get-value connector)
    ((connector 'get-value)))

(define (make-connector)
    (let ((value false))
         (define (set-value! new-value)
            (set! value new-value))
         (define (has-value?)
            (if value
                true
                false))
         (define (get-value) value)
         (define (dispatch m)
            (cond ((eq? m 'has-value?) has-value?)
                  ((eq? m 'set-value!) set-value!)
                  ((eq? m 'get-value) get-value)
                  (else (error "Unkown request: CONNECTOR" m))))
         dispatch))


(define a1 (make-connector))
(define a2 (make-connector))
(define sum (make-connector))

(define ad (adder a1 a2 sum))
