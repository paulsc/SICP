#lang racket

(require "hufflib.rkt")

(define rock '((A 2) (BOOM 1) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 9) (WAH 1)))

(define rock-huff (generate-huffman-tree rock))

;(encode-symbol 'SHA rock-huff)
;(encode-symbol 'BOOM rock-huff)

(length (encode 
  '(GET A JOB SHA NA NA NA NA NA NA NA NA
    GET A JOB SHA NA NA NA NA NA NA NA NA
    WAH YIP YIP YIP YIP
    YIP YIP YIP YIP YIP
    SHA BOOM)
  rock-huff))
; 84 bits required
; with a fixed length code, eignt-sybol alphabet we need 3 bits per symbol
; 36 symbols in the song, so 108 bits required