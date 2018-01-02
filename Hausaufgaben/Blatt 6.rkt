#lang racket
(require 2htdp/image)
(require 2htdp/universe)



;Aufgabe 2

#|
Für unser Bild haben wir eine Szene erstellt und diese immer weiter erweitert mit der Funktion
"place-image".
Aufgerufen werden kann unsere Szene mit :
(eval final-scene)
Für die Animation haben wir den ersten Baum genommen und den Stern und die Kugel farben geändert.
Um die Animation aufzurufen:
(animate create-xmas-scene)
|#


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

;erstellt Flammenspitze
(define (make-fire x outcolor incolor)
  (if (> x 1) 
      (overlay/align
       "center" "bottom"
       (rhombus (/ 80 x) 45 "solid" outcolor)
       (make-fire (- x 1) incolor outcolor)
       )
  
      (make-inner-fire 4 incolor outcolor)
       
      ))

;erstellt Flamen boden, bei else wird ein leeres Dreieck übergeben, dies dient nur dafür dass beim abschluss der rekursion noch etwas anderes
;in die Szene hinzugefügt werden kann bei bedarf (kommt noch öfter vor)

(define (make-inner-fire x color seccolor)
  (if (> x 1)
      (overlay
       (isosceles-triangle  (/ 140 x)  90 "solid" color)
       (make-inner-fire (- x 1) seccolor color))
      (isosceles-triangle  0  0 "solid" color)
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

(define fire-window1-scene '(place-image (eval window) 600 150 (eval fire-sock-kranz-scene)))
(define done-background '(place-image (eval window) 200 150 (eval fire-window1-scene)))




;erstellt ersten Baum (links)


;Baumschmuck

;erstellt Kugeln und setzt sie mit einem offset voneinander entfernt hin
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

;einzelne Kugeln besitzen eine Rekursion für die Muster innerhalb
(define (kugelrekursion x color seccolor)
  (if (> x 1 )
      (overlay/align "center" "middle"
                     (circle (- 10 (* x 2)) "solid" color)
                     (kugelrekursion (- x 0.5) seccolor color)
                     )
      (circle 8 "solid" "yellow")
      )
  )
  


                  
                 

;Baumstern mit rekursionsmuster
(define (baum-stern x color seccolor)
  (if (> x 1)
      (overlay                
       (star-polygon (- 50 (* x 4) ) 5 2 "solid" color)
                 
       (baum-stern (- x 1) seccolor color)
   
       )
      (star-polygon 0 5 2 "solid" color)
      ))


; erstellt Blätter mit Kugelschmuck
(define (blätter-mit-schmuck x color seccolor) (overlay/align "center" "middle"
                                           
                                               (baumschmuck x color seccolor)
                                               (isosceles-triangle  ( * 20 x)  90 "solid" (make-color 18 140 0))

                                               ))


;eckige Baumblätter


;äußeren Blätter mit schmuck
(define (baum1-blätter-mit-schmuck x color seccolor) 
  (if (> x 1)
      (overlay/offset 
       (blätter-mit-schmuck x color seccolor)
       0 (/ (* (- 100) x) 4)
       (baum1-blätter-mit-schmuck (- x 1) color seccolor)
       )
      (isosceles-triangle 0 30 "solid" "seagreen")
      ))


;bisschen dunklere Blätter
(define (outer-leafs x)
  (if (> x 1)
      (overlay/offset 
       (isosceles-triangle ( * 35 x)  90 "solid" (make-color 90 160 0))
       0  (/ (* (- 100) x) 4)
       (outer-leafs (- x 1))
       )
      (isosceles-triangle 0 30 "solid" "seagreen")
      ))

;noch dunkelere Blätter
(define (outer-leafs2 x)
  (if (> x 1)
      (overlay/offset 
       (isosceles-triangle ( * 40 x)  80 "solid" (make-color 0 100 0))
       0 -100
       (outer-leafs2 (- x 1))
       )
      (isosceles-triangle 0 30 "solid" "seagreen")
      ))


;Fügt Baumblätter zusammen
(define (baum1-körper x color seccolor)
  (overlay/align
   "center" "middle"
   (baum1-blätter-mit-schmuck (+ x 2) color seccolor)
   (outer-leafs (+ x  1))
   (outer-leafs2 (+ x 2 ))
   ))


; Steckt den Baum zusammen (Körper und Stamm)
(define (baum1-ohne-stern color seccolor)
  (above/align "center"

               ;; die Blätter
               (baum1-körper 4 color seccolor)
               ;der Stamm
               (rectangle 30 60 "solid" "brown")
               ))


;Fügt zum Körper& Stamm den Stern hinzu
(define baum1-mit-stern
  (overlay/offset
   ;; der rekursiver Stern an der Spitze   
   (baum-stern 9 "yellow" "red")
   0 175
   (baum1-ohne-stern "purple" "red")
   ))

;fertigerBaum mit 
(define baum1-für-animation
  (overlay/offset
   ;; der rekursiver Stern an der Spitze   
   (baum-stern 9 "blue" "pink")
   0 175
   ( baum1-ohne-stern "green" "orange")
   ))


;Fügt den ersten Baum zur letzt erstellten Szene hinzu, welche done-background ist.
  
(define scene-baum1 '(place-image (eval baum1-mit-stern) 100 200 (eval done-background)))


;Erstellt den zweiten Tannenbaum



;erstellt Grundgerüst des zweiten Baumes (rechts)
(define (generate-grundgerüst-baum2 x)
  (if (> x 1)
  (overlay
    (generate-grundgerüst-baum2 (- x 1))
   (pulled-regular-polygon (* 69 x) 3 1/3 30 "solid" (make-color 10 (- 250 (* x 30)) 10))
 )
  (pulled-regular-polygon 0 3 1/3 30 "solid" "green")
)

  )



;erstellt den roten sternenschmuck des Baumes
(define (generate-stars x)
  (if (> x 1)
      (overlay/offset (above
                                    (pulled-regular-polygon (* 7 x) 3 1/3 101 "solid"
                                                            (make-color(* x 30) (* x 12) (* x 12) ))
                                    (generate-stars (- x 1))
                                    )
                      
                      35 (* 3.5 x)
                      (generate-stars (- x 1)))
      (pulled-regular-polygon 0 3 1/3 30 "solid" "green")
     
      ))


;setzt grundgerüsst und Sterne zusammen
(define baum2
  (overlay
     (generate-stars 8)
   (generate-grundgerüst-baum2 5)

   ))



;setzt Baumkörper und Stamm zusammen
(define baum2-mit-Stamm
  (overlay/offset
 baum2
  0 120
   (rectangle 30 80 "solid" "brown")))


;setzt Stern und Baum zusammen
(define baum2-mit-Stern
  (overlay/offset
   ;; der rekursiver Stern an der Spitze   
   (baum-stern 9 "pink" "blue")
   0 160
   baum2-mit-Stamm
   ))

;setzt eine Dekorationslinie am Baum
(define baum2-mit-linie
  (scene+curve baum2-mit-Stern
               165 100 0 1
               120 300 0 1
               "purple")
   )

               
;Fügt baum2 zur letzt erstellten Szene hinzu

(define final-scene '(place-image (eval baum2-mit-linie) 700 220 (eval scene-baum1)))



;animation

(define (create-xmas-scene t)
(underlay/xy (rectangle 400 400 "solid" (make-color 20 10 120))  0 0
(if (< 25 (modulo t 50)) baum1-mit-stern baum1-für-animation)))

