#lang racket/base

(require racket/function)

(provide square delta
         apply-delta distance knight-deltas moves-from
         square-format square-x square-y)

(struct square (x y) #:transparent)
(struct delta (x y) #:transparent)

(define (square-format sq) (format "[~a,~a]" (square-x sq) (square-y sq)))

(define (apply-delta s d)
  (square
    (+ (square-x s) (delta-x d))
    (+ (square-y s) (delta-y d))))

(define knight-deltas
  (list
    (delta -2 1)
    (delta -1 2)
    (delta 1 2)
    (delta 2 1)
    (delta 2 -1)
    (delta 1 -2)
    (delta -1 -2)
    (delta -2 -1)))

(define (moves-from s)
  (map (curry apply-delta s) knight-deltas))

(define (square-num x) (* x x))
(define (distance a b)
  (+ (square-num (- (square-x a) (square-x b)))
     (square-num (- (square-y a) (square-y b)))))
