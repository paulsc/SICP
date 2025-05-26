#lang racket

(define (square x) (* x x))
(define (average x y) (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (iterator-improve good-enough? improve)
  (define (loop guess)
    (if (good-enough? guess)
        guess
        (loop (improve guess))))
   loop)

(define (sqrt-improve x) 
  (lambda (guess) 
    (average guess (/ x guess))))

(define (sqrt-good-enough x) 
  (lambda (guess)
    (< (abs (- (square guess) x)) 0.001)))

; is this really nicer though ?? too much abstraction imo
(define (sqrt-v2 x)
  ((iterator-improve (sqrt-good-enough x) (sqrt-improve x))
    1.0))

(sqrt-v2 9)


; fixed point

(define tolerance 0.00001)

(define (close-enough? v1 v2)
  (< (abs (- v1 v2)) 
     tolerance))

(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess)) 

(fixed-point cos 1.0)

; the challenge with fixed-point is that the "good-enough" function takes as 
; input the value processed by f(). let's try an iterative process

(define (fp-iter f first-guess)
  (define (try guess previous-guess)
    (if (close-enough? guess previous-guess)
        guess
        (try (f guess) guess)))
  (try first-guess (+ first-guess tolerance 1)))

; (fp-iter cos 1.0)

; does it fit this model below??, no because my loop has guess & previous-guess
;(define (iterator-improve good-enough? improve)
;  (define (loop guess)
;    (if (good-enough? guess)
;        guess
;        (loop (improve guess))))
;   loop)

; it could work if we store the previous guess in a closure for good-enough?
; no this doesn't work since it would be immutable still
; maybe we just settle for the inneffecient version that does double (fn) calls:

(define (fp-good-enough fn)
  (lambda (guess) (< (abs (- guess (fn guess))) tolerance)))

(define (fp-v2 fn x) 
  ((iterator-improve (fp-good-enough fn) fn) x))

(fp-v2 cos 1.0)


