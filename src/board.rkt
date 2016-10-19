#lang racket/base

(require racket/function
         "diary.rkt"
         "square.rkt"
         "util.rkt")

(provide new-board board-width centre current-square current-legal-moves
         degree move-to tour-over? unvisited?)

(struct board (width height current diary))
(define current-square board-current)

(define (new-board width height start)
  (define D (new-diary width height))
  (board width height start (visit start D)))

(define (inbounds? sq B)
  (and
    (between? (square-x sq) 1 (board-width B))
    (between? (square-y sq) 1 (board-height B))))

(define (visited? sq B)
  (visited-diary? sq (board-diary B)))

(define unvisited? (negate visited?))

(define (legal? sq B)
  (and (inbounds? sq B) (unvisited? sq B)))

(define (legal-moves sq B)
  (filter (curryr legal? B) (moves-from sq)))

(define (current-legal-moves B) (legal-moves (current-square B) B))

(define (move-to sq B)
  (struct-copy board B
               (current sq)
               (diary (visit sq (board-diary B)))))

(define (degree sq B)
  (length (legal-moves sq B)))

(define (tour-over? B)
  (zero? (degree (board-current B) B)))

(define (centre B)
  (square (/ (board-width B) 2) (/ (board-height B) 2)))
