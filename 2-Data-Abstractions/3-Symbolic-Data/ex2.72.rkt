#lang racket


; Order of growth in the worst case scenario of 2.71, the number of steps
; required to encode the most frequent symbol is O(1) since the leaf is always
; the first left branch of the tree. 
; For the least frequent symbol you need to go through (n-1) leaves and also
; for every node you are checking the list and comparing every element in the
; unordered set containing all the possible symbols for that branch, which
; for every node, worst case could be (n-1) + (n-2) + ....
; So the order of growth is O(n)