
(define (install-eval-quote-pkg)
  (define (eval-quote exp env)
    (cadr exp))
  (put 'eval 'quote eval-quote)
  'eval-quote-pkg-ok)
