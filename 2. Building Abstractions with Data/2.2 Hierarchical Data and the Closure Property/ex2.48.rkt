#lang racket

(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

(provide make-segment start-segment end-segment)