(load "eval-dd/utilities.scm")
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
          (cond ((else-clause? first)
                 (if (null? rest)
                  (sequence->exp (clause-actions first))
                  (error "ELSE clause isn't last: COND->IF")))
                ((=>-clause? first) 
                 (eval-=> first rest))
                (else (make-if (clause-predicate first)
                               (sequence->exp (clause-actions first))
                               (expand-clauses rest)))))))

  (define (=>-clause? exp)
    (eq? (cadr exp) '=>))

  (define (eval-=> first rest)
    (let ((test (car first))
          (recepient (caddr first)))
      (make-if test
              (test recepient)
              (expand-clauses rest))))


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