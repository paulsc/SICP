#lang racket

(define (square x) (* x x))

(define (square-tree t) 
  (cond ((null? t) null)
        ((not (pair? t)) (square t))
        (else 
          (cons (square-tree (car t))
                (square-tree (cdr t))))))

(define (sq t)
  (map (lambda (t) 
         (if (pair? t) (sq t) (square t)))
    t))

(define l1
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

(sq l1)
;(1 (4 (9 16) 25) (36 49))