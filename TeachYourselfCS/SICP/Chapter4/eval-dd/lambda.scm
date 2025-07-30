(define (install-eval-lambda-pkg)
  (define (eval-lambda exp env)
    (make-procedure (procedure-args exp)
                    (procedure-body exp)
                    env))

  (put 'eval 'lambda eval-lambda)
  'install-eval-lambda-pkg-ok)
(install-eval-lambda-pkg)

(define (install-eval-begin-pkg)
  (define (eval-begin exp env)
    (eval-sequence (begin-actions exp) env))

  
  (define (begin-actions exp)
    (cdr exp))
  (define (first-action exp)
    (car exp))
  
  (put 'eval 'begin eval-begin)
  'install-eval-begin-pkg)
