#lang racket/base

(require racket/list
         "square.rkt")

(provide new-diary visit visited-diary?)

(struct diary (square-to-index visited-list))

(define (index-of sq D) ((diary-square-to-index D) sq))
(define visited-list diary-visited-list)

(define (new-diary width height)
  (diary (lambda (sq) (+ (* width (square-y sq)) (square-x sq)))
         (make-list (* width height) #f)))

(define (visit sq D)
  (struct-copy diary D
               (visited-list (list-set (visited-list D) (index-of sq D) #t))))

(define (visited-diary? sq D)
  (list-ref (visited-list D) (index-of sq D)))
