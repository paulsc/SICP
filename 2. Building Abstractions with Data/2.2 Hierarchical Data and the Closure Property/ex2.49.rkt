#lang racket


; Exercise 2.49: Use segments->painter to define the following primitive painters:
;   1. The painter that draws the outline of the designated frame.
;   2. The painter that draws an “X” by connecting opposite corners of the frame.
;   3. The painter that draws a diamond shape by connecting the midpoints of the 
;      sides of the frame.
;   4. The wave painter.

(require "ex2.46.rkt") ; vector stuff
(require "ex2.47.rkt") ; frame stuff
(require "ex2.48.rkt") ; segment stuff

(define (frame-coord-map frame)
  (lambda (v)
    (printf "frame-coord-map lambda v:~a frame:~a\n" v frame)
    (add-vect
     (origin-frame frame)
     (add-vect 
      (scale-vect (edge1-frame frame) (xcor-vect v))
      (scale-vect (edge2-frame frame) (ycor-vect v))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) 
         (start-segment segment))
        ((frame-coord-map frame) 
         (end-segment segment))))
     segment-list)))

(define (outline frame)
  (segments->painter 
    (let ((bl (origin-frame frame))
          (br (add-vect (origin-frame frame) (edge1-frame frame)))
          (tl (add-vect (origin-frame frame) (edge2-frame frame)))
          (tr (add-vect (add-vect (origin-frame frame) (edge1-frame frame))
                        (edge2-frame frame))))
    (list (make-segment bl br)
          (make-segment br tr)
          (make-segment tr tl)
          (make-segment tl bl)))))

; drawing to PNG

(define (draw-line v1 v2)
  (printf "draw-line v1:~a v2:~a\n" v1 v2)
  (send dc set-pen "white" 2 'solid)
  (send dc draw-line (xcor-vect v1) (ycor-vect v1) 
                     (xcor-vect v2) (ycor-vect v2)))

(require racket/draw)

 
(begin
  (define bmp (make-bitmap 200 200))
  (define dc (new bitmap-dc% [bitmap bmp]))
  ;(draw-line (make-vect 10 10) (make-vect 20 20))
  (define frame-ref (make-frame (make-vect 0 0) (make-vect 0  1) (make-vect 1 0)))
  (define frame1 (make-frame (make-vect 10 10) (make-vect 100 0) (make-vect 0 100)))
  ((outline frame1) frame-ref)
  (send bmp save-file "image.png" 'png))

; Save to file


