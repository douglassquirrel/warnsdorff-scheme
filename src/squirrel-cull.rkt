#lang racket/base

(require racket/function
         "board.rkt"
         "square.rkt"
         "util.rkt")

(provide make-ordering-tiebreak)

(define (make-ordering-tiebreak ordering-string)
    (define ordering-list
        (map (compose sub1 string->number)
             (string->string-list ordering-string)))
    (define ordered-deltas
        (map (curry list-ref knight-deltas) ordering-list))
    (define (ordered-moves-from s)
        (map (curry apply-delta s) ordered-deltas))

    (lambda (moves B)
        (first-match (curryr in? moves)
                     (ordered-moves-from (current-square B)))))
