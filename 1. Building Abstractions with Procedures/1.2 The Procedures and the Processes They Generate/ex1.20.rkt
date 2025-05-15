#lang racket

; The process that a procedure generates is of course dependent on the rules 
; used by the interpreter. As an example, consider the iterative gcd procedure 
; given above. Suppose we were to interpret this procedure using normal-order 
; evaluation, as discussed in 1.1.5. (The normal-order-evaluation rule for 
; if is described in Exercise 1.5.) Using the substitution method 
; (for normal order), illustrate the process generated in evaluating 
; (gcd 206 40) and indicate the remainder operations that are actually performed. 
; How many remainder operations are actually performed in the normal-order 
; evaluation of (gcd 206 40)? In the applicative-order evaluation? 

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; eval

(gcd 206 40)
; eval 1: 
; 40 != 0
(gcd 40 (remainder 206 40))
; eval 2 
; a=40 b=(remainder 206 40)
(if (= (remainder 206 40) 0)
    40
    (gcd (remainder 206 40) 
         (remainder 40 (remainder 206 40))))
; eval 3
; force-eval #1 of (remainder 206 40) due to if special form
; (remainder 206 40) = 6, which is != 0 so we keep the bottom 2 lines
; now it's a call to (gcd) with
; a = (remainder 206 40) 
; b = (remainder 40 (remainder 206 40))
(if (= (remainder 40 (remainder 206 40))
       0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40))
         (remainder (remainder 206 40)
                    (remainder 40 (remainder 206 40)))))
; eval 4
; 2 more force-evals of (remainder) in 1st line, result is (remainder 40 6) = 4
; 4 != 0 so we keep the bottom 3 lines

; etc... 
; conclusion: there are redundant evals with normal order