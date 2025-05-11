#lang racket

; Pascal's triangle
;       1
;      1 1
;     1 2 1
;    1 3 3 1
;   1 4 6 4 1
; 1 5 10 10 5 1 


; n is the row number: 0 = top row
; i is the index in the row: 0 = leftmost item

(define (pascal n i)
  (cond ((= i 0) 1)
        ((= i n) 1)
        ((> i n) (error "i > n"))
        (else (+ (pascal (- n 1) (- i 1))
              (pascal (- n 1) i)))))

(pascal 0 0)
(printf "~a ~a\n" (pascal 1 0) (pascal 1 1))
(printf "~a ~a ~a\n" (pascal 2 0) (pascal 2 1) (pascal 2 2))
(printf "~a ~a ~a ~a\n" (pascal 3 0) (pascal 3 1) (pascal 3 2) (pascal 3 3))

