#lang racket/base

(require racket/function
         racket/list
         "board.rkt"
         "square.rkt"
         "squirrel-cull.rkt"
         "util.rkt")

(provide tour)

(define (move-warnsdorff B tiebreak)
  (define min-degree-moves
    (argmin-all (curryr degree B) (current-legal-moves B)))
  (move-to (tiebreak min-degree-moves B) B))

(define (tour B tiebreak)
  (unfold current-square (curryr move-warnsdorff tiebreak) B tour-over?))
