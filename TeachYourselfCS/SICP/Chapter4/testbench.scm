;What are the fundemental forms?
;numbers
;quotes
;variables
;lambda functions
;if statements
;conditionals

;eval 1 {} => 1
;eval x {x:1} => 1
;eval 'a {} => a
;eval (set! x 2) {x:1} => {x:2}
;eval (define x 2) {} => {x:2}
;eval (if pred exp1 exp2) {} => exp1 if true else exp2
;eval (lambda (x) (+ x y)) {y:2} => (make-procedure (x)
;                                                   (+ x y)
;                                                   env)
;eval-begin (begin exp1 exp2 exp3) env => (eval-sequence (begin-actions exp1 exp2 exp3) env)
;eval-cond (cond (pred1 exp1) (pred2 exp2) (else exp3)) => (if pred1
;                                                              exp1
;                                                              (if pred2
;                                                                  exp2
;                                                                  exp3))
;eval-application (apply exp) => (apply (eval (operator exp) env)
;                                       (list-of-values (operands exp) env)))
;eval-application (+ 1 2) => (apply (eval + env)
;                                   ((1 2) env)))

(define (eval exp env)
    (cond ((self-evaluating? exp) exp)
          ((variable? exp) (eval-variable exp env))
          ((quote? exp) (eval-quote exp))
          ((assignment? exp) (eval-assignment exp env))
          ((definition? exp) (eval-definition exp env))
          ((if? exp) (eval-if exp))
          ((lambda? exp) (eval-lambda exp env))
          ((begin? exp) (eval-begin exp env))
          ((cond? exp) (eval-cond exp env))
          ((application exp) (eval-application exp env))
          (else (error "Unkown expression type: EVAL" exp))))

(define (eval-variable exp env)
    (lookup exp env))

(define (eval-quote exp)
    (get-text-from exp))

(define


