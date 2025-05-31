#lang racket

(require "ex2.63.rkt") ; tree->list-1
(require "ex2.64.rkt") ; list->tree

; I'm supposed to use list->tree and tree->list

; maybe convert both trees to lists, do the union, then convert to tree again

(define (union-set-list set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else 
          (let ((x1 (car set1)) (x2 (car set2)))
            (cond ((= x1 x2)
                   (cons x1 (union-set-list (cdr set1) (cdr set2))))
                  ((< x1 x2) 
                   (cons x1 (union-set-list (cdr set1) set2)))
                  ((< x2 x1) 
                   (cons x2 (union-set-list set1 (cdr set2)))))))))




(define (union-set s1 s2)
  (list->tree 
    (union-set-list (tree->list-1 s1) 
                    (tree->list-1 s2))))



(define s1 (list->tree '(1 3 5 7 9 11)))

(define s2 (list->tree '(2 4 6)))

(union-set s1 s2)


