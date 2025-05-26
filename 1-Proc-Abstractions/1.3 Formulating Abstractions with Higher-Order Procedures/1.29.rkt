#lang sicp
; Simpson’s Rule for the integral of a function f between a and b.

(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (fn-h a b n) 
   (/ (- b a) n))

(define (integral f a b n)
  (define (helper h) 
    (define (fn-y k) (f (+ a (* k h))))
    (define (term x)
      (cond ((= x 0) (fn-y 0))
            ((even? x) (* 2 (fn-y x)))
            (else (* 4 (fn-y x)))))
    (* (sum term 0 inc n) 
       (/ h 3)))
  (helper (fn-h a b n)))


(integral cube 0 1 100)
(integral cube 0 1 1000)