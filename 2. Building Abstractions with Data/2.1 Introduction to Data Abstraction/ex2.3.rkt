#lang racket

(require "ex2.2.rkt") ; segment and point primitives

; define rectangles as 2 points: the top left one and the bottom right
; perimeter = 2 * (L + W)
; area = L * W

(define (make-rect p1 p2) (cons p1 p2))
(define (p1-rect r) (car r))
(define (p2-rect r) (cdr r))

(define (length r) (- (y-point (p2-rect r)) (y-point (p1-rect r))))
(define (width r) (- (x-point (p2-rect r)) (x-point (p1-rect r))))

(define (perimeter r) (* 2 (+ (width r) (length r))))
(define (area r) (* (width r) (length r)))

(define r1 (make-rect (make-point 2 3) (make-point 4 6)))
(length r1)
(width r1)
(perimeter r1)
(area r1)

; other implementation: define the rectangle as a segment that's the diagonal

(define (make-rect p1 p2) (make-segment p1 p2))
(define (p1-rect r) (start-segment r))
(define (p2-rect r) (end-segment r))

