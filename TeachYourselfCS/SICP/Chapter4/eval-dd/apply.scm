(load "eval-dd/utilities.scm")

(define (install-eval-apply-pkg)
  (define (eval-apply exp env)
    (apply (eval (operator exp) env)
           (list-of-values (operands exp) env)))

  (define (apply procedure arguments)
          (cond ((primitive-procedure? procedure)
                (apply-primitive-procedure procedure arguments))
                ((compound-procedure? procedure)
                (eval-sequence
                    (procedure-body procedure)
                    (extend-environment
                      (procedure-parameters procedure)
                      arguments
                      (procedure-environment procedure))))
                (else
                (error
                  "Unknown procedure type: APPLY" procedure))))

  (define (list-of-values exps env)
    (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))


  (put 'eval 'application eval-apply)
  'install-eval-apply-pkg-ok)

(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
  (primitive-implementation proc) args))

(define (primitive-implementation proc) (cadr proc))

;(define primitive-procedures
;  (list (list 'car car)
;        (list 'cdr cdr)
;        (list '+ +)
;        (list 'null? null?)
;        (list 'cons cons)))
;  
;(define primitive-procedure-names
;  (map car primitive-procedures))
;
;(define primitive-procedure-objects
;  (map (lambda (proc) ((list 'primitive (cadr proc))))
;        primitive-procedures))
    

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))

