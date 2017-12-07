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
Nicht um eine Geschachtelte Rekursion, da andere Funktionen als übergeben hat
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
       (rhombus 20 45 "solid" outcolor)
       (rhombus 35 45 "solid" incolor)
       (rhombus 42 (+ -140 (/ 280 x)) "solid" outcolor)
       (rhombus 38 (+ 140 (/ 280 x)) "solid" incolor)
        
       (make-fire (- x 1) outcolor incolor)
       ; (make-fire (- x ) incolor outcolor)
       )
  
      (rhombus 40 (+ -140 (/ 340 x)) "solid" outcolor)
       
      ))


(define chimney (overlay/align
                 "center" "bottom"
                 (make-fire 3 "red" "yellow")
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



;erstellt ersten Baum (ganz links)

(define (baum1-blätter x) 
  (if (> x 1)
      (above
       (rhombus (- 110 (* x 10 )) 150 "solid" "seagreen")
       (baum1-blätter (- x 1)) )
      
      (isosceles-triangle 100 120 "solid" "seagreen")
      )
  )

    
(define baum1-körper
  (overlay/align
   "center" "middle"
   (baum1-blätter 6)
   (isosceles-triangle 200 30 "solid" "seagreen")
   ))

(define (baum1-stern x color seccolor)
  (if (> x 1)
      (overlay                
       (star-polygon (- 40 (* x 6) ) 5 2 "solid" color)
                 
       (baum1-stern (- x 1) seccolor color)
       (rotate (* x 20)(baum1-stern (- x 5) color seccolor))
       )
      (star-polygon (- 40 (* x 0) ) 5 2 "solid" color)
      ))

(define baum1
  (above/align "center"
               ;; der Stern an der Spitze
               (baum1-stern 5 "yellow" "red")
               ;; die Zweige
               baum1-körper
               ;der Stamm
               (rectangle 30 60 "solid" "brown")
               )) 


;Fügt den ersten Baum zur letzt erstellten Szene hinzu, welche done-background ist.
  
(define scene-baum1 '(place-image (eval baum1) 100 200 (eval done-background)))










