#lang racket/base

(require racket/dict
         racket/string
         "board.rkt"
         "cli.rkt"
         "knight.rkt"
         "square.rkt"
         "squirrel-cull.rkt")

(define cl-params (get-cl-params))
(define size (dict-ref cl-params 'size))

(define B (new-board size size (square 1 1)))
(define T (tour B))

(define num-squares (* size size))
(if (dict-ref cl-params 'print-tour)
  (displayln (string-join (map square-format T)))
  (void))
(if (= (length T) num-squares)
  (printf "Successfully visited all ~a squares.\n" num-squares)
  (printf "Failed - visited only ~a of ~a squares.\n" (length T) num-squares))
