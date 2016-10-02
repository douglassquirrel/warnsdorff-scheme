#lang racket/base

(require racket/function
         racket/list
         "board.rkt"
         "square.rkt"
         "squirrel-cull.rkt"
         "util.rkt")

(provide tour)

(define (move-simple B)
  (move-to (car (current-legal-moves B))))

(define (move-warnsdorff B tiebreak)
  (define min-degree-moves
    (argmin-all (curryr degree B) (current-legal-moves B)))
  (move-to (tiebreak min-degree-moves B) B))

(define move-warnsdorff-simple
  (curryr move-warnsdorff (lambda (moves B) (car moves))))

(define (tour B ordering)
  (define tiebreak (make-ordering-tiebreak ordering))
  (unfold current-square (curryr move-warnsdorff tiebreak) B tour-over?))
