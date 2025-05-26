#lang racket

(define (square x) (* x x))

(define (tree-map fn t)
  (map (lambda (t)
         (if (pair? t)
             (tree-map fn t)
             (fn t)))
       t))


(define (square-tree tree) 
  (tree-map square tree))

(define l1
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

(square-tree l1)
;(1 (4 (9 16) 25) (36 49))