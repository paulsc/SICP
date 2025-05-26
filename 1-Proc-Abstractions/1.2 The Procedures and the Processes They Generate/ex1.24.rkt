#lang sicp

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) 
         (fast-prime? n (- times 1)))
        (else false)))

(fast-prime? 101 5)

(define (prime? x) (fast-prime? x 3))

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
; ran in 1310 (5 checks of fast-prime) vs 1083 for the "not-fast" prime
; but the number of checks we do in fast-prime obv. affects execution
; time a lot. 
;
; also high numbers of n make fermat's test much faster.
;
; NOTE: it thought 101101 is prime, it's not