#lang sicp

(define (square x) (* x x))

(define (expmod base exp m) 
  (cond ((= exp 0) 1)
        ((even? exp)
          (remainder (square (expmod base (/ exp 2) m)) m))
        (else
          (remainder (* base (expmod base (- exp 1) m)) m))))


; In this optimised version we do a remainder call after each successive 
; iteration, instead of doing it at the end. 

; For example n=5 a=2

(expmod 2 5 5)
(remainder (* 2 (expmod 2 4 5)) 5)

(expmod 2 4 5) expands to
(remainder (square (expmod 2 2 5)) 5)

etc… (expmod 2 2 5) will be = to 4

(remainder 16 5) = 1

;Substitute above 
(remainder (* 2 1) 5) = 2 

; The non optimised version would have done 2^5 = 32 and 32 mod 5.. 
; the mod happens on a much larger number, so slower. 
