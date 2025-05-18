#lang racket

(define (repeated fn n)
  (define (recur i)
    (if (= i 1)
        fn
        (compose fn (recur (- i 1)))))
  (recur n))

(define tolerance 0.00001)

; takes a function and a first guess, and converges to the fixed point
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average x y) (/ (+ x y) 2))

; takes a function and retuns an average-damped version of that function
(define (average-damp f)
  (lambda (x) 
    (average x (f x))))

(define (sqrt x)
  (fixed-point 
   (average-damp 
    (lambda (y) (/ x y)))
   1.0))

;(sqrt 9)

; (nth-root-solver x n) is:
; is the solver function for the nth root:
; f(y) = x / y^(n-1)
; it returns a function that takes a fixed-point guess
(define (nth-root-solver n x)
  (lambda (y) (/ x (expt y (- n 1)))))

;(define (sqrt-of-4-solver) (nth-root-solver 2 4))
;((sqrt-of-4-solver) 3)
;(let ((x 4) (y 3)) (/ x y))
;(define (cube-root-of-9-solver) (nth-root-solver 3 9))
;((cube-root-of-9-solver) 16)
;(let ((x 9) (y 16)) (/ x (expt y 2)))


; return a function that is a function that average damps it's argument fn n times
(define (n-average-damp n) (repeated average-damp n))

; return the nth root of x, average-damping the solver function r times
(define (nth-root n x r) 
  (fixed-point
    ((n-average-damp r)
     (nth-root-solver n x))
    1.0))

(nth-root 2 4 1)
(nth-root 3 8 1)
(nth-root 4 16 2)
(nth-root 5 32 2)
(nth-root 6 64 2)
(nth-root 7 128 2)
(nth-root 8 256 3)
(nth-root 9 512 3)
(nth-root 10 1024 3)
(nth-root 11 2048 3)
(nth-root 12 4096 3)
(nth-root 13 8192 3)
(nth-root 14 16384 3)
(nth-root 15 32768 3)
(nth-root 16 65536 4)
(nth-root 17 131072 4)

; it seems that for the nth-root we need to average-damp r times where 
; n = 2 ^ r
; so r = log(n) / log(2)

(define (number-of-damps-required n) (floor (/ (log n) (log 2))))

(number-of-damps-required 15)

(define (generic-nth-root n x)
  (nth-root n x (number-of-damps-required n)))

(generic-nth-root 2 4)
(generic-nth-root 4 16)
(generic-nth-root 7 128)
(generic-nth-root 8 256)
(generic-nth-root 15 32768)
(generic-nth-root 16 65536)
(generic-nth-root 17 131072)

