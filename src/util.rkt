#lang racket/base

(require racket/function
         racket/list)

(provide add1 sub1 between?
         to-boolean
         unfold in? first-match argmin-all
         string->string-list)

(define (add1 n) (+ n 1))
(define (sub1 n) (- n 1))

(define (between? n low high)
  (and (>= n low) (<= n high)))

(define (to-boolean x) (if x #t #f))

(define (unfold make-val next-val init stop?)
  (if (stop? init)
    (cons (make-val init) null)
    (cons
      (make-val init)
      (unfold make-val next-val (next-val init) stop?))))

(define in? (compose to-boolean member))

(define first-match (compose car filter))

(define (argmin-all p L)
    (define min (p (argmin p L)))
    (filter (lambda (x) (= (p x) min)) L))

(define (string->string-list s) (map string (string->list s)))
