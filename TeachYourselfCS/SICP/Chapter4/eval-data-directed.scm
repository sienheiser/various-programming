(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) '()))

(define (variable? exp) (symbol? exp))
(define apply-in-underlying-scheme apply)

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        (else (let* ((type (get-type exp))
                     (proc (get 'eval type)))
                (if proc
                  (proc exp env)
                  (error "Unknown expression: EVAL" exp))))))

(define (get-type exp)
  (car exp))

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

(define (variable? exp) (symbol? exp))

(define (install-eval-quote-pkg)
  (define (eval-quote exp env)
    (cadr exp))
  (put 'eval 'quote eval-quote)
  'eval-quote-pkg-ok)

(install-eval-quote-pkg)


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
    (env-loop env))

  

  (define (assignment-variable exp) (cadr exp))
  (define (assignment-value exp) (caddr exp))

  (put 'eval 'assignment eval)
  'eval-assignment-pkg-ok)


(define the-empty-environment '())
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define (frame-variables frame)
  (if (null? frame)
    null
    (cons (caar frame) (frame-variables (cdr frame)))))
(define (frame-values frame)
  (if (null? frame)
    null
    (cons (cdar frame) (frame-values (cdr frame)))))






















































