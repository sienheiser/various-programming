(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) '()))

;(define *op-table* (make-hash))
;
;(define (put op type proc)
;  (hash-set! *op-table* (list op type) proc))
;
;(define (get op type)
;  (hash-ref *op-table* (list op type) '()))

(define (variable? exp) (symbol? exp))
(define apply-in-underlying-scheme apply)

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        (else (let* ((type (get-type exp))
                     (proc (get 'eval type)))
                (if (not (null? proc))
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
    (env-loop env)
    'set-variable-value!-ok)

  

  (define (assignment-variable exp) (cadr exp))
  (define (assignment-value exp) (caddr exp))

  (put 'eval 'assignment eval-assignemnt)
  'eval-assignment-pkg-ok)

(install-eval-assignment-pkg)

(define (install-eval-definition-pkg)
  (define (eval-definition exp env)
    (define-variable! (definition-variable exp)
                      (eval (definition-value exp) env)
                      env))
  (define (definition-variable exp)
    (cadr exp))
  (define (definition-value exp)
    (caddr exp))

  (define (define-variable! variable value env)
    (let ((frame (first-frame env)))
      (define (scan vars vals)
        (cond ((null? vars)
               (add-binding-to-frame! variable value frame))
              ((eq? (car vars) variable) (set-car! vals value))
              (else (scan (cdr vars) (cdr vals)))))
      (scan (frame-variables frame) (frame-values frame)))
      'define-variable-ok)
  (put 'eval 'define eval-definition)
  'eval-definition-pkg-ok)
(install-eval-definition-pkg)


(define (install-eval-if-pkg)
  (define (eval-if exp env)
    (let ((pred (if-predicate exp))
          (consequent (if-consequent exp))
          (alternative (if-alternative exp)))
      (if (true? (eval pred env))
        (eval consequent env)
        (eval alternative env))))

  (define (if-predicate exp) (cadr exp))
  (define (if-consequent exp) (caddr exp))
  (define (if-alternative exp) (cadddr exp))

  (put 'eval 'if eval-if)
  'intstall-eval-if-pkg-ok)
(install-eval-if-pkg)

(define (install-eval-lambda-pkg)
  (define (eval-lambda exp env)
    (make-procedure (procedure-args exp)
                    (procedure-body exp)
                    env))
  (define (make-procedure args body env)
    '(procedure args body env))
  (define (procedure-args exp) (cadr exp))
  (define (procedure-body exp) (caddr exp))

  (put 'eval 'lambda eval-lambda)
  'install-eval-lambda-pkg-ok)
(install-eval-lambda-pkg)

(define (install-eval-begin-pkg)
  (define (eval-begin exp env)
    (eval-sequence (begin-actions exp) env))

(define (eval-sequence exps env)
  (cond ((last-exp? exps)
         (eval (first-exp exps) env))
        (else
         (eval (first-exp exps) env)
         (eval-sequence (rest-exps exps) env))))
  
  (define (begin-actions exp)
    (cdr exp))
  (define (first-action exp)
    (car exp))
  
  (put 'eval 'begin eval-begin)
  'install-eval-begin-pkg)

(install-eval-begin-pkg)


(define (install-eval-cond-pkg)
  (define (eval-cond exp env)
    (eval (cond->if exp) env))

  ;(cond (pred1 exp1) (pred2 exp2) (else exp3))
  (define (cond->if exp)
    (expand-clauses (cond-clauses exp)))
  
  (define (expand-clauses clauses)
    (if (null? clauses)
        'false
        (let ((first (car clauses))
              (rest (cdr clauses)))
          (if (else-clause? first) 
              (if (null? rest)
                (sequence->exp (clause-actions first))
                (error "ELSE clause isn't last: COND->IF"))
              (make-if (clause-predicate first)
                       (sequence->exp (clause-actions first))
                       (expand-clauses rest))))))

  (define (cond-clauses exp)
    (cdr exp))
  (define (else-clause? clause)
    (eq? (car clause) 'else))

  (define (clause-predicate clause)
    (car clause))

  (define (clause-actions clause)
    (cdr clause))

  (define (make-if predicate consequent alternative)
    (list 'if predicate consequent alternative))

  (define (sequence->exp seq)
    (cond ((null? seq) seq)
          ((last-exp? seq) (first-exp seq))
          (else (make-begin seq))))

  (define (make-begin seq) (cons 'begin seq))

  (put 'eval 'cond eval-cond)
  'install-eval-cond-pkg-ok)

  (install-eval-cond-pkg)



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

(define (last-exp? exp)
  (null? (cdr exp)))
(define (first-exp exp)
  (car exp))
(define (rest-exps exp)
  (cdr exp))




(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))


(define env (list (make-frame (list 'y) (list 2))))
(define if-exp '(if 1 1 0))
(define lambda-exp '(lambda (x y z) (+ x y z)))
(define begin-exp  '(begin 1 2))
(define bla-exp '(1 2 3))
(define cond-exp '(cond (1 1) (else 2)))
(define exp '(define x 4))

(define (true? x)
  (not (eq? x #f)))
