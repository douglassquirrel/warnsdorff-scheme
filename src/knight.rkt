#lang racket/base

(require racket/function
         racket/list
         "board.rkt"
         "square.rkt"
         "squirrel-cull.rkt"
         "util.rkt")

(provide square-info-sq square-info-tied tour)

(struct square-info (sq tied))

(define (current-min-degree-moves B)
  (argmin-all (curryr degree B) (current-legal-moves B)))

(define (is-currently-tied? B)
  (> (length (current-min-degree-moves B)) 1))

(define (get-current-square-info B)
  (square-info (current-square B) (is-currently-tied? B)))

(define (move-warnsdorff B tiebreak)
  (move-to (tiebreak (current-min-degree-moves B) B) B))

(define (tour B tiebreak)
  (unfold get-current-square-info
          (curryr move-warnsdorff tiebreak)
          B tour-over?))
