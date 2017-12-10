#lang racket
(require 2htdp/image)
;Aufgabe 1.1

#|
a) Funktion (take n xs)

Bei der Funktion take handelt es sich um eine lineare Rekursion über eine Liste.
Die sich auf der rechten Seite der definierenden Gleichung in jeder Fallunterscheidung
selbst nur einmal verwendet.

b) Funktion (drop n xs)

c) Funktion (merge rel<? xs ys)
Es handelt sich bei der merge um eine baumartige Rekursion, da in der
Fallunterscheidung mehrfach auf die Definition Bezug genommen wird.

d) Funktion (merge-sort rel<? xs)
Es handelt sich bei der merge um eine baumartige Rekursion, da in der
Fallunterscheidung mehrfach auf die Definition Bezug genommen wird.
Nicht um eine Geschachtelte Rekursion, da andere Funktionen als übergebenhat


(define (make-fire x outcolor incolor)
  (if (> x 1) 
      (overlay/align
       "center" "bottom"
       (rhombus 20 45 "solid" outcolor)
       (rhombus 35 45 "solid" incolor)
       (rhombus 42 (+ -140 (/ 280 x)) "solid" outcolor)
       (rhombus 38 (+ 140 (/ 280 x)) "solid" incolor)
        
       (make-fire (- x 1) outcolor incolor)
       ; (make-fire (- x ) incolor outcolor)
       )
  
      (rhombus 40 (+ -140 (/ 340 x)) "solid" outcolor)
       
      ))


|#


;Aufgabe 2

