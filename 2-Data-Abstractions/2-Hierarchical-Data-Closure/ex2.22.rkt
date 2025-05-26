#lang racket

(define (square x) (* x x))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

; we keep putting the first element of the remaing list in front of "answer"
; so the resulting list is reversed

; cons'ing a list and a primitive doesn't produce a list, you need append
