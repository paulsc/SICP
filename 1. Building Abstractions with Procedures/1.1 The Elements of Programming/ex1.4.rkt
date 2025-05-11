#lang racket
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; if b is bigger than 0, return a + b else a - b