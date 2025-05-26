#lang racket

(require "ex2.7.rkt")
(require "ex2.8.rkt")


(define (add-interval x y)
  (make-interval (+ (lower-bound x) 
                    (lower-bound y))
                 (+ (upper-bound x) 
                    (upper-bound y))))

(define i1 (make-interval 1 2)) ; width 0.5
(define i2 (make-interval 2 3)) ; width 0.5
(add-interval i1 i2) ; width 1
(sub-interval i1 i2) ; width 1

; if interval a = [ a1, a2 ] and inteval b = [ b1, b2 ]
; width(a + b) = 1/2 * ( (a2 + b2) - (a1 + b1) )
;              = 1/2 (a2 - a1) + 1/2 (b2 - b1)
;              = width(a) + width(b)
; same for sub-interval


; (1, 2) * (2, 3)
; 1 * 2 = 2 -> min
; 1 * 3 = 3
; 2 * 2 = 4
; 2 * 3 = 6 -> max
(mul-interval i1 i2) ; (2 6) the new width is 2, which is not a function of 0.5

