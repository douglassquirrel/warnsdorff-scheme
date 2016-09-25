#lang racket/base

(require racket/function)

(provide square square-x square-y square-format moves-from)

(struct square (x y) #:transparent)
(struct delta (x y))

(define (square-format sq) (format "[~a,~a]" (square-x sq) (square-y sq)))

(define (apply-delta s d)
  (square
    (+ (square-x s) (delta-x d))
    (+ (square-y s) (delta-y d))))

(define knight-deltas
  (list
    (delta -2 -1)
    (delta -2 1)
    (delta -1 -2)
    (delta -1 2)
    (delta 1 -2)
    (delta 1 2)
    (delta 2 -1)
    (delta 2 1)))

(define (moves-from s)
  (map (curry apply-delta s) knight-deltas))
