#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low 
            (enumerate-interval 
             (+ low 1) 
             high))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(provide flatmap enumerate-interval accumulate accumulate-n)