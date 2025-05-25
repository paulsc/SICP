#lang racket

;(define (right-split painter n)
;  (if (= n 0)
;      painter
;      (let ((smaller (right-split painter (- n 1))))
;        (beside painter (below smaller smaller)))))
;
;(define (up-split painter n)
;  (if (=n 0)
;    painter
;    (let ((smaller (up-split painter (- n 1))))
;      (below painter (beside smaller smaller)))))

(define (split proc1 proc2)
  (define (recur painter n)
    (if (= n 0)
        painter
        (let ((smaller (recur painter (- n 1))))
          (proc1 painter (proc2 smaller smaller)))))
  recur)

(define right-split (split beside below))
(define up-split (split below beside))