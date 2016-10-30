#lang racket/base

(require racket/dict
         racket/string
         "board.rkt"
         "cli.rkt"
         "knight.rkt"
         "square.rkt"
         "tiebreak.rkt")

(define cl-params (get-cl-params))
(define size (dict-ref cl-params 'size))
(define tiebreak-method (dict-ref cl-params 'tiebreak-method))

(printf "Computing tour on square board of size ~a using tiebreak ~a\n"
        size tiebreak-method)

(define B (new-board size size (square 1 1)))
(define tiebreak (make-tiebreak tiebreak-method size))
(define T (tour B tiebreak))

(define (format-boolean b)
  (if b "True" "False"))

(define (format-square-info si)
  (format "{'square':~a, 'tiebreak':~a}"
    (square-format (square-info-sq si))
    (format-boolean (square-info-tied si))))

(displayln size)
(if (dict-ref cl-params 'print-tour)
  (displayln (string-join (map format-square-info T) "\n"))
  (void))

(define num-squares (* size size))
(if (= (length T) num-squares)
  (printf "Successfully visited all ~a squares.\n" num-squares)
  (printf "Failed - visited only ~a of ~a squares.\n" (length T) num-squares))
