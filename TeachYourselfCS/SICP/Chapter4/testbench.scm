(define (eval exp env)
    (let* ((type (get-type exp))
           (proc (get 'eval type)))
        (if proc
            (proc exp env)
            (error "Unknown type: EVAL" exp))))

(define (intall-eval-type1-pkg)
    (define (eval exp env) 'a)
    (put 'eval 'type1 eval))

(define (intall-eval-type2-pkg)
    (define (eval exp env) 'b)
    (put 'eval 'type2 eval))

(define (intall-eval-type3-pkg)
    (define (eval exp env) 'c)
    (put 'eval 'type3 eval))

(define (get-type exp)
    (car exp))