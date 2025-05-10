#lang racket
(define (square x) (* x x))

(define (average x y) 
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (good-enough-relative? guess x)
  (< (/ (abs (- (square guess) x)) x) 0.001))

(good-enough-relative? 3.00001 9)

(define (sqrt-iter guess x)
  (if (good-enough-relative? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (error-percent x y) 
  (printf "off by ~a %\n" (truncate (* (/ (- x y) y) 100))))

; good-enough fails for small numbers because the precision is too large
; relative to that number

(sqrt 9)
(error-percent (sqrt 9) 3)
(error-percent (sqrt 100) 10)
(error-percent (sqrt 0.0001) 0.01)

; good-enough fails for large numbers because large numbers have smaller 
; precision / less numbers after the comma. 

(define (error-sqrt x)
  (let ((s (square x)))
    (printf "Calculating error for square of ~a: " s)
    (error-percent x (sqrt s))))

(error-sqrt 1000000000000000000000000000000000)
; Calculating error for square of 1000000000000000000000000000000000000000000000000000000000000000000: off by 0.0 %
; hmmm... so no it doesn't seem to be an issue for large numbers ?


