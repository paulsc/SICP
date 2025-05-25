#lang racket

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define origin-frame car)
(define edge1-frame cadr)
(define edge2-frame caddr)

; (define (make-frame origin edge1 edge2)
;   (cons origin (cons edge1 edge2)))
; 
; (define origin-frame car)
; (define edge1-frame cadr)
; (define edge2-frame cddr)
; 
; (define f1 (make-frame 1 2 3))
; (origin-frame f1)
; (edge1-frame f1)
; (edge2-frame f1)

(provide make-frame origin-frame edge1-frame edge2-frame)