;Leere Szene 800 x 400
(define empty-canvas '(empty-scene 800 400 (make-color 110 30 30)))


;erstellt Boden und Teppich

(define floor (overlay/align
               "center" "bottom"
               (rectangle 400 90 "solid" (make-color 198 161 134))
               (rectangle 800 100 "solid" (make-color 151 115 108))
               ))
  
;Fügt boden zu der Szene hinzu

(define ground-scene '(place-image (eval floor) 400 370 (eval empty-canvas)))


;erstellt Kamin und Feuer

(define (make-fire x outcolor incolor)
  (if (> x 1) 
      (overlay/align
       "center" "bottom"
       (rhombus (/ 80 x) 45 "solid" outcolor)
       ; (rotate (* 8 x)(rhombus (* x 1.2) 7 "solid" incolor))
               
       ; (rhombus (* 8 x) 20 "solid" incolor)
        
       (make-fire (- x 1) incolor outcolor)
       ; (make-fire (- x ) incolor outcolor)
       )
  
      (make-inner-fire 4 incolor outcolor)
       
      ))

(define (make-inner-fire x color seccolor)
  (if (> x 1)
      (overlay
       (isosceles-triangle  (/ 140 x)  90 "solid" color)
       (make-inner-fire (- x 1) seccolor color))
      (isosceles-triangle  0  120 "solid" color)
      ))
 

(define chimney (overlay/align
                 "center" "bottom"
                 (make-fire 10 "red" "yellow")
                 ;(rectangle 40 40 "solid" (make-color 255 0 0))
                 (rectangle 100 80 "solid" (make-color 0 0 0))
                 (rectangle 120 90 "solid" (make-color 67 34 33))
                 )

  ) 
                  
;Fügt Kamin& Feuer zur letzt erstellten Szene hinzu

(define fire-scene '(place-image (eval chimney) 400 300 (eval ground-scene)))




;erstellt Socke

(define uppersock (above
                   (rectangle 22 5 "solid" (make-color 255 255 255))
                   (rectangle 20 30 "solid" (make-color 170 23 51))
                   )
  )

(define full-sock (overlay/align "left" "bottom"
                                 uppersock
                                 (ellipse 30 14 "solid" (make-color 170 23 51))
                                 ))

;fügt Socken zu Sockenpaaren zusammen

(define socks (beside full-sock
                      full-sock
                      full-sock)
  )



;Fügt Socken zur letzt erstellten Szene hinzu

(define fire-sock-scene '(place-image (eval socks) 400 230 (eval fire-scene)))


;Erstellt Kranz


(define kerze (above
               (ellipse 8 18 "solid" "red")
               (rectangle 15 40 "solid" (make-color 255 248 80))
               ))

(define kerzen-circle (underlay/align "center" "bottom"
                                      (circle 40 "solid" (make-color 110 30 30))
                                      kerze
                                      ))

(define kranz (underlay/align "center" "middle"
                              (star-polygon 20 20 3 "solid" (make-color 62 101 11))
                              kerzen-circle
                              ))



  
                  
;Fügt Kranz zur letzt erstellten Szene hinzu

(define fire-sock-kranz-scene '(place-image (eval kranz) 400 125 (eval fire-sock-scene)))





;erstellt Fenster

(define window (overlay/align
                "center" "middle"
                (rectangle 80 10 "solid" (make-color 67 34 33))
                (rectangle 10 80 "solid" (make-color 67 34 33))
                (rectangle 80 80 "solid" (make-color 0 0 255))
                (rectangle 100 100 "solid" (make-color 67 34 33))
                )

  )
                  
;Fügt Fenster zur letzt erstellten Szene hinzu

(define fire-window-scene1 '(place-image (eval window) 600 150 (eval fire-sock-kranz-scene)))
(define done-background '(place-image (eval window) 200 150 (eval fire-window-scene1)))




;erstellt ersten Baum (links)


;Baumschmuck
(define (baumschmuck x color seccolor)
  (if ( > x 1)         
      (overlay/offset
       (kugelrekursion 5 color seccolor)
       (/ (* (- 70) x) 4)  -10       
       (baumschmuck (- x 1) seccolor color)
       )
      (kugelrekursion 5 color seccolor)
      )
  )

(define (kugelrekursion x color seccolor)
  (if (> x 1 )
      (overlay/align "center" "middle"
                     (circle (- 10 (* x 2)) "solid" color)
                     (kugelrekursion (- x 0.5) seccolor color)
                     )
      (circle 8 "solid" "yellow")
      )
  )
  


                  
                 

;Baumstern
(define (baum1-stern x color seccolor)
  (if (> x 1)
      (overlay                
       (star-polygon (- 50 (* x 4) ) 5 2 "solid" color)
                 
       (baum1-stern (- x 1) seccolor color)
   
       )
      (star-polygon 0 5 2 "solid" color)
      ))


;Blätter mit schmuck
(define (blätter-mit-schmuck x) (overlay/align "center" "middle"
                                           
                                               (baumschmuck x "red" "blue")
                                               (isosceles-triangle  ( * 20 x)  90 "solid" (make-color 18 140 0))

                                               ))


;eckige Baumblätter

(define (baum1-blätter x) 
  (if (> x 1)
      (overlay/offset 
       (blätter-mit-schmuck x)
       0 (/ (* (- 100) x) 4)
       (baum1-blätter (- x 1))
       )
      (isosceles-triangle 0 30 "solid" "seagreen")
      ))


(define (outer-leafs x)
  (if (> x 1)
      (overlay/offset 
       (isosceles-triangle ( * 35 x)  90 "solid" (make-color 90 160 0))
       0  (/ (* (- 100) x) 4)
       (outer-leafs (- x 1))
       )
      (isosceles-triangle 0 30 "solid" "seagreen")
      ))

(define (outer-leafs2 x)
  (if (> x 1)
      (overlay/offset 
       (isosceles-triangle ( * 40 x)  80 "solid" (make-color 0 100 0))
       0 -100
       (outer-leafs2 (- x 1))
       )
      (isosceles-triangle 0 30 "solid" "seagreen")
      ))

; (make-color 90 160 0)
;(make-color 128 140 0)
; (make-color 0 100 0)

;Baumblätter auf großem Dreieck
(define (baum1-körper x)
  (overlay/align
   "center" "middle"
   (baum1-blätter (+ x 2))
   (outer-leafs (+ x  1))
   (outer-leafs2 (+ x 2 ))
   ))


; Steckt den Baum zusammen mit Stern Körper und Stamm
(define baum1-ohne-stern
  (above/align "center"

               ;; die Blätter
               (baum1-körper 4)
               ;der Stamm
               (rectangle 30 60 "solid" "brown")
               ))

(define baum1-mit-stern
  (overlay/offset
   ;; der rekursiver Stern an der Spitze   
   (baum1-stern 9 "yellow" "red")
   0 175
   baum1-ohne-stern
   ))


;Fügt den ersten Baum zur letzt erstellten Szene hinzu, welche done-background ist.
  
(define scene-baum1 '(place-image (eval baum1-mit-stern) 100 200 (eval done-background)))


;Erstellt den zweiten Tannenbaum


(define (generate-leafs2 x)
  (if (> x 1)
  (overlay
   (pulled-regular-polygon 290 3 1/3 30 "solid" "green")
   (generate-leafs2 (- x 1))
 )
  (pulled-regular-polygon 0 3 1/3 30 "solid" "green")
)

  )

(define (generate-leafs22 x)
    (above
     
   ))

(define baum2
  
   (generate-leafs2 5)
  (generate-leafs22 5)
   )

(define baum2-mit-Stamm
  (overlay/offset
 baum2
  0 120
   (rectangle 30 80 "solid" "brown")))



(define baum2-mit-Stern
  (above
   ;; der rekursiver Stern an der Spitze   
   (baum1-stern 9 "pink" "blue")
baum2-mit-Stamm
   ))

#|

(define line
  (scene+curve baum2-mit-Stern
               130 110 0 1
               120 250 0 1
               "red")
   )
  
|#
               
;Fügt baum2 zur letzt erstellten Szene hinzu

(define scene-baum2 '(place-image (eval baum2-mit-Stern) 700 220 (eval scene-baum1)))





