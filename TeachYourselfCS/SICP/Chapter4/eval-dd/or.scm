(load "eval-dd/utilities.scm")

(define (install-eval-or-pkg)
    (define (eval-or exp env)
        (eval-pred (cdr exp) env))
    
    (define (eval-pred exps env)
        (cond ((last-exp? exps)
               (eval (first-exp exps) env))
              (else
                  (if (eq? (eval (first-exp exps) env) #t)
                      #t
                      (eval-pred (rest-exps exps) env)))))
    (put 'eval 'or eval-or)
    'install-eval-or-pkg-okay)