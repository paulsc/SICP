#lang racket

; 1.
; We have to use data-directed programming, so one of those 2D tables.
; One axis presumably is the division, the other axis is the procedure,
; like get-record.
; So how do we tag the data?
; - the division file is preceded with a tag for the division name
;
; But... --> As an example, suppose that each division’s personnel records 
; consist of a single file, which contains a set of records keyed on employees’ 
; names.
; This means something like of a set from the previous sections, where there is
; a (key contents) combo, where the key is the name of the employee. But the 
; set can be a tree in one company, a list in another, etc...
; Which means each company needs to define it's own lookup procedure.

(define (get-record personnel-file name)
  (let ((division (type-tag personnel-file)))
    (let ((proc (get 'get-record division)))
      (proc name))))

; 2.
; Since individual records have different formats per division, the division
; defines a 'get-field function to retrieve a field from a record.
(define (get-salary personnel-file name)
  (let ((division (type-tag personnel-file)))
    (let ((record (get-record personnel-file name 'salary))
          (get-field (get 'get-field division))
        (get-field record)))))

; 3. 
(define (find-employee-record division-files name)
  (if (null? division-files) 
      #f
      (let ((record (get-record (car division-files) name)))
        (if (null? record)
            (find-employee-record (cdr division-files) name)
            record))))

; 4.
; When taking over a new company, they need to implement a get-record and a
; get-field procedure for this new company, and register it in the proc table.




; https://mk12.github.io/sicp/exercise/2/4.html
; ... has a solution that attaches a type-tag to the returned record,
; I misunderstood question 3 as it needs to take as an input a record instead
; of a personal file, hence the need for tagging the output.