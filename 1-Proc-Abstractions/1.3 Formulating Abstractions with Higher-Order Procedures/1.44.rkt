#lang racket

(define dx 0.01)

(define (smooth f)
  (lambda (x) (/ (+ (f (- x dx))
                    (f x)
                    (f (+ x dx)))
                  3)))

(define (square x) (* x x))
(square 3)
((smooth (smooth square)) 3)

(define (compose f g) (lambda (x) (f (g x))))

(define (repeated fn n)
  (define (recur i)
    (if (= i 1)
        fn
        (compose fn (recur (- i 1)))))
  (recur n))

(define (repeated-smooth fn n) 
  (lambda (x) (((repeated smooth n) fn) x)))

((repeated-smooth square 6) 3)
