#lang racket
(require 2htdp/image)
(require 2htdp/universe)

#|
Blatt 6, Gruppe 8, Mittwoch 10-12 Uhr, Raum G-210, Übungsleiter Rainer Jürgensen
Thomas Hofmann (6764839⁠⁠⁠)
Patricia Häußer (⁠⁠⁠6771401)
Ariana Sliwa (6816391)
|#



;;; 1 – Formen der Rekursion

;;  kopfstueck:
;   Lineare Rekursion, da in der Fallunterscheidung nur jeweils einmal kopfstueck verwendet wird.
;   Keine Baumrekursion, da in der Fallunterscheidung nicht mehrfach auf die Definition Bezug genommen wird.
;   Keine geschachtelte Rekursion, da die Funktion nicht selbst als Argument übergeben wird.
;   Eine direkte Rekursion und somit keine indirekte, da sich keine weiteren Definitionen wechselseitig rekursiv verwenden.

;;  endstueck:
;   Lineare Rekursion, da in der Fallunterscheidung nur jeweils einmal endstueck verwendet wird.
;   Keine Baumrekursion, da in der Fallunterscheidung nicht mehrfach auf die Definition Bezug genommen wird.
;   Keine geschachtelte Rekursion, da die Funktion nicht selbst als Argument übergeben wird.
;   Eine direkte Rekursion und somit keine indirekte, da sich keine weiteren Definitionen wechselseitig rekursiv verwenden.

;;  merge:
;   Nicht Lineare Rekursion, weil die Rekursion nicht in jeder Fallunterscheidung aufgerufen wird.
;   Keine Baumrekursion, da in der Fallunterscheidung nicht mehrfach auf die Definition Bezug genommen wird.
;   Keine geschachtelte Rekursion, da die Funktion nicht selbst als Argument übergeben wird.
;   Eine direkte Rekursion und somit keine indirekte, da sich keine weiteren Definitionen wechselseitig rekursiv verwenden.

;;  merge-sort:
;   Nicht Lineare Rekursion, weil die Rekursion nicht in jeder Fallunterscheidung aufgerufen wird.
;   Baumrekursion, da in der Fallunterscheidung mehrfach (zweimal) auf die Definition Bezug genommen wird.
;   Keine geschachtelte Rekursion, da die Funktion nicht selbst als Argument übergeben wird.
;   Eine direkte Rekursion und somit keine indirekte, da sich keine weiteren Definitionen wechselseitig rekursiv verwenden.



;;; 2 – Nikolausaufgabe

;;  Grundformen, Größenangaben in Pixeln
;   Dreiecke (für Bäume)
(define (dreieck größe)
  (triangle größe "outline" "PaleGreen"))

(define (dreieck2 größe)
  (triangle größe "outline" "DarkSeaGreen"))

(define (dreieck3 größe)
  (triangle größe "solid" "PaleGreen"))

(define (dreieck4 größe)
  (triangle größe "solid" "DarkSeaGreen"))

;   Rechteck (für Geschenke)
(define (rechteckIndividuell breite höhe farbe)
  (rectangle breite höhe "solid" farbe))

;   Band (für Geschenke)
(define (band g)
  (overlay (line g 0 "gold")               
           (line 0 g "gold")))
;   Schleife (für Geschenke)
(define (Schleife)
  (overlay/offset
   (beside (ellipse 40 20 "outline" "gold")
           (ellipse 40 20 "outline" "gold"))
   0 14
   (beside (line 30 -20 "gold")
           (line 30 20 "gold"))))


;;  Zeichnet ein Geschenk mit individueller Farbauswahl, bei dem eine Schleife oben drauf sitzt.
;   @param Farbe erwartet einen String
;   @param g erwartet Größe in Pixel
(define (GeschenkIndividuell g farbe)
  (overlay/offset
   (Schleife)
   0 (/ g 2)
   (overlay/align "center" "middle"
                  (line 0 g "gold")
                  (rechteckIndividuell g g farbe))))


