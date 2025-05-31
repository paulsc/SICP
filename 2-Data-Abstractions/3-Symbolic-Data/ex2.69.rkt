#lang racket

(require "hufflib.rkt")

; make-leaf-set is a procedure that takes things like this:
; ((A 4) (B 2) (C 1) (D 1)) and returns an ordered set of leaves:
; '((leaf D 1) (leaf C 1) (leaf B 2) (leaf A 4)) 
; so that the less frequent letters are at the beginning of the list
; this is handy because those are the farthest from the root and should
; be generated first in the recursion.

; Algo from the book:
; Begin with the set of leaf nodes, containing symbols and their frequencies, as
; determined by the initial data from which the code is to be constructed. Now
; find two leaves with the lowest weights and merge them to produce a node that
; has these two nodes as its left and right branches. The weight of the new node
; is the sum of the two weights. Remove the two leaves from the original set and
; replace them by this new node. Now continue this process. At each step, merge
; two nodes with the smallest weights, removing them from the set and replacing
; them with a node that has these two as its left and right branches. The
; process stops when there is only one node left, which is the root of the
; entire tree.

; So successive-merge should
; - if only 1 element in the set, done
; - otherwise take first 2, merge them with (make-code-tree) and replace those
;   two in the original set with this new merged tree
; - At this point, the set was originally ordered, but it might not be anymore
;   as the sum of the two elements before might be bigger than some other
;   combination. so it's important to insert the new element in the set at the
;   right place to keep the set ordered. 
;

(define (successive-merge leaf-set)
  (if (= (length leaf-set) 1)
      (car leaf-set)
      (successive-merge 
        (adjoin-set (make-code-tree (car leaf-set) (cadr leaf-set))
                    (cddr leaf-set)))))


(define (generate-huffman-tree pairs)
  (successive-merge 
   (make-leaf-set pairs)))

#|
(define pairs '((A 4) (B 2) (C 1) (D 1)))
(make-leaf-set pairs)
(generate-huffman-tree pairs)
|#

