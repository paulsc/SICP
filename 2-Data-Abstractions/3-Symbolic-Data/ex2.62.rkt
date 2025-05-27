#lang racket

; Give a Θ(n) implementation of union-set for sets represented as ordered lists.

; Similar to intersection:
; We compare the cars of set1 and set2
; - if they're equal, we add that element to the union, and move to both cdrs
; - otherwise, whichever is smallest, we add to the union, and do the cdr of that

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else 
          (let ((x1 (car set1)) (x2 (car set2)))
            (cond ((= x1 x2)
                   (cons x1 (union-set (cdr set1) (cdr set2))))
                  ((< x1 x2) 
                   (cons x1 (union-set (cdr set1) set2)))
                  ((< x2 x1) 
                   (cons x2 (union-set set1 (cdr set2)))))))))

#|
(union-set '(1 2 3) '(4 5 6))
|#