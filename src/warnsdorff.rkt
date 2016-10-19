#lang racket/base

(require racket/dict
         racket/string
         "board.rkt"
         "cli.rkt"
         "knight.rkt"
         "square.rkt")

(define cl-params (get-cl-params))
(define size (dict-ref cl-params 'size))
(define tiebreak (dict-ref cl-params 'tiebreak))

(printf "Computing tour on square board of size ~a using tiebreak ~a\n"
        size tiebreak)

(define B (new-board size size (square 1 1)))
(define T (tour B))

(if (dict-ref cl-params 'print-tour)
  (displayln (string-join (map square-format T)))
  (void))

(define num-squares (* size size))
(if (= (length T) num-squares)
  (printf "Successfully visited all ~a squares.\n" num-squares)
  (printf "Failed - visited only ~a of ~a squares.\n" (length T) num-squares))
