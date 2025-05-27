#lang racket

(require "ex2.56.rkt")

(define (check-equal? a b)
  (when (not (equal? a b)) (error "not equal")))

; Solution to 1.
;
; (define (sum? x) (and (pair? x) (eq? (cadr x) '+)))
; (define (addend s) (car s))
; (define (augend s) (caddr s))
; (define (product? x) (and (pair? x) (eq? (cadr x) '*)))
; (define (multiplier p) (car p))
; (define (multiplicand p) (caddr p))


; 2.
; - If we ignore the * vs. + priority problem for a sec, we can solve this by
;   changing the augend to process recursively the rest of the list.
;   But the rest of the list my be an addition, or a multiplication so the
;   augend/multplicand of sum and product have to call each other? This might
;   not work for (x * 3 + 2) where we have to do the product first and not
;   reduce it to (x + 5), like a recursive augend solution might do.
; - Or is it easier to try to convert this to a fully parenthesized expression,
;   which is already a solved problem? I can't change deriv though. We could
;   for the product force-wrap it in parens every time. 
;   So that (x * 3 + 2) becomes ((x * 3) + 2). 

; Let's try again, what if we use these cases:
;   - if there are only 3 elements same as 1. 
;     (this is imperfect as the some forms don't get reduced but that was a 
;     problem already, see sidebar below).
;   - for sum, if len > 3 and 4th is operator (x + 3 * 4) we consider this 
;     equivalent to (x + (3 * 4)), so the augend return (3 * 4)
;   - for product, if len > 3: (x * 3 + 4) this should be equivalent to
;     ((x * 3) + 4) so we have to modifier the multiplier fn this time
;     to return (x * 3). The multiplicand returns 4. Nooo.. that doesn't work
;     that would be (x * 3) * 4 instead of (x * 3) + 4.
;     does this procut need to return a sum ??
;     we could try to identify things of the shape ( a * x + b ) and convert 
;     them to ( b + a * x ). The instructions do mention we should change
;     the predicates.
;     we could have (a * x + (...)) return false for (product?) and true for 
;     (sum?) and change addend to return (a * x) and augend to return b




; ****** sidebar
; sidebar: how come our previous code was always able to parse the first
; element of a sum/product, even though addend/multiplier didn't have a 
; recursive call
; - because deriv calls deriv on the addend/augend for sums
; - for products we have in deriv:
;        ((product? exp)
;         (make-sum
;          (make-product 
;           (multiplier exp)
;           (deriv (multiplicand exp) var))
;          (make-product 
;           (deriv (multiplier exp) var)
;           (multiplicand exp))))
; so if the multiplier is a list, e.g. (* (+ 3 x) y) we get:
; (make-sum (make-product '(+ 3 x) (deriv 'y))
;           (make-product (deriv '(+ 3 x)) 'y)))
; (make-sum (make-product '(+ 3 x) 0)
;           (make-product 3 'y))
; result: '(* 3 y) this works because (deriv 'y) eval'ed to 0
; 
; what about for (* (* 3 x) (* 4 x))
; (make-sum (make-product '(* 3 x) (deriv '(* 4 x)))
;           (make-product (deriv '(* 3 x)) '(* 4 x)))
; it will solve deriv(3x) = 3 and deriv(4x) = 4 and return
; '(+ (* (* 3 x) 4) (* 3 (* 4 x)))
; in this example the first (* 3 x) was never 'parsed'.
; You can see this clearly in: (deriv '(* (* 0 x) (* 4 x)) 'x)
; gives: '(* (* 0 x) 4), means that the * 0 reduction rule was not applied
;
; sidebar conclusion: deriv doesn't always properly reduce, but also, anyhow
; derivation is not a fully recursive process.
; ****** end sidebar



; (3 * x + 4) should return as a sum
; (3 * x + 4 + 5)

; (augend '(3 + x * 4))

;(define (muladd? x)
;  (and (> (length x) 3)
;       (and (eq? (cadr x) '*)
;            (eq? (list-ref x 3) '+))))
;(define (sum? x) 
;  (and (pair? x) 
;       (or (eq? (cadr x) '+)
;           (muladd? x))))
;(define (addend s)
;  (if (muladd? s)
;      (list (car s) '* (caddr s)))
;      (car s))
;(define (augend s)
;  (if (muladd? s)
;    ()
;    (accumulate make-sum 0 (cddr sum)))
#|

(check-equal? (sum? '(3 + 3)) #t)
(check-equal? (sum? '(3 * 3)) #f)
(check-equal? (sum? '(3 * 3 + 2)) #t)
(check-equal? (product? '(3 * 3 + 2)) #f)

|#

(define (sum? x) (and (pair? x) (eq? (cadr x) '+)))
(define (addend s) (car s))
(define (augend s) 
  (if (null? (cdddr s))
      (caddr s)
      (make-sum-or-product (cddr s))))

(define (make-sum-or-product x)
  (printf "make-sum-or-product: ~a\n" x)
   (if (null? (cdr x))
       (car x)
       (cond ((sum? x) (make-sum (car x) (make-sum-or-product (cddr x))))
             ((product? x) (make-product (car x) (make-sum-or-product (cddr x))))
             (else (error "unknwon operator")))))

#|
(augend '(x + 2))
(augend '(x + 2 + y + 4 * z))
(deriv '(x + 2 + 3) 'x)
(augend '(x + 2 * 3))
(cddr '(2 + 3))
(check-equal? (deriv '(x + 3 * (x + y + 2)) 'x) 4)
TODO: multiplication precedence
(deriv '(x * 3 + (x + y + 2)) 'x)

solution from https://mk12.github.io/sicp/exercise/2/3.html is 
way cleaner and simpler. simply chopping up before / after the operator
using helper function.
|#


(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) 
         (+ a1 a2))
        (else (list a1 '+ a2))))

(define (product? x) (and (pair? x) (eq? (cadr x) '*)))
(define (multiplier p) (car p))
(define (multiplicand p) (caddr p))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) 
             (=number? m2 0)) 
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) 
         (* m1 m2))
        (else (list m1 '* m2))))

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

