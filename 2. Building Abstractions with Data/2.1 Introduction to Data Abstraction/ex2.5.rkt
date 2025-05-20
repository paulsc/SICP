#lang racket

; Show that we can represent pairs of nonnegative integers using only numbers
; and arithmetic operations if we represent the pair a and b as the integer
; that is the product 2^a * 3^b. Give the corresponding definitions of the
; procedures cons, car, and cdr. 

; a=0 b=0 c=1
; a=1 b=1 c=6
; a=2 b=1 c=12
; a=2 b=3 c=108

; how do we get a & b from c? we solve:
; x = 2^a * 3^b
; x = (2 * 2 * 2 ...) * (3 * 3 * 3 ...)
; for x=12:
; x = 12
; x = 6 * 2
; x = 3 * 2 * 2

(define (num-cons a b) (* (expt 2 a) (expt 3 b)))
;(num-cons 2 3)

(define (num-car x)
  (if (not (= (remainder x 2) 0))
    0
    (+ 1 (num-car (/ x 2)))))

(define (num-cdr x)
  (if (not (= (remainder x 3) 0))
    0
    (+ 1 (num-cdr (/ x 3)))))

(num-car (num-cons 2 3))
(num-cdr (num-cons 2 3))
