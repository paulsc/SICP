#lang sicp 

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
               (next-divisor test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(prime? 23)

(define runtime current-inexact-monotonic-milliseconds)


; last number printed is runtime in ms
(define (find-n-primes-from start n)
  (define (loop i primes-found start-time)
    (if (= primes-found n)
        (- (runtime) start-time)
        (if (prime? i) 
            (begin 
              ;(display i) 
              ;(display " ")
              (loop (+ i 2) (+ primes-found 1) start-time))
            (loop (+ i 2) primes-found start-time))))
  (loop (if (even? start) (+ start 1) start) 
        0
        (runtime)))


(find-n-primes-from 1000000000 100)
; eval the different variations of next-divisor below then run find-n-primes-from
; result:
; 7145 with the fancy-next-divisor
; 11139 with the not fancy one

(define (next-divisor x) 
  (cond ((= x 2) 3)
        (else (+ x 2))))

(define (next-divisor x) (+ x 1))

