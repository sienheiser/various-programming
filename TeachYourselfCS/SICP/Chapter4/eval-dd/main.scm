(load "eval-dd/quote.scm")
(load "eval-dd/assignment.scm")
(load "eval-dd/definition.scm")
(load "eval-dd/if.scm")
(load "eval-dd/begin.scm")
(load "eval-dd/apply.scm")
(load "eval-dd/utilities.scm")

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

(install-eval-quote-pkg)
(install-eval-assignment-pkg)
(install-eval-definition-pkg)
(install-eval-if-pkg)
(install-eval-begin-pkg)
(install-eval-cond-pkg)
(install-eval-apply-pkg)

(define env (list (make-frame (list 'y) (list 2))))
(define if-exp '(if 1 1 0))
(define lambda-exp '(lambda (x y z) (+ x y z)))
(define begin-exp  '(begin 1 2))
(define bla-exp '(1 2 3))
(define cond-exp '(cond (1 1) (else 2)))
(define apply-exp '(application primitive + (1 2)))
(define exp '(define x 4))

