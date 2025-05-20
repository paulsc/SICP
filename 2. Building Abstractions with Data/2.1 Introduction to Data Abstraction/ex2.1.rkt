#lang racket

(define (gcd a b)
   (if (= b 0)
       a
       (gcd b (remainder a b))))

(define (make-rat n d)
  (cond ((and (< n 0) (< d 0)) (make-rat (abs n) (abs d)))
        ((and (> n -1) (< d 0)) (make-rat (* n -1) (abs d)))
        (else (let ((g (gcd n d))) 
                (cons (/ n g) 
                      (/ d g))))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x) (printf "~a/~a\n" (numer x) (denom x)))

(print-rat (make-rat -2 -3)); 2/3
(print-rat (make-rat -2 3)) ; -2/3
(print-rat (make-rat 2 -3)) ; -2/3