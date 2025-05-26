#lang racket

(define (double f) (lambda (x) (f (f x))))
(define (inc x) (+ x 1))
((double inc) 1)

; double can also be written as:
(define double-again
  (lambda (f) (lambda (x) (f (f x)))))

(((double (double double)) inc) 5) ; 21
;   1        2      3
; first we substitue double #3:

(((double (double (lambda (f) (lambda (x) (f (f x))))) inc) 5))
;   1        2
; then we apply double #2

; this will take forever hmm....

; (double double) is apply the fn 4 times
(define apply-four-times (double double))
((apply-four-times inc) 1) ; 5
(((lambda (f) (lambda (x) (f (f (f (f x)))))) inc) 1) ; also 5

(define apply-16-times
  (double apply-four-times))

; calling double on that again, means 4 times applying the fn 4 times, 
; which is applying it 16 times
((apply-16-times inc) 1) ; 17



