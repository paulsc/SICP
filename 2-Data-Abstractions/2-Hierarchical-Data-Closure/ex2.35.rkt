#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0 
    (map (lambda (t) (if (pair? t) (count-leaves t) 1)) 
         t)))

(define l1
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

(count-leaves l1)

