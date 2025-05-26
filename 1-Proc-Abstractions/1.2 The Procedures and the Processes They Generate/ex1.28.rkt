#lang sicp

; Two numbers are said to be congruent modulo n if they both have the same 
; remainder when divided by n. e.g. x and y are congruent modulo n if 
; x mod n = y mod n

; Miller-Rabin
; if n is a prime number and a is any positive integer less than n, then 
; a raised to the ( n − 1 ) -st power is congruent to 1 modulo n.
; means 
; a ^ (n - 1) mod n 
;     = 1 mod n
; buut... 1 mod n is always 1 ???