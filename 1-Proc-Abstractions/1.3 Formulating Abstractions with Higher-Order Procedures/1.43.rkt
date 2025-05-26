#lang racket

(define (square x) (* x x))
(define (inc x) (+ x 1))

(define (compose f g) (lambda (x) (f (g x))))

(define (repeated fn n)
  (define (recur i)
    (if (= i 1)
        fn
        (compose fn (recur (- i 1)))))
  (recur n))

((repeated square 2) 5)