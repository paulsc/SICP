#lang racket

; 1. We use our 2D data-directed table where one axis is + / * and the other
;    axis is the procedures, here only one procedure: 'deriv.
;    We can't do that for number? or variable? because they don't follow the
;    format of tagged data '(+ x 2) where "+" is the tag.

(require "ex2.56.rkt")

(define lookup-table (make-hash))
(define (get proc type) (hash-ref lookup-table type))
(define (put proc type fn) (hash-set! lookup-table type fn))

(define operator car)
(define operands identity)

(define (install-sum-package)
  (define (deriv-sum exp var)
    (printf "deriv-sum exp:~a var:~a\n" exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
  (put 'deriv '+ deriv-sum))

(define (install-product-package)
  (define (deriv-product exp var)
    (printf "deriv-product exp:~a var:~a\n" exp var)
      (make-sum
       (make-product (multiplier exp)
                     (deriv (multiplicand exp) var))
       (make-product (deriv (multiplier exp) var)
                     (multiplicand exp))))
  (put 'deriv '* deriv-product))

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) 
           (if (same-variable? exp var) 
               1 
               0))
         (else ((get 'deriv (operator exp)) 
                (operands exp) 
                var))))


#|
(install-sum-package)
(install-product-package)

(deriv '(+ x 2) 'x)
(deriv '(* 4 x) 'x)
|#



; 3. 

(define (install-exponent-package)
  (define (deriv-expo exp var)
    (printf "deriv-product exp:~a var:~a\n" exp var)
    (make-product
      (make-product (exponent exp)
                    (make-exponentiation (base exp)
                                         (- (exponent exp) 1)))
      (deriv (base exp) var)))
  (put 'deriv '** deriv-expo))

#|
(install-exponent-package)
(deriv '(** x 3) 'x)
|#


; 4. If we swap the 'deriv / operator args we need to update all of our 
;    put and get call to respect the new order.
