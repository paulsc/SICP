#lang racket


; k-term finite continued fraction

(define (cont-frac n d k)
  (define (loop i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) 
           (+ (d i) (loop (+ i 1))))))
  (loop 1))
; this is a recursive process

; according to wikipedia, golden ratio = 1.618033988749
; 1 / golden-ratio = 0.6180...

(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 10)
; 0.6179775280898876

(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 11) 
; 0.6180555555555556


; 2. recursive vs iterative
; now make an iterative version

(define (cont-frac-iter n d k)
  (define (loop i result)
    (if (= i 0)
        result
        (loop (- i 1) 
              (/ (n i) 
                 (+ (d i) result)))))
  (loop k 0))

(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 11) 

