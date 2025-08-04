(load "eval-dd/utilities.scm")

(define (install-eval-and-pkg)
    (define (eval-and exp env)
        (eval-pred (cdr exp) env))
    
    (define (eval-pred exps env)
        (cond ((last-exp? exps)
               (eval (first-exp exps) env))
              (else
                  (if (eq? (eval (first-exp exps) env) #f)
                      #f
                      (eval-pred (rest-exps exps) env)))))
    (put 'eval 'and eval-and)
    'install-eval-and-pkg-okay)
