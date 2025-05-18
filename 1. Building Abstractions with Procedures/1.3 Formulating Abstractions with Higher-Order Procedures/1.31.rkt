#lang racket

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

; factorial is fac(n) = 1 * 2 * ... * n

(define (identity x) x)
(define (inc x) (+ x 1))

(define (factorial n)
  (product identity 1 inc n))

(factorial 5)

; approximation of pi
; we need a function to generate the numerator
; 2 4 4 6 6 8 8
; and one for the denom
; 3 3 5 5 7 7 9

(define (numer x) (+ 2 x (remainder x 2)))
(define (denom x) (+ 2 x (remainder (+ x 1) 2)))

(define (loop fn a b) 
  (if (> a b) 
      ""
      (begin
        (printf "i:~a fn(i):~a\n" a (fn a)) 
        (loop fn (+ a 1) b))))

(loop numer 0 10)
(loop denom 0 10)

(define (product term a next b)
  ;(printf "a:~a b:~a term(a):~a\n" a b (term a))
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (pi-approx n)
  (define (term n) (/ (numer n) (denom n)))
  (* (product term 0 inc n) 4))

(pi-approx 50)

; 2 iterative vs. recursive

(define (product-iter term a next b)
  (define (loop a result)
      (if (> a b)
          result
          (loop (next a) (* result (term a)))))
  (loop a 1))

(define (factorial-iter n)
  (product-iter identity 1 inc n))

(factorial-iter 5)
