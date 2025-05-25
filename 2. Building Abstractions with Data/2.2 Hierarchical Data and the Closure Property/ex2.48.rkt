#lang racket

(define make-segment list)
(define start-segment car)
(define end-segment cadr)

(provide make-segment start-segment end-segment)