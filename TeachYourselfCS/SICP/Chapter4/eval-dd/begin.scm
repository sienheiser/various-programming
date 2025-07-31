(load "eval-dd/utilities.scm")

(define (install-eval-begin-pkg)
  (define (eval-begin exp env)
    (eval-sequence (begin-actions exp) env))
  (define (eval-sequence exps env)
    (cond ((last-exp? exps)
           (eval (first-exp exps) env))
          (else
           (eval (first-exp exps) env)
           (eval-sequence (rest-exps exps) env))))
  (define (begin-actions exp) (cdr exp))
  (put 'eval 'begin eval-begin))