(define (split op1 op2)
  (define (foo painter n)
    (if (= n 0)
      painter
      (let ((smaller (foo painter (- n 1))))
        (op1 painter (op2 smaller smaller)))))
  foo)


;Exercise 2.46 Procedures for vectors
(define make-vector cons)
(define x-vect car)
(define y-vect cdr)


(define (vect-arithmetic op)
  (lambda (u v)
    (make-vector (op (x-vect u) (x-vect v))
                 (op (y-vect u) (y-vect v)))))
(define add-vect (vect-arithmetic +))
(define sub-vect (vect-arithmetic -))

(define (scale-vect s v)
  (make-vector (* s (x-vect v))
               (* s (y-vect v))))


;Exercise 2.47 define make-frame
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (make-frameV2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define frame-origin car)
(define frame-edge1 cadr)
(define frame-edge2 caddr)

(define frame-edge2V2 cddr)

;------------------------------------------
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame frame)
      (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
                (scale-vect (ycor-vect v) (edge2-frame frame))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
      (lambda (segment)
        (drawline
          ((frame-coord-map frame)
           (start-segment segment))
          ((frame-coord-map frame)
           (end-segment segment))))
      segment-list)))

;Exercise 2.48
(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

;Exercise  2.49 Use segments->painter to
;a) make outline fram painter
(define outline-segments
  (list (make-segment (make-vect 0 0) (make-vect 0 1))
        (make-segment (make-vect 0 1) (make-vect 1 1))
        (make-segment (make-vect 1 1) (make-vect 0 1))
        (make-segment (make-vect 0 1) (make-vect 0 0)))
(define outline (segments->painter outline-segments))

;b) make painter that paints x over a given frame
(define x-segments
  (list (make-segment (make-vect 0 1) (make-vect 1 0))
        (make-segment (make-vect 1 1) (make-vect 0 0))))
(define x-painter (segments->painter x-segments))

;-------------------------------------------------------


(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-segment
                   new-origin
                   (sub-vect (m corner1) new-origin)
                   (sub-vect (m corner2) new-origin)))))))


(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))


(define (shrink-to-upper-right painter)
  (transform-painter painter
                     (make-vect 0.5 0.5)
                     (make-vect 1.0 0.5)
                     (make-vect 0.5 1.0)))



(define (rotate90 painter)
  (tranform-painter painter
                    (make-vect 0.0 1.0)
                    (make-vect 0.0 0.0)
                    (make-vect 1.0 1.0)


