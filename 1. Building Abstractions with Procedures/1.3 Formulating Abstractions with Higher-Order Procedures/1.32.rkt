#lang racket

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))


(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) 
                (accumulate combiner null-value term (next a) next b))))

(define (product-acc term a next b) (accumulate * 1 term a next b))
(define (sum term a next b) (accumulate + 0 term a next b))

(define (identity x) x)
(define (inc x) (+ x 1))
(define (factorial x) (product-acc identity 1 inc x))

(factorial 5)
(sum identity 1 inc 10)


; 2 iter vs recur

(define (acc-iter combiner null-value term a next b)
  (define (loop a result)
      (if (> a b)
          result
          (loop (next a) 
                (combiner result (term a)))))
  (loop a null-value))

(define (product-acc-iter term a next b) (accumulate * 1 term a next b))
(define (fact-iter x) (product-acc-iter identity 1 inc x))
(fact-iter 5)
