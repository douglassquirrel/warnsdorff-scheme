#lang racket/base

(require racket/cmdline)

(provide get-cl-params)

(define default-params
  (make-hash '()))

(define (get-cl-params)
  (define params (hash-copy default-params))
  (command-line
    #:args (size) (hash-set! params 'size (string->number size)))
  params
)
