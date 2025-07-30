(load "eval-dd/utilities.scm")
(define (install-eval-assignment-pkg)
  (define (eval-assignemnt exp env)
    (set-variable-value! (assignment-variable exp)
                     (eval (assignment-value exp) env)
                     env))

  (define (set-variable-value! variable value env)
    (define (env-loop env)
      (define (scan vars vals)
        (cond ((null? vars)
               (env-loop (enclosing-environment env)))
              ((eq? (car vars) variable) (set-car! vals value))
              (else (scan (cdr vars) (cdr vals)))))
      (if (eq? the-empty-environment env)
        (error "UNBOUND variable SET" variable)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
    (env-loop env)
    'set-variable-value!-ok)

  

  (define (assignment-variable exp) (cadr exp))
  (define (assignment-value exp) (caddr exp))

  (put 'eval 'assignment eval-assignemnt)
  'eval-assignment-pkg-ok)
