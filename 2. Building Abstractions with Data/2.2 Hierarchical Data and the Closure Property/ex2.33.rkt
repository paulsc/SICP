#lang racket

; Fill in the missing expressions to complete the following definitions of 
; some basic list-manipulation operations as accumulations: 

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) 
              null sequence))

;(map (lambda (x) (+ x 1)) '(1 2 3))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

;(append '(1 2 3) '(4 5 6))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(length '(1 2 3))
