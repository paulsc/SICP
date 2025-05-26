#lang racket

; Exercise 1.16: Design a procedure that evolves an iterative exponentiation 
; process that uses successive squaring and uses a logarithmic number of steps, 
; as does fast-expt.

(define (square x) (* x x))

(define (loop a b n)
  (printf "a:~a b:~a n:~a\n" a b n)
  (if (= n 0)
      a
      (if (even? n)
          (loop a (square b) (/ n 2))
          (loop (* a b) b (- n 1)))))

(define (fast-exp b n)
  (loop 1 b n))

(fast-exp 2 20)
(fast-exp 2 1)
(fast-exp 2 3)

; Hint: Using the observation that:
;   (b^n/2)^2 = (b^2)^n/2
; keep, along with the exponent n and the base b, an additional state variable a,
; and define the state transformation in such a way that the product ab^n is
; unchanged from state to state. At the beginning of the process a is taken to 
; be 1, and the answer is given by the value of a at the end of the process. 
; In general, the technique of defining an invariant quantity that remains 
; unchanged from state to state is a powerful way to think about the design of 
; iterative algorithms. 