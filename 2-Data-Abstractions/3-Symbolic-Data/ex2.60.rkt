#lang racket

(define (adjoin-set x set) (cons x set))
; this one runs in O(1) instead of O(n)

; intersection-set is the same
; still grows in O(n^2), except n is larger now with dups

; element-of-set? is the same
; and runs in O(n)

; This variation would be good where collisions are rare, (adjoin) calls
; are frequent, and element / intersection calls not so frequent


#|
(adjoin-set 3 '(1 2 4))
(element-of-set? 3 '(1 2 3 3))
|#

