#lang racket/base

(require racket/function
         racket/list
         "board.rkt"
         "util.rkt")

(provide tour)

(define (move-simple B)
  (move-to (car (legal-moves (board-current B) B)) B))

(define (move-warnsdorff B tiebreak)
  (define all-moves
    (legal-moves (board-current B) B))
  (define min-degree-moves
    (car (group-by (curryr degree B) all-moves)))
  (move-to (tiebreak min-degree-moves) B))

(define move-warnsdorff-simple (curryr move-warnsdorff car))

(define (tour B)
  (unfold board-current move-warnsdorff-simple B tour-over?))
