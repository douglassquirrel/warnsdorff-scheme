(define (identity x) x)

(define (add1 n)
  (+ n 1))

(define (sub1 n)
  (- n 1))

(define nil '())

(define (empty? a)
  (zero? (length a)))

(define (negate p)
  (lambda (x)
    (not (p x))))

(define non-empty? (negate empty?))

(define (foldr func end lst)
  (if (null? lst)
    end
    (func (car lst) (foldr func end (cdr lst)))))

(define (foldl func accum lst)
  (if (null? lst)
    accum
    (foldl func (func accum (car lst)) (cdr lst))))

(define (unfold make-val next-val init stop?)
  (if (stop? init)
    (cons (make-val init) nil)
    (cons
      (make-val init)
      (unfold make-val next-val (next-val init) stop?))))

(define (unfold-simple next-val init stop?)
  (unfold identity next-val init stop?))

(define (range start end)
  (unfold-simple add1 start (lambda (x)
    (equal? x end))))

(define (every? a p)
  (empty? (filter a (negate p))))

(define (filter L p)
  (define (filter-one result-list x)
    (if (p x)
      (append result-list (list x))
      result-list))
  (foldl filter-one nil L))

(define (qsort a)
  (cond
    ((empty? a) a)
    (else
      (let* ((pivot (car a))
      (low-bucket? (lambda (x)
        (<= x pivot)))
      (high-bucket? (lambda (x)
        (> x pivot))))
        (append
          (qsort (filter (cdr a) low-bucket?))
          (list pivot)
          (qsort (filter (cdr a) high-bucket?)))))))

(define (list-fill v n)
  (if (zero? n)
    nil
    (cons v (list-fill v (sub1 n)))))

(define (list-set n L val)
  (if (zero? n)
    (cons val (cdr L))
    (cons (car L) (list-set (sub1 n) (cdr L) val))))

(define (between? n low high)
  (and (>= n low) (<= n high)))
