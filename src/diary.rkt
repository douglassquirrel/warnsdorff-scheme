#lang racket/base

(require racket/list
         "square.rkt"
         "util.rkt")

(provide new-diary visit visited-diary?)

(define (new-diary width height)
  (make-list (add1 width) (make-list (add1 height) #f)))

(define (visit sq diary)
  (define x (square-x sq))
  (define y (square-y sq))
  (list-set diary x (list-set (list-ref diary x) y #t)))

(define (visited-diary? sq diary)
  (define x (square-x sq))
  (define y (square-y sq))
  (list-ref (list-ref diary x) y))
