#lang racket

(define make-interval cons)

(define lower-bound car)
(define upper-bound cdr)

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i) (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i) (/ (- (upper-bound i) (lower-bound i)) 2))

;(define i1 (make-center-width 10 1))
;i1

(define (make-center-percent c p) (make-center-width c (* c p)))
(define (percent i) (/ (width i) (center i)))

;(define i2 (make-center-percent 10 0.1))
;i2
;(percent i2)

(provide make-center-percent make-center-width percent center width)
