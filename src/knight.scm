(load (ts-path "board.scm"))

(define (move-simple B)
  (move-to (car (legal-moves (current B) B)) B))

(define (move-warnsdorff-simple B)
  (define all-moves
    (legal-moves (current B) B))
  (define degrees
    (map (lambda (s)
      (degree s B))
         all-moves))
  (define min-degree
    (apply min degrees))
  (define w-moves
    (filter all-moves (lambda (s)
      (= min-degree (degree s B)))))
  (move-to (car w-moves) B))

(define (tour B)
  (unfold current move-warnsdorff-simple B tour-over?))
