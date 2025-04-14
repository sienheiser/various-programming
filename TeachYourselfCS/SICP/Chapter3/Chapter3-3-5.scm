; Celsius-Farenhite

(define C (make-connector))
(define F (make-connector))

(define (celsius-fahrenhite-converter c f)
    (let ((u (make-connector))
          (v (make-connector))
          (w (make-connector))
          (x (make-connector))
          (y (make-connector)))
         (multiplier c w u)
         (multiplier v x u)
         (adder v y f)
         (constant 9 w)
         (constant 5 x)
         (constant 32 y)
         'ok))


(define (probe m t)
    (cond ((eq? m "Celsius temp") (get-celsius t))
          ((eq? m "Fahrenhite temp") (get-fahrenhite t))
          (else (error "Invalid Temperature Scale: " m))))