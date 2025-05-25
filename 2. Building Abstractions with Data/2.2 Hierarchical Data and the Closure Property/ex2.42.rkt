#lang racket

(require "seqlib.rkt") ; enumerate-interval

; | Queens has an internal procedure queen-cols that returns the sequence of all 
; | ways to place queens in the first k columns of the board. 

; Every solution can be represented as a list, the one in the example can be:
; '(3 7 2 8 5 1 4 6). So queen-cols should return a list of lists (?).

; | In this procedure rest-of-queens is a way to place k − 1 queens in the first 
; | k − 1 columns, and new-row is a proposed row in which to place the queen for 
; | the k th column.

; So we first call "enumerate-interval" wich retuns a list of options for where
; the next queen can be, and those are row numbers inside that last column.
; Then we call a map on it with (lambda (new-row) (...)), this loops through
; the number form 1-8 and adjoins to "rest-of-queens" which is the solution 
; for k-1. Presumably adjoin-position is just a list append ?

; flatmap takes that lambda and applies it to every solution, returning a 
; flattened version of the result. Not sure why since it's not flat...
; The lambda is the function that generates all options (viable or not)
; for row k.
; - so if (queen-cols (- k 1)) is ((3 7 2) (4 6 1) ... )
; - flatmap lambda is called and rest-of-queens is first (3 7 2)
; - we enumerate from 1...8
; - call (lambda (new-row) (...)). new-row is first '1'
; - this should return (3 7 2 1)
; - so flatmap lambda takes (3 7 2) and returns 
;   ((3 7 2 1) (3 7 2 2) (3 7 2 3) ...) hence the flattening needed
; - safe should take each of these and check if the element in the list
;   represents a safe queen position

(define empty-board '())
(define (adjoin-position new-row k rest-of-queens) 
  (append rest-of-queens (list new-row)))

;(define (test-1 board-size rest-of-queens k)
;  (map (lambda (new-row) (adjoin-position new-row k rest-of-queens))
;       (enumerate-interval 1 board-size)))
;(test-1 4 '(3 7 2) 1)

; check if queen in column i is a diagonal of queen in column k 
; not that k is 0-based here, not 1-based
(define (diagonal i k positions)
  (let ((new-queen (list-ref positions k))
        (current-queen (list-ref positions i))
        (column-diff (- k i))) 
    (= (abs (- current-queen new-queen)) column-diff)))

;(diagonal 0 2 '(1 2 3)) ; #t
;(diagonal 0 2 '(2 2 3)) ; #f
;(diagonal 1 2 '(1 2 3)) ; #t
;(diagonal 0 2 '(3 2 1)) ; #t
;(diagonal 0 2 '(1 3 5)) ; #f

(define (safe? k positions)
  ; check if all queens up to k - 1 are safe respective to this new queen 
  (define (is-column-unsafe i)
    (or (= (list-ref positions i)
           (list-ref positions (- k 1))) ; first check horizontally
        (diagonal i (- k 1) positions)))       ; then diagonally
  (not (accumulate (lambda (x y) (or x y)) 
                   #f
                   (map is-column-unsafe (enumerate-interval 0 (- k 2))))))


; (safe? 3 '(1 2 1)) ; #f
; (safe? 3 '(1 2 3)) ; #f
; (safe? 3 '(1 3 5)) ; #t

 
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) 
           (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 4)
; '((2 4 1 3) (3 1 4 2))


; some questions; 
; - why does k get passed around so much ? It could just be 
;   deducted everytime that k = length(positions). Maybe it's to not recompute
;   every time. Or maybe it's for clarity / versatility. safe? can then be
;   used in a scenario where we're not checking the last column of the board
;   but a different column. It's also more readable that way.
; - why does k get passed to adjoin-position, it is really not needed there