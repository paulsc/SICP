#lang racket

;Exercise 1.11: A function f is defined by the rule that 
;f ( n ) = n if n < 3 and 
;f ( n ) = f ( n − 1 ) + 2 f ( n − 2 ) + 3 f ( n − 3 ) if n ≥ 3 . 
;Write a procedure that computes f by means of a recursive process. 
;Write a procedure that computes f by means of an iterative process. 


(define (f-recur n)
  (if (< n 3)
      n
      (+ (f-recur (- n 1))
         (* 2 (f-recur (- n 2)))
         (* 3 (f-recur (- n 3))))))

(f-recur 2)
(f-recur 3)
(f-recur 4)
(f-recur 5)
(f-recur 6)

; f(n):                        =  c + (2 * b) + (3 * a) = d
; f(3): f(2) + 2 f(1) + 3 f(0) =  2 + (2 * 1) + (3 * 0) = 4
; f(4): f(3) + 2 f(2) + 3 f(1) =  4 + (2 * 2) + (3 * 1) = 11
; f(5): f(4) + 2 f(3) + 3 f(2) = 11 + (2 * 4) + (3 * 2) = 25

; f(n):                        =  c + (2 * b) + (3 * a) = d
; f(n+1):                      =  d + (2 * c) + (3 * b) = d

; b <- c
; c <- d
; d <- c + 2b + 3a


(define (loop n) 
    (helper 0 n 0 0 0))
(define (helper i n b c d) 
  (begin
    (printf "i:~a b:~a c:~a d:~a       f(~a) = ~a\n" i b c d i d)
    (if (= i n)
        d
        (if (< i 2)
            (helper (+ i 1) n c d (+ i 1))
            (helper (+ i 1) n c d (+ d (* 2 c) (* 3 b)))))))
(loop 6)


(= (loop 0) 0)
(= (loop 1) 1)
(= (loop 2) 2)


; cleaned up version with no debug print
(define (ff n) 
 (define (ff-helper i b c d) 
     (if (= i n)
         d
         (if (< i 2)
             (ff-helper (+ i 1) c d (+ i 1))
             (ff-helper (+ i 1) c d (+ d (* 2 c) (* 3 b))))))
    (ff-helper 0 0 0 0))

(ff 6)


; solution:

(define (f-iterative n)
  (define (f-loop n-1 n-2 n-3 nth)
    (if (= n nth)
        n-1  ; Final result of the computation
        (f-loop (+ n-1 (* 2 n-2) (* 3 n-3))  ; Compute f(n)
                n-1
                n-2 
                (+ 1 nth))))
  (if (< n 3)
      n
      (f-loop 2 1 0 2)))