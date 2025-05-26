#lang racket

(define x 
  (list (list 1 2) (list 3 4)))

(define (fringe t)
  (cond ((null? t) null)
        ((not (pair? t)) (list t))
        (else (append (fringe (car t)) (fringe (cdr t))))))

(fringe x)
(1 2 3 4)

(fringe (list x x))
(1 2 3 4 1 2 3 4)