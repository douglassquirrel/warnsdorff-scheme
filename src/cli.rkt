#lang racket/base

(require racket/cmdline)

(provide get-cl-params)

(define default-params
  (hash 'print-tour #f
        'tiebreak   'squirrel-cull))

(define (get-cl-params)
  (define params (hash-copy default-params))
  (command-line
    #:usage-help
      "Computes a Warnsdorff knight's tour on a square board of given size."
    #:once-each
      (("--print-tour") "Print the squares visited during the computed tour"
        (hash-set! params 'print-tour #t))
      (("--tiebreak") method ("Select tiebreak method. Choices are:"
                              "'random' for a random selection;"
                              "'farthest' for the move farthest from centre;"
                              "'squirrel-cull' for the Squirrel-Cull method; or"
                              "a permutation of 12345678 for a fixed ordering."
                              "Squirrel-Cull is the default method.")
        (hash-set! params 'tiebreak method))
    #:args (size)
      (hash-set! params 'size (string->number size)))
  (hash->list params))
