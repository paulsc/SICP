#lang racket

(require "ex2.7.rkt")
(require "ex2.12.rkt")

(define (par1 r1 r2)
  (div-interval 
   (mul-interval r1 r2)
   (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval 
     one
     (add-interval 
      (div-interval one r1) 
      (div-interval one r2)))))

(define i1 (make-center-percent 10 0.1))
(define i2 (make-center-percent 20 0.1))

(par1 i1 i2)
(par2 i1 i2)

; div(x,y) = x * 1/y    since both are positive:
;          = ( lx / uy ; ux / ly )

(define res1 (div-interval i1 i1))  ; should be ( 9.9 / 10.1 ; 10.1 /  9.9 ) 

(center res1) (percent res1) ; should be 1