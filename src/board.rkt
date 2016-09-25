#lang racket/base

(require "square.rkt")
(require "util.rkt")

(provide new-board current legal-moves visited? move-to degree tour-over?)

(define (new-diary width height)
  (define (to-index sq)
    (+ (* width (y-coord sq)) (x-coord sq)))
  (define visited-list
    (list-fill #f (* width height)))
  (cons to-index visited-list))

(define (to-index D)
  (car D))

(define (visited-list D)
  (cdr D))

(define (visit sq D)
  (cons
    (to-index D)
    (list-set ((to-index D) sq) (visited-list D) #t)))

(define (visited-diary? sq D)
  (list-ref (visited-list D) ((to-index D) sq)))

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

(define (diary B)
  (cadddr B))

(define (inbounds? sq B)
  (and
    (between? (x-coord sq) 0 (sub1 (width B)))
    (between? (y-coord sq) 0 (sub1 (height B)))))

(define (visited? sq B)
  (visited-diary? sq (diary B)))

(define (legal? sq B)
  (and (inbounds? sq B) (not (visited? sq B))))

(define (legal-moves sq B)
  (filter (moves-from sq) (lambda (s)
    (legal? s B))))

(define (move-to sq B)
  (list
    (width B)
    (height B)
    sq
    (visit sq (diary B))))

(define (degree sq B)
  (length (legal-moves sq B)))

(define (tour-over? B)
  (zero? (degree (current B) B)))
