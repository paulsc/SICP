#lang racket

(define (* a b)
  (printf "a: ~a b: ~a\n" a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

; This algorithm takes a number of steps that is linear in b. Now suppose we
; include, together with addition, operations double, which doubles an integer,
; and halve, which divides an (even) integer by 2. Using these, design a
; multiplication procedure analogous to fast-expt that uses a logarithmic
; number of steps.

(define (double x) (+ x x))
(define (halve x) (/ x 2))

(* 3 100)

(define (fast-mult a b)
  (printf "a:~a b:~a\n" a b)
  (if (= b 0)
      0
      (if (even? b)
          (double (fast-mult a (halve b)))
          (+ (fast-mult a (- b 1))
             a))))

(fast-mult 3 100)