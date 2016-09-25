#lang racket/base

(require racket/function)

(provide add1 sub1 non-null? unfold unfold-simple between?)

(define (add1 n) (+ n 1))

(define (sub1 n) (- n 1))

(define non-null? (negate null?))

(define (unfold make-val next-val init stop?)
  (if (stop? init)
    (cons (make-val init) null)
    (cons
      (make-val init)
      (unfold make-val next-val (next-val init) stop?))))

(define (unfold-simple next-val init stop?)
  (unfold identity next-val init stop?))

(define (between? n low high)
  (and (>= n low) (<= n high)))
