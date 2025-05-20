#lang racket

(define make-interval cons)

(define lower-bound car)
(define upper-bound cdr)

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

; why do we have these p1-p4 options to begin with, instead of just calculating
; the lower bound of the product as lower-bound(x) * lower-bound(y)?
; is it for negative numbers? In which scenario can the min one of the other
; combinations?
; (mul-interval (make-interval -10 -9) (make-interval -6 -3))
; [ -10; -9] * [ -6; -3] -> 60, 30, 54; 27
; actually in this case the last option wins, which is upper-bound * upper-bound

; By testing the signs of the endpoints of the intervals, it is possible to 
; break mul-interval into nine cases, only one of which requires more than two 
; multiplications.
;
; hmmm... 9 cases ? 4 numbers each either positive or negative = 2^4 options
; since a * b = b * a, that's 8 options, plus 1 for ???

(define (pos? interval) 
  (and (> (lower-bound interval) 0) (> (upper-bound interval) 0)))

(define (neg? interval) 
  (and (< (lower-bound interval) 0) (< (upper-bound interval) 0)))

(define (spn? interval) 
  (and (< (lower-bound interval) 0) (> (upper-bound interval) 0)))

(define (mul2 x y)
  (let ((lx (lower-bound x)) (ux (upper-bound x)) 
        (ly (lower-bound y)) (uy (upper-bound y))) 
      (cond ((and (pos? x) (pos? y)) (make-interval (* lx ly) (* ux uy)))
            ((and (neg? x) (neg? y)) (make-interval (* lx ly) (* ux uy)))
            ((and (pos? x) (neg? y)) (make-interval (* ux uy) (* lx ly)))
            ((and (neg? x) (pos? y)) (make-interval (* ux uy) (* lx ly)))
            ((and (spn? x) (pos? y)) (make-interval (* lx uy) (* ux uy)))
            ((and (pos? x) (spn? y)) (make-interval (* ux ly) (* ux uy)))
            ((and (spn? x) (neg? y)) (make-interval (* ux uy) (* lx uy)))
            ((and (neg? x) (spn? y)) (make-interval (* ux uy) (* ux ly)))
            ((and (spn? x) (spn? y)) (make-interval (min (* lx uy) (* ux ly)) (* ux uy)))
            (else (error "case not handled")))))

(define (equal x y) 
  (and (= (lower-bound x) (lower-bound y)) 
       (= (upper-bound x) (upper-bound y))))

(define (mul2-test x y) 
  (let ((newmul (mul2 x y)) (oldmul (mul-interval x y)))
      (when (not (equal newmul oldmul))
            (error "mismatch:" newmul oldmul))))

(mul2-test (make-interval 1 2) (make-interval 3 4))       ; pos pos: ll, uu
(mul2-test (make-interval -1 -2) (make-interval -3 -4))   ; neg neg: ll, uu
(mul2-test (make-interval 1 2) (make-interval -3 -4))     ; pos neg: uu, ll
(mul2-test (make-interval -1 -2) (make-interval 3 4))     ; neg pos: uu, ll
(mul2-test (make-interval -1 2) (make-interval 3 4))      ; spn pos: lu, uu
(mul2-test (make-interval 1 2) (make-interval -3 4))      ; pos spn: ul, uu
(mul2-test (make-interval -1 2) (make-interval -3 -4))    ; spn neg: uu, lu
(mul2-test (make-interval -1 -2) (make-interval -3 4))    ; neg spn: uu, ul
(mul2-test (make-interval -1 2) (make-interval -3 4))     ; spn spn: min(lu, ul), uu
(mul2-test (make-interval -3 4) (make-interval -1 2))     ; spn spn: min(lu, ul), uu

