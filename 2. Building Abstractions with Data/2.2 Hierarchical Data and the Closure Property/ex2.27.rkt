#lang racket

(define (reverse l)
  (if (null? l)
    l
    (append (reverse (cdr l)) 
            (list (car l)))))

(define x 
  (list (list 1 2) (list 3 4)))

(reverse x)

; '((1 2) (3 4))

(define (deep-reverse l)
  (if (not (pair? l))
      l
      (map deep-reverse (reverse l))))

(deep-reverse x)
