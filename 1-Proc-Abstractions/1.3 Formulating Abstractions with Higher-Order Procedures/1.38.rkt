#lang racket


; k-term finite continued fraction

(define (cont-frac n d k)
  (define (loop i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (loop (+ i 1))))))
  (loop 1))

;(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 11) 
; 0.6180555555555556

; In this fraction, the N i are all 1, and 
; the D i are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8,

(define (looper fn n)
  (define (loop i)
    (if (= i n)
      ""
      (begin
        (printf "~a " (fn i))
        ;(printf "fn(~a): ~a\n" i (fn i))
        (loop (+ i 1)))))
  (loop 1))

(define (denom i) 
  (let ((r (remainder i 3)))
    (if (or (= r 0) (= r 1))
        1
        (* (+ (/ (- i 2) 3) 1) 2))))

;(looper denom 20)

(cont-frac (lambda (x) 1.0) denom 10) 
; 0.7182817182817183 which is approx equal to e-2


