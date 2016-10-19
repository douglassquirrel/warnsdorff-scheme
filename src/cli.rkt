#lang racket/base

(require racket/cmdline)

(provide get-cl-params)

(define default-params
  (hash 'print-tour #f))

(define (get-cl-params)
  (define params (hash-copy default-params))
  (command-line
    #:usage-help
      "Computes a Warnsdorff knight's tour on a square board of given size."
    #:once-each
      (("--print-tour") "Print the squares visited during the computed tour"
        (hash-set! params 'print-tour #t))
    #:args (size) (hash-set! params 'size (string->number size)))
  (hash->list params))
