#lang racket



(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree 
        elements (length elements))))

(define (partial-tree elts n)
;  (printf "partial-tree elts:~a n:~a\n" elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size 
             (quotient (- n 1) 2))) ; remove the root note and divide by 2
        (let ((left-result          ;
               (partial-tree        ; calculate the partial tree for the left
                elts left-size)))   ; this returns a cons (tree, remaining)
          (let ((left-tree               ;
                 (car left-result))      ; split (tree, remaing result) in vars
                (non-left-elts           ;
                 (cdr left-result))      ;
                (right-size              ; and calculate what the right side
                 (- n (+ left-size 1)))) ; size should be
            (let ((this-entry            ; 
                   (car non-left-elts))  ; store the root for later
                  (right-result          ; calculate the right size tree
                   (partial-tree 
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree           ;
                     (car right-result))  ;
                    (remaining-elts       ;  split the result again
                     (cdr right-result))) ;
                (cons (make-tree this-entry   ; make the tree and return it, 
                                 left-tree    ; along with the remaining elts
                                 right-tree)  ; that didn't make it to the tree
                      remaining-elts))))))))


; 1.
; This tree makes a balanced tree out of a list. 
; It slices the list in 2, the middle element becomes the root note, and
; the left half list will be the left tree, same for right.
; It knows how much elements it wants to have in each tree by doing
; left-size = n - 1 / 2 (integer division). -1 is for the root node.
; It keeps splitting until it reaches n = 0 which means the subtree will just
; be an empty node

;(list->tree '(1 3 5 7 9 11))

; 2.
; Order of growth? I'd say log(n) since we keep dividing n by 2.

(provide list->tree)