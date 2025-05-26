#lang racket


; Exercise 2.49: Use segments->painter to define the following primitive painters:

(require racket/draw)

(require "ex2.46.rkt") ; vector stuff
(require "ex2.47.rkt") ; frame stuff
(require "ex2.48.rkt") ; segment stuff

(define (frame-coord-map frame)
  (lambda (v)
    ;(printf "frame-coord-map lambda v:~a frame:~a\n" v frame)
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


; connect vectors with segments
(define (connect . vectors)
  (define (helper vectors first)
    (cond ((null? vectors) '())
          ((= (length vectors) 1) 
            (list (make-segment (car vectors) first)))
          (else
            (cons (make-segment (car vectors) (cadr vectors)) 
                  (helper (cdr vectors) first)))))
  (helper vectors (car vectors)))

#|
(connect (make-vect 0 0) (make-vect 1 1) (make-vect 2 2))
|#

; call a lambda with the corners of a frame
(define (call-with-corners fn frame)
  (let ((bl (origin-frame frame))
        (br (add-vect (origin-frame frame) (edge1-frame frame)))
        (tl (add-vect (origin-frame frame) (edge2-frame frame)))
        (tr (add-vect (add-vect (origin-frame frame) (edge1-frame frame))
                      (edge2-frame frame))))
    (fn bl br tr tl)))

#|
(frame-corners frame1)
|#

;   1. The painter that draws the outline of the designated frame.
(define (outline-wrong frame)
  (segments->painter 
    (call-with-corners connect frame)))

; solution from https://mk12.github.io/sicp/exercise/2/2.html
; doesn't take a frame as an argument. Looks like I waaaay misunderstood this.
; instead of having outline take a frame and return a lambda that takes a frame
; it should just take a frame directly, so there is no "reference frame"
; 
; I just had to draw the shape in the 0 < x,y < 1 coords.
(define outline
  (segments->painter
   (list (make-segment (make-vect 0 0) (make-vect 1 0))
         (make-segment (make-vect 0 1) (make-vect 1 1))
         (make-segment (make-vect 0 0) (make-vect 0 1))
         (make-segment (make-vect 1 0) (make-vect 1 1)))))

#|
(run-draw outline)
|#

;   2. The painter that draws an “X” by connecting opposite corners of the frame.

(define (draw-x-wrong frame)
  (segments->painter 
    (call-with-corners 
      (lambda (bl br tr tl)
        (list (make-segment bl tr)
              (make-segment tl br)))
      frame)))


(define draw-x
  (segments->painter
    (list (make-segment (make-vect 0 0) (make-vect 1 1))
          (make-segment (make-vect 0 1) (make-vect 1 0)))))


#|
(run-draw draw-x)
|#

;   3. The painter that draws a diamond shape by connecting the midpoints of the 
;      sides of the frame.

(define (average x y) (/ (+ x y) 2))
(define (midpoint v1 v2) ; from ex2.2.rkt
  (make-vect (average (xcor-vect v1) (xcor-vect v2))
             (average (ycor-vect v1) (ycor-vect v2))))

(define (diamond-wrong frame)
  (segments->painter 
    (call-with-corners 
      (lambda (bl br tr tl)
        (let ((a (midpoint bl br)) (b (midpoint br tr))
              (c (midpoint tr tl)) (d (midpoint tl bl)))
          (connect a b c d)))
      frame)))

(define diamond
  (segments->painter
    (list (make-segment (make-vect 0 0.5) (make-vect 0.5 0))
          (make-segment (make-vect 0.5 0) (make-vect 1 0.5))
          (make-segment (make-vect 1 0.5) (make-vect 0.5 1))
          (make-segment (make-vect 0.5 1) (make-vect 0 0.5)))))

#|
(run-draw diamond)
|#

;   4. The wave painter.

; drawing to PNG

(define dc null)
(define (draw-line v1 v2)
  (printf "draw-line v1:~a v2:~a\n" v1 v2)
  (send dc set-pen "white" 2 'solid)
  (send dc draw-line (xcor-vect v1) (ycor-vect v1) 
                     (xcor-vect v2) (ycor-vect v2)))

(define (run-draw fn)
  (define bmp (make-bitmap 200 200))
  (set! dc (new bitmap-dc% [bitmap bmp]))
  (define frame1 (make-frame (make-vect 10 10) (make-vect 180 0) (make-vect 0 180)))
  (printf "running drawing fn...\n")
  (fn frame1)
  (printf "done\n")
  (send bmp save-file "image.png" 'png))

(define (clear-draw) (run-draw (lambda (ref) ref)))

#|
(clear-draw)
|#

(provide frame-coord-map segments->painter run-draw)