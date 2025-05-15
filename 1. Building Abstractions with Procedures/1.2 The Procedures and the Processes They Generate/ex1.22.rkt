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
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define runtime current-inexact-monotonic-milliseconds)

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) 
                       start-time))))

; (timed-prime-test 23)

; Using this procedure, write a procedure search-for-primes that checks the 
; primality of consecutive odd integers in a specified range.

; hmm...
; timed-prime-test only returns the timing for one number, not the total time
; for 3 but maybe thats what the exercise wants (ambiguous? no actually it says)

(define (consec-primes-iter n end)
  (if (< n end)
      (and (timed-prime-test n)
           (consec-primes-iter (+ n 2) end))))

(consec-primes-iter 1001 1030)       ;    1021 *** 0.0009999996982514858
(consec-primes-iter 10001 10040)     ;   10037 *** 0.0010000001639127731
(consec-primes-iter 100001 100050)   ;  100049 *** 0.006000000052154064
(consec-primes-iter 1000001 1000050) ; 1000037 *** 0.01000000024214387

; you should expect that testing for primes around 10,000 should take about 
; sqrt(10) times as long as testing for primes around 1000.

; 0.006000000052154064 / 0.0010000001639127731 = 6
; 0.01000000024214387 / 0.006000000052154064 = 1.6
; sqrt(10) = 3
; sooooo ... sort of ?


; let's run more test for better comparison on fast CPUS:


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

(find-n-primes-from 1000 1000)
(find-n-primes-from 10000 1000)
(find-n-primes-from 100000 1000)
(find-n-primes-from 1000000 1000)

; roughly matches 3x increase every time
