#lang racket
(define (quadratisch list)
  (map sqr (filter integer? (map sqrt list))))

(define as '(1 2 3 4))
(define bs '(5 6 7 8))

(define (pythagoras as bs)
  (map (compose sqrt (curry apply +) (curry map sqr) list)
       as bs))

(define (pythagoras2 as bs)
  (map sqrt
       (map +
            (map sqr as) (map sqr bs))))
   


; ((compose sqr sqr sqr) 2)
; 256