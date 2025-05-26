#lang racket

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

; Applicative order evaluation

(test 0 (p))

; infinite loop ??

; Normal order evaluation

(test 0 (p))

(if (= 0 0)
    0
    (p))

; returns 0