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

; (accumulate-n op init seqs)
; op takes n arguments, one each time from n seqs
; seqs here are the rows of the matrix
; this is confusing because this would return one value per column
; this must mean that we need to return a list every time, each list is a row
; 
; 1 2 3                1 4 7
; 4 5 6     ---->      2 5 8
; 7 8 9                3 6 9
;
; in this example the first call to op would be with:
; '(1 4 7) which is our new row, so op is identity
; -- no actually it's cons, since the elements are passed as args, not as a list

(define (transpose mat)
  (accumulate-n cons '() mat))

;(define m1 '((1 2 3) (4 5 6) (7 8 9)))
;(transpose m1)

; dot product:
;  | 1 2 3 |   |  7  8 |    | 58 64 |
;  | 4 5 6 | * |  9 10 |  = |       |
;              | 11 12 |
; because 1*7 + 2*9 + 3*11 = 58
; if we tranpose the 2nd matrix, the dot args become
;  | 1 2 3 |   | 7  9 11 |
;  | 4 5 6 |   | 8 10 12 |
; then the first row of our result is
; [ (matrix1row1 * matrix2row1) (matrix1row1 * matrix2row2) ]
; etc..
; (map (lambda (row) (...)) m) calls fn with one row of m each time (twice in our example)
; and should return ( row*matrix2row1 row*matrix2row2 )
; which is the same as vector ("row") * matrix ("transposed n") multiplication
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))

;(define m1 '((1 2 3) (4 5 6)))
;(define m2 '((7 8) (9 10) (11 12)))
;(matrix-*-matrix m1 m2); '((58 64) (139 154))
