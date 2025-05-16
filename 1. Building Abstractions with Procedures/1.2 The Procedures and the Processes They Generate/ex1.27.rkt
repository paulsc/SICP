; Demonstrate that the Carmichael numbers listed in Footnote 47 really do fool 
; the Fermat test. That is, write a procedure that takes an integer n and tests 
; whether a n is congruent to a modulo n for every a < n , and try your 
; procedure on the given Carmichael numbers. 

; There are 255 Carmichael numbers below 100,000,000. 
; The smallest few are 561, 1105, 1729, 2465, 2821, and 6601

(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (next-divisor x) 
  (cond ((= x 2) 3)
        (else (+ x 2))))

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

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) m))))

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
; The smallest few are 561, 1105, 1729, 2465, 2821, and 6601
(= (fast-prime? 561 10)
(prime? 561)

(define (is-carmichael x)
  (and (fast-prime? x 5) (not (prime? x))))

(is-carmichael 2)
(is-carmichael 561)
(is-carmichael 1729)
(is-carmichael 6601)


(define (all-congruent n) 
  (define (loop a)
    ;(display a)
    ;(display " ")
    (cond ((= a 0) #t)
          ((not (= (expmod a n n) a)) #f)
          (else (loop (- a 1)))))
  (loop (- n 1)))

(all-congruent 561)
(prime? 561)