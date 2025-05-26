#lang racket

(define make-interval cons)

(define lower-bound car)
(define upper-bound cdr)

(define (contains-zero? x) 
  (and (< (lower-bound x) 0) (> (upper-bound x) 0)))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) 
               (lower-bound y)))
        (p2 (* (lower-bound x) 
               (upper-bound y)))
        (p3 (* (upper-bound x) 
               (lower-bound y)))
        (p4 (* (upper-bound x) 
               (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (contains-zero? y)
      (error "div by 0") 
      (mul-interval x 
                    (make-interval 
                     (/ 1.0 (upper-bound y)) 
                     (/ 1.0 (lower-bound y))))))

(div-interval (make-interval 1 3) (make-interval -2 3))