#lang racket

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(add-1 zero)

; or
;(define add-1 (lambda (n)
;  (lambda (f) (lambda (x) (f ((n f) x))))))


(add-1 zero)
; we substitute zero 
(add-1 (lambda (f) (lambda (x) x)))
; we substitue add-1
((lambda (n) (lambda (f) (lambda (x) (f ((n f) x)))))
 (lambda (f) (lambda (x) x)))
; we subtitute n with "zero" in the body of add-1
; body of add-1 is:
(lambda (f) (lambda (x) (f ((n f) x))))
; zero is:
(lambda (f) (lambda (x) x))
; so we get:
(lambda (f) 
  (lambda (x) 
    (f (((lambda (f) (lambda (x) x)) f) x)))) ; let's work on the inner part
; this is the inner part:
((lambda (f) (lambda (x) x)) f)
; a fn that takes a parameter f and returns a fn that returns it's parameter
; becomes
(lambda (x) x)
; so the whole thing is now:
(lambda (f) 
  (lambda (x) 
    (f ((lambda (x) x) x)))) ; let's work on the inner part again
; this is the inner part:
((lambda (x) x) x)
; this evaluates to:
x
; so the whole thing is now
(lambda (f) 
  (lambda (x) 
    (f x))) 
; a function that takes f, that returns a function that takes x,
; that calls f with x as an argument.

; if we add 1 again?
;(define (add-1 n)
;  (lambda (f) (lambda (x) (f ((n f) x)))))

; n = (lambda (f) (lambda (x) (f x)))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
; this bit:
((lambda (f) (lambda (x) (f x))) f)
; becomes:
(lambda (x) (f x))
; so we have:
(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
; this bit:
((lambda (x) (f x)) x)
; becomes: 
(f x)
; so we have:
(lambda (f) (lambda (x) (f (f x))))
; so we have wrapped the whole thing in another f call
; the number 2 is a lambda that when given f,
; returns a function that calls f twice on it's argument

(define one (add-1 zero))

(define (sayhi x) (display "hi "))

((one sayhi) "dummy value")
; "hi"

(define two (add-1 one))
((two sayhi) "dummy value")
; "hi hi"

; Define one and two directly (not in terms of zero and add-1). 
; (Hint: Use substitution to evaluate (add-1 zero)).

(define my-one (lambda (f) (lambda (x) (f x))))
(define my-two (lambda (f) (lambda (x) (f (f x)))))
((my-one sayhi) "dummy")
((my-two sayhi) "dummy")


; Give a direct definition of the addition procedure +
; (not in terms of repeated application of add-1).

; the "add" procedure takes two arguments a & b. 
; both a & b are functions that takes f as an argument and return a function
; that calls f a number of times on it's argument.
; the process of adding is unwrapping the calls on one side and adding them
; to the other, similar to how we defined add in chapter 1:
; recursive:
; (define (+ a b)
;   (if (= a 0) 
;       b 
;       (inc (+ (dec a) b))))
; iterative:
; (define (+ a b)
;   (if (= a 0) 
;       b 
;       (+ (dec a) (inc b))))
;
; so first we need to figure out how to decrease a number

; for example for 2 -> 1 we need to turn:
(lambda (f) (lambda (x) (f (f x))))
; into: 
(lambda (f) (lambda (x) (f x)))

; add-1 was defined as:
(define (add-1 n)
  (lambda (f) 
    (lambda (x) 
      (f ((n f) x)))))
; which is, return a function that takes a function and returns a function that...
; takes x, then executes the whole pending execution we had then call f one
; more time on it.

; how can I do this for dec-1 since I can't "reach inside" the lambda? 
; maybe I just need to forget about "decrease" and just compose a & b
; both are functions of this format:
; (lambda (f) (lambda (x) ... ))
; I just run one, take the result and run the second one on that result

(define (add a b)
  (lambda (f)
    (lambda (x)
      ((b f) ((a f) x)))))

(define (inc x) (+ x 1))
((my-one inc) 0)
((my-two inc) 0)

(define one (add-1 zero))
(define two (add-1 one))
(define three (add one two))
((three inc) 0)
((three sayhi) 0)

