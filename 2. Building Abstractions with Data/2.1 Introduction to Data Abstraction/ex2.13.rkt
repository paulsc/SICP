#lang racket

; x * y = (lx*ly ; ux*uy) if both are positive 
;
; tol(x * y) = 1/2 (ux * uy - lx * ly)
;      2 tol = (lx + a)(ly + b) − lx * ly     ; if ux = lx + a and uy = ly + b
;      2 tol = a * ly + b * lx + a * b
;            = ly * a + lx * b                ; since a and b are very small
;        tol = 1/2 tol x + 1/2 tol y