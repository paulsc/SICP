#lang racket

(require "ex2.38.rkt") ; fold-left, fold-right

; fold-right does (op (car seq) (fold-right (cdr seq)))
(define (reverse sequence)
  (fold-right 
   (lambda (first rest) (append rest (list first))) null sequence))

(reverse '(1 2 3))

; fold-left does (op (op initial car) next-car) ...
(define (reverse sequence)
  (fold-left 
   (lambda (result first) (append (list first) result)) null sequence))

(reverse '(1 2 3))

