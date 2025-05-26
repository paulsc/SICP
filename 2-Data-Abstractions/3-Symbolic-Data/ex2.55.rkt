#lang racket


(list-ref ''abcd 1)

; 'abracadabra is the symbol "abracadabra"
; quoting that
;
; ''abracadabra evaluates to the list whose first element is
; 'quote and the second is ??

; see
; https://mk12.github.io/sicp/exercise/2/3.html