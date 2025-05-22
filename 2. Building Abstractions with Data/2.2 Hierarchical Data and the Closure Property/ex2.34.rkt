#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define 
  (horner-eval x coefficient-sequence)
  (accumulate 
   (lambda (this-coeff higher-terms)
     (+ this-coeff (* x higher-terms)))
   0
   coefficient-sequence))

; how do we inverse things, accumulate processes the list from the start to 
; the end and we need to proceed in reverse here, starting with a n, or do we?

; a0 + x ( a1 + x ( a2 + x ( a3 + x ( ... a(n-1) + a(n) * x ))) )

(horner-eval 2 (list 1 3 0 5 0 1))

; 1 + 3 x + 5 x^3 + x^5 for x = 2 
; 1 + 3 2 + 5 8 + 32 = 1 + 6 + 40 + 32 = 79
; or using horner's method
; ((((1x + 0) * x + 5) * x + 0) * x + 3) * x + 1
; (((x^2 + 5) * x) * x + 3) * x + 1)
;      (9 * 2 * 2 + 3) * 2 + 1
;       39 * 2 + 1 = 79




