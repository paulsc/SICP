#lang racket

(define (make-mobile left right) (list left right))
(define (make-branch length structure) (list length structure))

; 1. Write the corresponding selectors left-branch and right-branch, which return 
; the branches of a mobile, and branch-length and branch-structure, which 
; return the components of a branch. 

(define left-branch car)
(define right-branch cadr)
(define branch-length car)
(define branch-structure cadr)

; 2. Using your selectors, define a procedure total-weight that returns the 
; total weight of a mobile. 

(define (total-weight m)
  (printf "total-weight: ~a\n" m)
  (if (not (pair? m)) 
      m
      (+ (total-weight (branch-structure (left-branch m)))
         (total-weight (branch-structure (right-branch m))))))

(define m1 (make-mobile (make-branch 1 7) 
                        (make-branch 2 
                                     (make-mobile (make-branch 3 4) 
                                                  (make-branch 5 6)))))

(total-weight m1)

; 3. A mobile is said to be balanced if the torque applied by its top-left 
; branch is equal to that applied by its top-right branch (that is, if the 
; length of the left rod multiplied by the weight hanging from that rod is 
; equal to the corresponding product for the right side) and if each of the 
; submobiles hanging off its branches is balanced. Design a predicate that 
; tests whether a binary mobile is balanced. 

(define (balanced? m)
  (printf "m: ~a\n" m)
  (if (not (pair? m))
      #t
      (let ((left (left-branch m)) (right (right-branch m)))
        (printf "left: ~a right: ~a\n" left right)
        (and (balanced? (branch-structure left))
             (balanced? (branch-structure right))
             (= (* (branch-length left) (total-weight (branch-structure left)))
                (* (branch-length right) (total-weight (branch-structure right))))))))

(define m2 (make-mobile (make-branch 1 2) (make-branch 1 2)))
(define m3 (make-mobile (make-branch 1 10) 
                        (make-branch 1 
                                     (make-mobile (make-branch 1 5) 
                                                  (make-branch 1 5)))))

;(balanced? m3)

; cleaner solutions at https://mk12.github.io/sicp/exercise/2/2.html


; 4. just have to change the accessors to use cdr instead of cadr