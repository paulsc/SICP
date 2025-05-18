#lang racket

(define tolerance 0.00001)

(define (close-enough? x y) 
  (< (abs (- x y)) 0.001))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess)
    (printf "guess: ~a\n" guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
; guess: 1.0
; guess: 2.0
; guess: 1.5
; guess: 1.6666666666666665
; guess: 1.6
; guess: 1.625
; guess: 1.6153846153846154
; guess: 1.619047619047619
; guess: 1.6176470588235294
; guess: 1.6181818181818182
; guess: 1.6179775280898876
; guess: 1.6180555555555556
; guess: 1.6180257510729614
; guess: 1.6180371352785146
; 1.6180327868852458


; x = log(1000) / log(x)

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
; guess: 2.0
; guess: 9.965784284662087
; guess: 3.004472209841214
; guess: 6.279195757507157
; guess: 3.759850702401539
; guess: 5.215843784925895
; guess: 4.182207192401397
; guess: 4.8277650983445906
; guess: 4.387593384662677
; guess: 4.671250085763899
; guess: 4.481403616895052
; guess: 4.6053657460929
; guess: 4.5230849678718865
; guess: 4.577114682047341
; guess: 4.541382480151454
; guess: 4.564903245230833
; guess: 4.549372679303342
; guess: 4.559606491913287
; guess: 4.552853875788271
; guess: 4.557305529748263
; guess: 4.554369064436181
; guess: 4.556305311532999
; guess: 4.555028263573554
; guess: 4.555870396702851
; guess: 4.555315001192079
; guess: 4.5556812635433275
; guess: 4.555439715736846
; guess: 4.555599009998291
; guess: 4.555493957531389
; guess: 4.555563237292884
; guess: 4.555517548417651
; guess: 4.555547679306398
; guess: 4.555527808516254
; guess: 4.555540912917957
; 4.555532270803653
; this took 33 guesses

; now with average damping:
; instead of moving each guess to f(x), we move it half-way
; we had
; f(x) = log(1000) / log(x)
; f(x) = 1/2 (x + log(1000) / log(x))

(fixed-point (lambda (x) (/ (+ x 
                               (/ (log 1000) 
                                  (log x))) 
                            2)) 
             2.0)
; guess: 2.0
; guess: 5.9828921423310435
; guess: 4.922168721308343
; guess: 4.628224318195455
; guess: 4.568346513136242
; guess: 4.5577305909237005
; guess: 4.555909809045131
; guess: 4.555599411610624
; guess: 4.5555465521473675
; 4.555537551999825
; this only took 8 guesses