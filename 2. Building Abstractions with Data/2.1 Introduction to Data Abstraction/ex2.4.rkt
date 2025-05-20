#lang racket

(define (cons x y) 
  (lambda (m) (m x y)))

(define (car z) 
  (z (lambda (p q) p)))

(car (cons 1 2))

; defining cdr:

(define (cdr z)
  (z (lambda (p q) q)))

(cdr (cons 1 2))