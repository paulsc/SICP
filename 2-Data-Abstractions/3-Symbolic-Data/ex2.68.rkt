#lang racket

(require "hufflib.rkt")

;  You should design encode-symbol so that it signals an error if the symbol 
; is not in the tree at all.

; check if symbol matches either left or right branch
; either as a leaf, or in the set of the tree
; if it matches as a leaf, we're done, otherwise append either 0 for left
; or 1 for right with the recursive call to encode-symbol on that tree
(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
    ((memq symbol (symbols (left-branch tree)))
      (cons '0 (encode-symbol symbol (left-branch tree))))
    ((memq symbol (symbols (right-branch tree)))
      (cons '1 (encode-symbol symbol (right-branch tree))))
    (else
      (error "Symbol not in tree: ~a" symbol))))

(define (encode message tree)
  (if (null? message)
      '()
      (append 
       (encode-symbol (car message) tree)
       (encode (cdr message) tree))))

(define message '(A D A B B C A))

(define sample-tree
  (make-code-tree 
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2) 
    (make-code-tree (make-leaf 'D 1) (make-leaf 'C 1)))))

#|
(encode-symbol 'A sample-tree)
(encode-symbol 'B sample-tree)
(encode-symbol 'C sample-tree)
(encode-symbol 'D sample-tree)
(encode message sample-tree)
|#
