#lang racket 

(define (square x) (* x x))
(define (cube x) (* x x x))

(define (improve guess x)
  (/ (+ (/ x 
           (square guess)) 
        (* guess 2)) 
     3))

(define (good-enough? guess x)
  (< (/ (abs (- (cube guess) x)) x) 0.001))

(define (cubert-iter guess x)
  (if (good-enough? guess x)
      guess
      (cubert-iter (improve guess x) x)))

(define (cubert x)
  (cubert-iter 1.0 x))

(cubert 27)

