#lang racket

(define (for-each fn l)
  (unless (null? l)
      (fn (car l))
      (for-each fn (cdr l))))

(for-each 
 (lambda (x) (printf "~a\n" x))
 (list 57 321 88))