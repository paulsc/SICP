#lang racket

(define (same-even-odd-parity? x y) 
  (or (and (even? x) (even? y))
      (and (not (even? x)) (not (even? y)))))

(define (same-parity . l)
  (define (loop result remaining)
    (if (null? remaining)
        result
        (if (same-even-odd-parity? (car l) (car remaining))
            (loop (append result (list (car remaining))) (cdr remaining))
            (loop result (cdr remaining)))))
    (loop (list (car l)) (cdr l)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)

; recursive: not xor checks if both arguments are the same
(define (sp . l)
  (define (loop items first-even?)
    (if (null? items)
        items
        (if (not (xor first-even? (even? (car items))))
            (cons (car items) (loop (cdr items) first-even?))
            (loop (cdr items) first-even?))))
  (loop l (even? (car l))))

; even shorter
(define (sp2 . l)
  (define (loop items)
    (if (null? items)
        items
        (if (not (xor (even? (car l)) (even? (car items))))
            (cons (car items) (loop (cdr items)))
            (loop (cdr items)))))
  (loop l))

(sp2 1 2 3 4 5 6 7)
(sp2 2 3 4 5 6 7)
