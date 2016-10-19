#lang racket/base

(require racket/function
         racket/list
         racket/random
         "board.rkt"
         "square.rkt"
         "squirrel-cull.rkt")

(provide make-tiebreak)

(define (random-tiebreak moves B)
  (random-ref moves))

(define (distance-to-centre sq B)
  (distance sq (centre B)))
(define (farthest-tiebreak moves B)
  (argmax (curryr distance-to-centre B) moves))

(define (make-tiebreak method size)
  (cond ((equal? method "random") random-tiebreak)
        ((equal? method "squirrel-cull") (make-sc-tiebreak size))
        ((equal? method "farthest") farthest-tiebreak)
        ;fixed move-ordering
        (else #f)))
