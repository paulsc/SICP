(define (f g) (g 2))

; expected an infinite loop
(f f)

; but actually got an execution error:
;    expected a procedure that can be applied to arguments
;    given: 2
; 
; hmmm..
(f f) 
; subsitutes to:
((lambda (g) (g 2)) (lambda (g) (g 2)))
; we substitute in (g 2) to get:
((lambda (g) (g 2)) 2)
; which substitutes to
(2 2)
; so the error is that we are trying to run "2" as a function