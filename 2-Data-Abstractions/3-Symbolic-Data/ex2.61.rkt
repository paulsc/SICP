#lang racket

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

; we need to seek to the place where it should be
; and there we will either find the element already and return
; or see it missing, concatenate and return
; 
; in recursive terms... if we follow the same pattern as for element-of-set?
; where we said element-of-set-x? is true if the car is the same, otherwise
; we loop to the cdr, and we stop if we're one above.
; here we could loop, if we equal the car, we bail, if the car is bigger than
; x we insert x right before the car. So the recursive call is something like
;  (cons (car set) (cdr set))
 

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((> x (car set)) 
           (cons (car set) (adjoin-set x (cdr set))))
        (else ; x < (car set) so we insert x
           (cons x set))))

#|
(adjoin-set 1 '())
(adjoin-set 4 '(1 2 3 5 6 7))
|#

