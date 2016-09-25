#lang racket/base

(require "board.rkt" "util.rkt")

(provide tour)

(define (move-simple B)
  (move-to (car (legal-moves (current B) B)) B))

(define (move-warnsdorff-simple B)
  (define all-moves
    (legal-moves (current B) B))
  (define degrees
    (map (lambda (s)
      (degree s B))
         all-moves))
  (define min-degree
    (apply min degrees))
  (define w-moves
    (filter (lambda (s) (= min-degree (degree s B))) all-moves))
  (move-to (car w-moves) B))

(define (tour B)
  (unfold current move-warnsdorff-simple B tour-over?))
