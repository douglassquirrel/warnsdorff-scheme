#lang racket/base

(require racket/cmdline
         racket/list
         racket/string
         "board.rkt"
         "knight.rkt"
         "square.rkt"
         "squirrel-cull.rkt")

(define args (command-line #:args args args))
(define size (string->number (first args)))

(define B (new-board size size (square 0 0)))
(define T (tour B))

(define num-squares (* size size))
(displayln (string-join (map square-format T)))
(if (= (length T) num-squares)
  (printf "Successfully visited all ~a squares.\n" num-squares)
  (printf "Failed - visited only ~a of ~a squares.\n" (length T) num-squares))
