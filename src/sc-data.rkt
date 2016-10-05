#lang racket/base

(require racket/function
         racket/list
         "board.rkt"
         "square.rkt"
         "util.rkt")

(provide make-sc-table sc-row-end? sc-row-square sc-row-tiebreak)

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

(struct sc-row (end? square tiebreak) #:transparent)

(define (make-sc-row row)
  (define tiebreak (make-ordering-tiebreak (fifth row)))
  (if (eq? (third row) 'end)
      (sc-row #t #f tiebreak)
      (sc-row #f (square (sub1 (third row)) (sub1 (fourth row))) tiebreak)))

(define (make-sc-table s)
  (map make-sc-row
    (filter (lambda (r) (equal-mod? s (first r) (second r)))
      (list ; val mod square-x            square-y            ordering
        (list 0   8   (- s 1)             (- s 2)             "34261578")
        (list 0   8   2                   2                   "87642135")
        (list 0   8   (- s 8)             1                   "51867342")
        (list 0   8   7                   (- s 3)             "51342678")
        (list 0   8   'end                'end                "21435678")

        (list 1   8   (- s 1)             (- s 2)             "34261578")
        (list 1   8   2                   2                   "87642135")
        (list 1   8   (- s 6)             (+ (/ (- s 1) 2) 5) "51324678")
        (list 1   8   'end                'end                "32481765")

        (list 2   8   6                   1                   "34261578")
        (list 2   8   3                   1                   "87642135")
        (list 2   8   (- s 15)            4                   "54132678")
        (list 2   8   10                  (- s 2)             "52431678")
        (list 2   8   5                   (- (/ s 2) 3)       "85647123")
        (list 2   8   'end                'end                "15746823")

        (list 3   8   (- s 1)             (- s 2)             "34625718")
        (list 3   8   (- s 6)             s                   "42681357")
        (list 3   8   2                   5                   "86512347")
        (list 3   8   (- s 10)            3                   "51867342")
        (list 3   8   (/ (- s 1) 2)       (- s 2)             "61825437")
        (list 3   8   'end                'end                "71642538")

        (list 4   8   (- s 1)             (- s 2)             "34261578")
        (list 4   8   2                   2                   "87642135")
        (list 4   8   (- s 8)             1                   "51867342")
        (list 4   8   10                  (- s 5)             "51342678")
        (list 4   8   13                  (+ (/ s 2) 1)       "86753421")
        (list 4   8   'end                'end                "78563421")

        (list 5   8   (- s 1)             (- s 2)             "34261578")
        (list 5   8   2                   2                   "87642135")
        (list 5   16  (- s 2)             (- (/ (- s 1) 2) 2) "51324678")
        (list 13  16  (- s 2)             (- (/ (- s 1) 2) 6) "51324678")
        (list 5   8   'end                'end                "15234678")

        (list 6   8   6                   1                   "34261578")
        (list 6   8   3                   1                   "87642135")
        (list 6   8   (- s 10)            1                   "54132678")
        (list 6   8   10                  (- s 2)             "52431678")
        (list 6   8   3                   (+ (/ s 2) 4)       "85647123")
        (list 6   8   'end                'end                "12453678")

        (list 7   8   (- s 1)             (- s 2)             "34625718")
        (list 7   8   (- s 6)             s                   "42681357")
        (list 7   8   2                   5                   "86512347")
        (list 7   8   (- s 6)             3                   "51867342")
        (list 7   8   (+ (/ (- s 1) 2) 1) (- s 2)             "61825437")
        (list 7   8   'end                'end                "61357284")))))
