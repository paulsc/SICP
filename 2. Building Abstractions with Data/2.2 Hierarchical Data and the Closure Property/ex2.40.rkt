#lang racket

(require "ex2.36.rkt") ; accumulate, accumulate-n
(require "../../lib/prime.rkt") ; prime

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low 
            (enumerate-interval 
             (+ low 1) 
             high))))

; first enumerate from 1 to n
; then for each i = 1...n
;      for each j = 1....(i-1)
;          return (list i j)
; this would return for n = 3
; '(() ((2 1)) ((3 1) (3 2)))
; so we call (accumulate append null ...)
; to flatten the result, hence "flatmap"

(define (unique-pairs n)
  (accumulate 
   append
   null
   (map (lambda (i)
          (map (lambda (j) 
                 (list i j))
               (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n))))

(unique-pairs 3)

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) 
        (cadr pair) 
        (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter 
        prime-sum?
        (unique-pairs n))))

; (prime-sum-pairs 6)
; '((2 1 3) (3 2 5) (4 1 5) (4 3 7) (5 2 7) (6 1 7) (6 5 11))