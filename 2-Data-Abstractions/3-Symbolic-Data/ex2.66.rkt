#lang racket

; version for a unordered list
; (define (lookup given-key set-of-records)
;   (cond ((null? set-of-records) false)
;         ((equal? given-key 
;                  (key (car set-of-records)))
;          (car set-of-records))
;         (else 
;          (lookup given-key 
;                  (cdr set-of-records)))))

; we copy element-of-set? from before:
; (define (element-of-set? x set)
;   (cond ((null? set) false)
;         ((= x (entry set)) true)
;         ((< x (entry set))
;          (element-of-set? 
;           x 
;           (left-branch set)))
;         ((> x (entry set))
;          (element-of-set? 
;           x 
;           (right-branch set)))))

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((= given-key (key (entry set-of-records))) true)
        ((< given-key (key (entry set-of-records)))
         (lookup 
          given-key 
          (left-branch set-of-records)))
        ((> given-key (key (entry set-of-records)))
         (lookup
          given-key 
          (right-branch set-of-records)))))