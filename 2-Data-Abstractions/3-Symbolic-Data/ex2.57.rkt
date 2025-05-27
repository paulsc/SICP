#lang racket

(require "ex2.56.rkt")

(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) 
  (if (null? (cdddr s))
      (caddr s)
      (make-sum (addend (cdr s)) (augend (cdr s)))))

; cleaner solution from https://mk12.github.io/sicp/exercise/2/3.html
; (define (augend sum)
;   (accumulate make-sum 0 (cddr sum)))



; (define exp1 '(+ 1 2))
; (addend exp1)
; (augend exp1)
; 
; (define exp2 '(+ 1 x y z))
; (addend exp2)
; (augend exp2)
; 
; (cdddr exp) ; if this is not '() then we can make another sum in augend
;             ; otherwise... keep same behavior?
;             ; how do we make the other sum? we want term 2 & 3
;             ; but recursively also if we have term 4 etc...
;             ; '(+ 1 2 3 4)
;             ; so the (augend ...) returns (make-sum 2 (make-sum 3 (make-sum 4 0)))
;             ; let's review the flow.
;             ; we pass a list of symbols to (deriv ..) (+ 1 2 3 4)
;             ; it finds the operators, and uses make-sum to make a data structure
;             ; addend and augend is used to split the terms in 2, in our case
;             ; the 1st term of the addition and then the rest of them
;             ; make-sum is only used in our deriv function with 2 terms
;             ; so augend should check: do we have total 2 args or more?
;             ; if 2, keep same behavior (check for (null? cdddr)
;             ; if 3+, s becomes (cdr s) and return (make-sum addend augend)
; 

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) 
         (+ a1 a2))
        (else (list '+ a1 a2))))
#|
(make-sum 0 1)    ; 1
(make-sum 1 1)    ; 2
(make-sum 'x 0)   ; 'x
(make-sum 1 'x)   ; x + 1
(make-sum 1 1 1)  ; 3
(make-sum 1 1 'x) ; 3
(augend '(+ (* 3 x) (* 2 (** x 2)) (* 4 x)))
|#

(define (product? x) (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))

(define (multiplicand p) 
  (if (null? (cdddr p))
      (caddr p)
      (make-product (addend (cdr p)) (augend (cdr p)))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) 
             (=number? m2 0)) 
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) 
         (* m1 m2))
        (else (list '* m1 m2))))

#|
(deriv '(* (* x y) (+ x 3)) 'x)
(deriv '(** x 3) 'x)
(deriv '(+ (* 3 x) y) 'x)
(deriv '(* (* 3 x) y) 'x)
(deriv '(* (* 3 x) (* 4 x)) 'x)
(deriv '(* (* 0 x) (* 4 x)) 'x)
(deriv '(+ (* 3 x) (* 4 x)) 'x)
(deriv 'y 'x)
(deriv '(* 3 x) 'x)
|#

; 
; (deriv '(* x y (+ x 3)) 'x) 
; '(+ (* x y) (* y (+ x 3)))


(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product 
           (multiplier exp)
           (deriv (multiplicand exp) var))
          (make-product 
           (deriv (multiplier exp) var)
           (multiplicand exp))))
        ((exponentiation? exp)
         (make-product
           (make-product (exponent exp) 
                         (make-exponentiation (base exp) 
                                              (- (exponent exp) 1)))
           (deriv (base exp) var)))
        (else (error "unknown expression 
                      type: DERIV" exp))))

