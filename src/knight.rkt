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
    (car (group-by (curryr degree B) (current-legal-moves B))))
  (move-to (tiebreak min-degree-moves B) B))

(define move-warnsdorff-simple
  (curryr move-warnsdorff (lambda (moves B) (car moves))))

(define test-tiebreak (make-ordering-tiebreak "18347625"))

(define (tour B)
  (unfold current-square (curryr move-warnsdorff test-tiebreak) B tour-over?))
