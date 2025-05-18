#lang racket

; k-term finite continued fraction

(define (cont-frac n d k)
  (define (loop i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (loop (+ i 1))))))
  (loop 1))

(define (looper fn a b)
  (when (< a b)
    (begin (printf "~a " (fn a)) 
           (looper fn (+ a 1) b))))

(define (square x) (* x x))
(define (make-numer x) 
  (lambda (i) 
    (if (= i 1) 
        x 
        (* (square x) -1))))

;(looper (make-numer 2) 1 10)

(define (denom i) (- (* i 2) 1))
;(looper denom 1 10)

(define (tan-cf x k) (cont-frac (make-numer x) denom k))
(tan-cf 2 10)
; -661867910/302908849 = -2.18503986


