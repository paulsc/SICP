#lang racket

(define make-vect list)
(define xcor-vect car)
(define ycor-vect cadr)

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
             (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
             (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect v1 s)
  (make-vect (* s (xcor-vect v1)) (* s (ycor-vect v1))))

(define v1 (make-vect 1 2))
(define v2 (make-vect 3 4))
;(add-vect v1 v2)
;(sub-vect v2 v1)
;(scale-vect v1 2)

(provide make-vect xcor-vect ycor-vect add-vect sub-vect scale-vect)