#lang racket/base

(require racket/cmdline
         racket/dict)

(provide get-cl-params)

(define (get-cl-params)
  (define defaults '())
  (command-line
    #:args (size) (dict-set defaults 'size (string->number size))))
