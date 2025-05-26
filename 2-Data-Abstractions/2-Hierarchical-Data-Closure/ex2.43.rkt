#lang racket

; this (slow) code below does:
; - enumerate 1..8
; - 8 times calculates all the solutions for k-1
; - to each of these solutions append the new row

; It will take about k * T time to run 

(flatmap
  (lambda (new-row)
    (map (lambda (rest-of-queens)
           (adjoin-position 
            new-row k rest-of-queens))
         (queen-cols (- k 1))))
  (enumerate-interval 1 board-size))

; the original code below which:
; - takes all solutions for (k - 1)
; - then maps to (1..8) a function that creates 8 lists 
;   each starting with said solution
; - then flattens the result

(flatmap
 (lambda (rest-of-queens)
   (map (lambda (new-row)
          (adjoin-position 
           new-row k rest-of-queens))
        (enumerate-interval 1 board-size)))
 (queen-cols (- k 1)))

