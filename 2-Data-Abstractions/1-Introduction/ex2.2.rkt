#lang racket

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment start end) (cons start end))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (average x y) (/ (+ x y) 2))
(define (midpoint-segment s)
  (let ((start (start-segment s))
        (end (end-segment s)))
    (make-point (average (x-point start) (x-point end))
                (average (y-point start) (y-point end)))))

(define (print-point p) (printf "(~a,~a)\n" (x-point p) (y-point p)))
(define (print-segment s) 
  (let ((start (start-segment s))
        (end (end-segment s)))
    (printf "(~a,~a) -> (~a,~a)\n" 
     (x-point start) (y-point start)
     (x-point end) (y-point end))))

;(define p1 (make-point 2 3))
;(define p2 (make-point 4 5))
;(define s1 (make-segment p1 p2))
;(print-segment s1)                  ; (2,3) -> (4,5)
;(print-point (midpoint-segment s1)) ; (3, 4)


(provide make-point x-point y-point average print-point)
(provide make-segment start-segment end-segment midpoint-segment print-segment)