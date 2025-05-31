#lang racket

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

; append the list of the left branch with the cons of the entry and the 
; right branch. 
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append 
       (tree->list-1 
        (left-branch tree))
       (cons (entry tree)
             (tree->list-1 
              (right-branch tree))))))


; This is the iterative version (?) is it though, there's 2 recur calls
; it's like a loop with result-list as a var
; result-list is updated every loop to be the cons of:
; - the entry (current root node)
; - and a recursive call with the right tree and the same result-list


;      A          B             C
;
;      7          3             5
;     / \        / \          /  \
;    3   9      1  7         3   9
;   / \   \       / \       /   / \
;  1   5  11     5  9      1   7  11
;                    \
;                    11

;(define tree-a (make-tree 7 
;                 (make-tree 3 (make-tree 1 '() '()) (make-tree 5 '() '()))
;                 (make-tree 9 '() (make-tree 11 '() '()))))
;
;(define tree-b (make-tree 3 
;                 (make-tree 1 '() '())
;                 (make-tree 7 (make-tree 5 '() '()) 
;                              (make-tree 9 '() (make-tree 11 '() '())))))
;
;(define tree-c (make-tree 5 
;                 (make-tree 3 (make-tree 1 '() '()))
;                 (make-tree 9 (make-tree 7 '() '()) (make-tree 11 '() '()))))
;
;
;(tree->list-1 tree-b)
;(tree->list-2 tree-b)


(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list 
         (left-branch tree)
         (cons (entry tree)
               (copy-to-list 
                (right-branch tree)
                result-list)))))
  (copy-to-list tree '()))

(provide tree->list-1)