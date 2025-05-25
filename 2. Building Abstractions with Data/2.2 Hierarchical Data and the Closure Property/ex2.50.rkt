#lang racket

(require racket/draw)

(require "ex2.46.rkt") ; vector stuff
(require "ex2.47.rkt") ; frame stuff
(require "ex2.48.rkt") ; segment stuff
(require "ex2.49.rkt") ; segments->painter 

(define number-1
  (segments->painter 
    (list (make-segment (make-vect 0.5 0) (make-vect 0.25 0.3))
          (make-segment (make-vect 0.5 0) (make-vect 0.5 1))
          (make-segment (make-vect 0.45 1) (make-vect 0.55 1)))))
#|
(run-draw number-1) 
|#

(define (transform-painter 
         painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame new-origin
                  (sub-vect (m corner1) 
                            new-origin)
                  (sub-vect (m corner2)
                            new-origin)))))))

(define (flip-vert painter)
  (transform-painter 
   painter
   (make-vect 0.0 1.0)   ; new origin
   (make-vect 1.0 1.0)   ; new end of edge1
   (make-vect 0.0 0.0))) ; new end of edge2

(define (flip-horiz painter)
  (transform-painter 
   painter
   (make-vect 1.0 0.0)   ; new origin
   (make-vect 0.0 0.0)   ; new end of edge1
   (make-vect 1.0 1.0))) ; new end of edge2

(define (rotate-180 painter)
  (transform-painter 
   painter
   (make-vect 1.0 1.0)   ; new origin
   (make-vect 0.0 1.0)   ; new end of edge1
   (make-vect 1.0 0.0))) ; new end of edge2

(define (rotate-270 painter)
  (transform-painter 
   painter
   (make-vect 0.0 1.0)   ; new origin
   (make-vect 0.0 0.0)   ; new end of edge1
   (make-vect 1.0 1.0))) ; new end of edge2

#|
(run-draw number-1)
(run-draw (flip-vert number-1))
(run-draw (flip-horiz number-1))
(run-draw (rotate-180 number-1))
(run-draw (rotate-270 number-1))
|#

