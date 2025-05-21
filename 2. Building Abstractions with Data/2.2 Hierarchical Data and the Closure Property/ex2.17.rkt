#lang racket

; Define a procedure last-pair that returns the list that contains only the 
 ;last element of a given (nonempty) list:

(define (lastpair list)
  (if (null? (cdr list))
      list
      (lastpair (cdr list))))

(last-pair (list 23 72 149 34))
; (34)