;   Zeichnet rekursiv eine Reihe von ausgefüllten Dreiecken des Tannenbaums
;   @param n Anzahl der großen Dreiecke in einer Reihe
;   @param g Größe der kleinen Dreiecke innerhalb des großen Dreiecks in Pixel
(define (TannenReiheSolid n g)
  (cond
    [(zero? n) (square 1 "solid" "white")]
    [else
     (local [(define c (TannenReiheSolid (- n 1) g)) ; rekursiver Aufrif
             (define i (above/align "center" 
                                    (dreieck4 g) 
                                    (beside (dreieck3 g) 
                                            (dreieck3 g)) 
                                    (beside (dreieck3 g)
                                            (dreieck4 g)
                                            (dreieck3 g))))]
       (beside i c))]))

;   Zeichnet einen Tannenbraum mit 5 Reihen
;   @param g Größe der kleinen Dreiecke innerhalb der großen Dreiecke in Pixel
(define (maleTannenbaumSolid g)
  (above/align "center"
               (TannenReiheSolid 1 g)
               (TannenReiheSolid 2 g)
               (TannenReiheSolid 3 g)
               (TannenReiheSolid 4 g)
               (TannenReiheSolid 5 g)
               (rectangle g g "solid" "SaddleBrown"))) 


;;  Zeichnet drei Geschenke vor zwischen zwei Tannebräumen
(define (zeichneGeschenkeUnterBäumen)
   (overlay/offset (beside
                   (GeschenkIndividuell 50 "Maroon")
                   (GeschenkIndividuell 75 "Crimson")
                   (GeschenkIndividuell 50 "DarkRed"))
                  0 -100
  (overlay/offset (maleTannenbaumSolid 15)
                  300 0
                  (maleTannenbaumSolid 15))))


;;  Zeichnet einen Engel aus drei Dreiecken, einem Kreis und einer Ellipse
(define (zeichneEngel)
  (overlay/offset
   (overlay/offset 
                   (ellipse 30 10 "outline" "gold")               
                  0 44
  (overlay/offset (circle 15 "solid" "NavajoWhite")
                  0 40
                  (isosceles-triangle 70 50 "solid" "SeaShell")))
  0 15
  (beside
     (rotate 270 (isosceles-triangle 50 50 "solid" "WhiteSmoke"))
     (rotate 90 (isosceles-triangle 50 50 "solid" "WhiteSmoke")))))


;;  Zeichnet einen Stern bestehend aus drei Sternen, wobei der Stern in der hintersten Ebene eine variable Deckkraft hat
;   @param t wird von (animate create-christmas-scene) über create-cristmas-scene über create-stern übergeben
(define (stern t)
  (underlay
               (star 34 "solid" (color 255 250 0 (* 2 t)))
               (radial-star 8 10 20 "solid" "Gold")
               (star 20 "solid" "LemonChiffon")))


;;  Animationsfunktion für den Stern, lässt den hintersten der drei Sterne in Abhängigkeit des Ticks auf- und ableuchten
;   @param t wird von (animate create-christmas-scene) über create-cristmas-scene übergeben
(define (create-stern t)
  (if (> (modulo (* 5 t) 255) 127)
      (stern (- 255 (modulo (* 5 t ) 255)))
      (stern (modulo (* 5 t) 255))))

  
;;  Zeichnet die gesamte Szene inklusive Animation der beiden Sterne, sowie des Engels
;   @param t wird von (animate create-christmas-scene) übergeben, zählt 28 mal pro Sekunde um 1 hoch
( define (create-christmas-scene t)
   (underlay/xy (underlay/xy (underlay/xy (zeichneGeschenkeUnterBäumen) 210 (+ (* 10 (sin (/ t 4))) 10) (zeichneEngel)) 85 -50 (create-stern t))
                385 0 (create-stern (+ 127 t))))

;; Erzeugt einen canvas und startet eine Simulationsuhr, die 28 mal pro Sekunde tickt. Bei jedem Tick wird
;  • der Zeitpunkt um eins erhöht,
;  • die call-back Funktion „create-image“ aufgerufen und das nächste Bild berechnet und angezeigt.
;  Die Simulation läuft, bis das Programm mit der Stop-Taste abgebrochen oder das Fenster geschlossen wird. 
(animate create-christmas-scene)