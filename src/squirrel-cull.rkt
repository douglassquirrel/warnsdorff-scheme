#lang racket/base

(require racket/function
         "board.rkt"
         "sc-data.rkt"
         "square.rkt"
         "util.rkt")

(provide make-sc-tiebreak)

(define (make-sc-tiebreak size)
  (define sc-table (make-sc-table size))
  (define (row-matches? row B)
    (or (sc-row-end? row)
        (unvisited? (sc-row-square row) B)))
  (lambda (moves B)
    (define matching-row (findf (curryr row-matches? B) sc-table))
    ((sc-row-tiebreak matching-row) moves B)))
