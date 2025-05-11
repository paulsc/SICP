#lang racket
(require racket/trace)

; original implementation
(define (oldfib n) 
  (oldfib-iter 1 0 n))

(define (oldfib-iter a b count)
  (if (= count 0)
      b
      (oldfib-iter (+ a b) a (- count 1))))

(define (square x) (* x x))

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) 
         b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))  ;compute p'
                   (+ (* q p) (* p q) (square q))  ;compute q'
                   (/ count 2)))
        (else 
         (fib-iter (+ (* b q) 
                      (* a q) 
                      (* a p))
                   (+ (* b p) 
                      (* a q))
                   p
                   q
                   (- count 1)))))

(trace fib-iter)
(trace oldfib-iter)
(fib 100)
(oldfib 100)