#lang racket

; > describe the changes that must be made to a system in order to add new types 
;   or new operations

; - Generic operations with explicit dispatch
;   Need to update the generic operations everytime to handle a new case for
;   the new type. New operations requires creating a new generic operation
;   and adding support for every type

; - Data directed style
;   The 2D table allows us to just install our package without affecting 
;   previous dispatching code, both for new types or new operations

; - Message passing
;   New types require a new constructor which is independent from previous code
;   but which has to support all the previous operations.
;   New operations require modifying all the previous constructors.



; When adding types a lot:
; - Message passing or data-directed would allow doing that without touching 
;   existing code.

; When adding operations a lot:
; - Data-directed is appropriate, generic operations and message passing both
;   require modifications to existing code.