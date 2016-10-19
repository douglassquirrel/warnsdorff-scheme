#lang racket/base

(require racket/cmdline)

(provide get-cl-params)

(define default-params
  (hash))

(define (get-cl-params)
  (define params (hash-copy default-params))
  (command-line
    #:args (size) (hash-set! params 'size (string->number size)))
  (hash->list params))
