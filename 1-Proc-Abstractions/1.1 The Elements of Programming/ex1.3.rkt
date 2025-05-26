#lang racket

(define (sum-squares x y)
  (+ (sqr x) (sqr y)))

(define (fn a b c)
  (cond ((and (< a b) (< a c)) (sum-squares b c))
        ((and (< b a) (< b c)) (sum-squares a c))
        ((and (< c a) (< c b)) (sum-squares a b))))