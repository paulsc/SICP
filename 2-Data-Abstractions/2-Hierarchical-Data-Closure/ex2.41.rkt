#lang racket

; Write a procedure to find all ordered triples of distinct positive integers
; i, j, and k less than or equal to a given integer n that sum to a given 
; integer s.

(require "seqlib.rkt")

; (flatmap proc seq)

(define (unique-triplets n)
  (flatmap
    (lambda (i)
      (flatmap
        (lambda (j) 
          (map (lambda (k) (list i j k)) (enumerate-interval 1 (- j 1))))
        (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

;(unique-triplets 5)

(define (sum list) (accumulate + 0 list))

(define (triplet-sum n s)
  (filter (lambda (triplet) (= (sum triplet) s))
    (unique-triplets n)))


(triplet-sum 8 10)
; '((5 3 2) (5 4 1) (6 3 1) (7 2 1))