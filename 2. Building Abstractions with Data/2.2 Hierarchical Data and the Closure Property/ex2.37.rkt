#lang racket

(require "ex2.36.rkt") ; accumulate, accumulate-n

(define (sum l) (accumulate + 0 l))
;(sum '(1 2 3))

; dot product of 2 vectors
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

; return the vector t where for index i
; t(i) = sum( m(i,j) * vj for all j )
; iterate over rows of m, multiply every element with the equivalent index in v
; and sum all those things, that gives you one value in the resulting vector
(define (matrix-*-vector m v)
  (map (lambda (mv) (sum (map * mv v))) m))

(define m1 (list (list 1 2 3) (list 4 5 6)))
(define v1 (list 7 8 9))

(matrix-*-vector m1 v1)

;(define (transpose mat)
;  (accumulate-n ⟨??⟩ ⟨??⟩ mat))
;
;(define (matrix-*-matrix m n)
;  (let ((cols (transpose n)))
;    (map ⟨??⟩ m)))