(define (install-eval-lambda-pkg)
  (define (eval-lambda exp env)
    (make-procedure (procedure-args exp)
                    (procedure-body exp)
                    env))

  (put 'eval 'lambda eval-lambda)
  'install-eval-lambda-pkg-ok)
