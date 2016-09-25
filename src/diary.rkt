#lang racket/base

(require racket/list
         "square.rkt")

(provide new-diary visit visited-diary?)

(struct diary (to-index visited-list))

(define (new-diary width height)
  (define (to-index sq)
    (+ (* width (square-y sq)) (square-x sq)))
  (define visited-list
    (make-list (* width height) #f))
  (diary to-index visited-list))

(define (visit sq D)
  (diary
    (diary-to-index D)
    (list-set (diary-visited-list D) ((diary-to-index D) sq) #t)))

(define (visited-diary? sq D)
  (list-ref (diary-visited-list D) ((diary-to-index D) sq)))
