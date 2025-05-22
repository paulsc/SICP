#lang racket

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op 
                      initial 
                      (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

;What are the values of

;(fold-right / 1 (list 1 2 3))
; (/ 1 (fold-right / 1 '(2 3)))
; (/ 1 (/ 2 (fold-right / 1 '(3))))
; (/ 1 (/ 2 (/ 3 (fold-right / 1 '()))))
; (/ 1 (/ 2 (/ 3 1)))
; = 1 / (2 / 3) = 3/2

;(fold-left  / 1 (list 1 2 3))
; result = 1 rest = '(1 2 3)
; result = (/ 1 1) rest = '(2 3)
; result = (/ 1 2) rest = '(3)
; result = (/ 1/2 3) result = '()
; result = 1/6

;(fold-right list null (list 1 2 3))
; (list 1 (fold-right list nil '(2 3)))
; (list 1 (list 2 (fold-right list nil '(3))))
; (list 1 (list 2 (list 3 nil)))
; '(1 (2 (3 ())))

;(fold-left  list null (list 1 2 3))
; (list (list (list '() 1) 2) 3))
; '(((() 1) 2) 3)

; Give a property that op should satisfy to guarantee that fold-right and 
; fold-left will produce the same values for any sequence. 
; a op b should be equal b op a

(provide fold-right fold-left)