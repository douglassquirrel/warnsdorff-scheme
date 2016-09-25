#lang racket/base

(require "diary.rkt"
         "square.rkt"
         "util.rkt")

(provide new-board current legal-moves visited? move-to degree tour-over?)

(define (new-board width height start)
  (define D
    (new-diary width height))
  (list width height start (visit start D)))

(define (width B)
  (car B))

(define (height B)
  (cadr B))

(define (current B)
  (caddr B))

(define (board-diary B)
  (cadddr B))

(define (inbounds? sq B)
  (and
    (between? (square-x sq) 0 (sub1 (width B)))
    (between? (square-y sq) 0 (sub1 (height B)))))

(define (visited? sq B)
  (visited-diary? sq (board-diary B)))

(define (legal? sq B)
  (and (inbounds? sq B) (not (visited? sq B))))

(define (legal-moves sq B)
  (filter (lambda (s) (legal? s B)) (moves-from sq)))

(define (move-to sq B)
  (list
    (width B)
    (height B)
    sq
    (visit sq (board-diary B))))

(define (degree sq B)
  (length (legal-moves sq B)))

(define (tour-over? B)
  (zero? (degree (current B) B)))
