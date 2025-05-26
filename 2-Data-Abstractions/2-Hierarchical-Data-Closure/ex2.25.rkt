#lang racket

; Give combinations of cars and cdrs that will pick 7 from each of the 
; following lists:

(car (cdaddr '(1 3 (5 7) 9)))

(car (car '((7))))

(cadadr (cadadr (cadadr '(1 (2 (3 (4 (5 (6 7)))))))))