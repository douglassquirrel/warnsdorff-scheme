(define (square x y)
  (cons x y))

(define (delta x y)
  (cons x y))

(define (x-coord s)
  (car s))

(define (y-coord s)
  (cdr s))

(define (apply-delta s d)
  (square
    (+ (x-coord s) (x-coord d))
    (+ (y-coord s) (y-coord d))))

(define knight-deltas
  (list
    (delta -2 -1)
    (delta -2 1)
    (delta -1 -2)
    (delta -1 2)
    (delta 1 -2)
    (delta 1 2)
    (delta 2 -1)
    (delta 2 1)))

(define (moves-from s)
  (map (lambda (d)
    (apply-delta s d))
       knight-deltas))
