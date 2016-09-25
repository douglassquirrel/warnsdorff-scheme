#lang racket/base

(require racket/function
         racket/list
         "board.rkt"
         "util.rkt")

(provide tour)

(define (move-simple B)
  (move-to (car (current-legal-moves B))))

(define (move-warnsdorff B tiebreak)
  (define min-degree-moves
    (car (group-by (curryr degree B) (current-legal-moves B))))
  (move-to (tiebreak min-degree-moves) B))

(define move-warnsdorff-simple (curryr move-warnsdorff car))

(define (tour B)
  (unfold current-square move-warnsdorff-simple B tour-over?))
