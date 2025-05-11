#lang racket

; Using the results of Exercise 1.16 and Exercise 1.17, devise a procedure that
; generates an iterative process for multiplying two integers in terms of adding,
; doubling, and halving and uses a logarithmic number of steps

(require racket/trace)

(define (double x) (+ x x))
(define (halve x) (/ x 2))

(* 3 100)


(define (fast-mult a b) (loop 0 a b))
(define (loop x a b)
  ;(printf "x: ~a a:~a b:~a\n" x a b)
  (cond ((= b 1) (+ x a))
        ((or (= b 0) (= a 0)) 0)
        (else (if (even? b)
                  (loop x (double a) (halve b))
                  (loop (+ x a) a (- b 1))))))

(trace loop)
(fast-mult 3 100)
(fast-mult 2 0)