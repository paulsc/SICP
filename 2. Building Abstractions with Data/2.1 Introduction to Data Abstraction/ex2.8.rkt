#lang racket

(require "ex2.7.rkt")

; sub-interval
; we have something in the range [a b], we subtract [c d]
; then new min is the smallest number of the 4 minus the biggest
; and vice-versa

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define i1 (make-interval 1 2))
(define i2 (make-interval 2 3))

;(sub-interval i1 i2) ; (-2 . 0)

(provide sub-interval)