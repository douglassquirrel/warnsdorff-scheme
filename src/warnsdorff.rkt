#lang racket/base

(require "knight.rkt" "board.rkt" "square.rkt")

(define B (new-board 15 15 (square 0 0)))
(define T (tour B))
(for-each (lambda (sq) (display (square-format sq))) T)
(newline)
(println (length T))
