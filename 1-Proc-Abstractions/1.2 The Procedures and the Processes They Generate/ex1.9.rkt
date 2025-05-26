#lang racket

; Recursive or iterative??

(define (+ a b)
  (if (= a 0) 
      b 
      (inc (+ (dec a) b))))

;(+ 2 1)
;(inc (+ (dec 2) 1))
;(inc (+ 1 1))
;(inc (inc (+ (dec 1) 1)))
;(inc (inc (+ 0 1)))
;(inc (inc 1))
;(inc 2)
;3
;This process is recursive

(define (+ a b)
  (if (= a 0) 
      b 
      (+ (dec a) (inc b))))

;(+ 2 1)
;(+ (dec 2) (inc 1))
;(+ 1 2)
;(+ (dec 1) (inc 2))
;(+ 0 3)
;3
;This process is iterative (but the procedure is recursive)
