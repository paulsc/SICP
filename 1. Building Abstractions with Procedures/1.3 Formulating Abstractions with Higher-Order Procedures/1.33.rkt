#lang racket


(define (filtered-accumulate combiner predicate null-value term a next b)
  (define (loop a result)
      (cond ((> a b) result)
            ((predicate a) (loop (next a) 
                                 (combiner result (term a))))
            (else (loop (next a) result))))
  (loop a null-value))

(define (identity x) x)
(define (inc x) (+ x 1))
(define (sum-evens a b) (filtered-accumulate + even? 0 identity a inc b))
(sum-evens 1 10)



; 1. sum of primes

(define (square x) (* x x))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

(define (sum-primes a b) (filtered-accumulate + prime? 0 square a inc b))

(sum-primes 1 5)
; 1 + 2^2 + 3^2 + 5^2 = 39


; 2
; all positive integers i < n such that GCD(i, n) = 1

(define (gcd a b) (if (= b 0) a (gcd b (remainder a b))))

(define (prod2 n) 
  (define (pred x) (= (gcd x n) 1))
  (filtered-accumulate * pred 1 identity 1 inc n))

(prod2 6) ; should be equal to 5
(prod2 5) ; should be equalt to 4! = 24