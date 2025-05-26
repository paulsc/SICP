#lang racket

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

;What are the values of the following expressions?

(A 1 10)
(A (- 1 1) 
   (A 1 (- 10 1)))
(A 0 (A 1 9))
(* 2 (A 1 9))
(* 2 (A 0 (A 1 8)))
(* 2 (* 2 (A 1 8)))
;....
(* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 (* 2 2)))))))))
; 1024
; If x = 1, A = 2^y

(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1)))) ; if y = 1, return 2
(A 1 (A 1 (A 1 2))) ; see "if x = 1" above, (A 1 2) = 2^2
(A 1 (A 1 4))
(A 1 16)
; 2^16
; 65536
; if x = 2, A = (pow 2 (pow 2 (pow 2))), n-1 times

(A 3 3)
(A 2 (A 3 2))
(A 2 (A 2 (A 3 1)))
(A 2 (A 2 2))
(A 2 (A 1 (A 2 1)))
(A 2 (A 1 2))
(A 2 (A 0 (A 1 1)))
(A 2 (A 0 2))
(A 2 (* 2 2))
(A 2 4)
; 655536



(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))


(define (k n) (* 5 n n))
;Give concise mathematical definitions for the functions computed by the 
;procedures f, g, and h for positive integer values of n.
;For example, (k n) computes 5 n 2 . 

(define (f n) (A 0 n)) ; 2 * n
(define (g n) (A 1 n)) ; 2 ^ n
(define (h n) (A 2 n)) ; .... is a tetration, or "power tower of 2s"... had to look that up

