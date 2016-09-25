#lang racket/base

(require racket/function)

(provide add1 sub1 unfold between?)

(define (add1 n) (+ n 1))

(define (sub1 n) (- n 1))

(define (unfold make-val next-val init stop?)
  (if (stop? init)
    (cons (make-val init) null)
    (cons
      (make-val init)
      (unfold make-val next-val (next-val init) stop?))))

(define (between? n low high)
  (and (>= n low) (<= n high)))
