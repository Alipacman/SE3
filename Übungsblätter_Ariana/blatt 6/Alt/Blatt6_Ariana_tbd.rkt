#lang racket
(require 2htdp/image)
(require 2htdp/universe)


#|
Blatt 6, Gruppe 8, Mittwoch 10-12 Uhr, Raum G-210, Übungsleiter Rainer Jürgensen
Thomas Hofmann (6764839⁠⁠⁠)
Patricia Häußer (⁠⁠⁠6771401)
Ariana Sliwa (6816391)
|#

;;; 1 Formen der Rekursion

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
;   Keine lineare Rekursion, da merge in der Fallunterscheidung zweimal aufgerufen wird.
;   Baumrekursion, da in der Fallunterscheidung mehrfach (zweimal) auf die Definition Bezug genommen wird.
;   Keine geschachtelte Rekursion, da die Funktion nicht selbst als Argument übergeben wird.
;   Eine direkte Rekursion und somit keine indirekte, da sich keine weiteren Definitionen wechselseitig rekursiv verwenden.

;;  merge-sort:
;   Keine lineare Rekursion, da merge-sort in der Fallunterscheidung zweimal aufgerufen wird.
;   Baumrekursion, da in der Fallunterscheidung mehrfach (zweimal) auf die Definition Bezug genommen wird.
;   Keine geschachtelte Rekursion, da die Funktion nicht selbst als Argument übergeben wird.
;   Eine indirekte Rekursion, da merge-sort auf merge Bezug nimmt.

#|(define (create-UFO-scene height)
  (underlay/xy (rectangle 100 100 "solid" "white") 50 height UFO))
 
(define UFO
  (underlay/align "center"
                  "center"
                  (circle 10 "solid" "green")
                  (rectangle 40 4 "solid" "green")))
 
(animate create-UFO-scene)|#

; Grundformen
(define (dreieck größe)
  (triangle größe "outline" "PaleGreen"))

(define (dreieck2 größe)
  (triangle größe "outline" "DarkSeaGreen"))

(define (dreieck3 größe)
  (triangle größe "solid" "PaleGreen"))

(define (dreieck4 größe)
  (triangle größe "solid" "DarkSeaGreen"))

(define (rechteckrot breite höhe)
  (rectangle breite höhe "solid" "Crimson"))

(define (rechteckIndividuell breite höhe farbe)
  (rectangle breite höhe "solid" farbe))


(define (band g)
  (overlay (line g 0 "gold")               
           (line 0 g "gold")))

(define (Schleife)
  (overlay/offset
   (beside (ellipse 40 20 "outline" "gold")
           (ellipse 40 20 "outline" "gold"))
   0 14
   (beside (line 30 -20 "gold")
           (line 30 20 "gold"))))

; Zeichnet ein Geschenk mit individueller Farbauswahl, bei dem die Schleife mittig sitzt
; @param Farbe erwartet einen String
; @param g erwartet Größe in Pixel
(define (GeschenkIndividuell g farbe)
  (overlay
   (overlay/align "center" "middle" 
                  (Schleife) ; oberste Ebene
                  (band g)) ; zweite Ebene: Bänder (v.r.n.l und v.o.n.u.)
   (rechteckIndividuell g g farbe))) ; unterste Ebene: Quadrat mit Parameter-Farbe

; Zeichnet ein Geschenk mit individueller Farbauswahl, bei dem die Schleife oben drauf sitzt.
; @param Farbe erwartet einen String
; @param g erwartet Größe in Pixel
(define (GeschenkIndividuell2 g farbe)
  (overlay/offset
   (Schleife)
   0 (/ g 2)
   (overlay/align "center" "middle"
                  (line 0 g "gold")
                  (rechteckIndividuell g g farbe))))


; Kugel
;(circle 15 "solid" "Crimson")

;
(define (TannenReiheOutline n g)
  (cond
    [(zero? n) (square 1 "solid" "white")]
    [else
     (local [(define c (TannenReiheOutline (- n 1) g))
             (define i (above/align "center"
                                    (dreieck2 15)
                                    (beside (dreieck g)
                                            (dreieck g))
                                    (beside (dreieck g)
                                            (dreieck2 g)
                                            (dreieck g))))]
       (beside i c))]))

; TannenReiheSolid zeichnet eine Reihe von ausgefüllten Dreiecken des Tannenbaums
; Parameter: n = Anzahl der großen Dreiecke in einer Reihe
;            g = Größe der kleinen Dreiecke innerhalb des großen Dreiecks in Pixeln (15 eignet sich hier gut)
(define (TannenReiheSolid n g)
  (cond
    [(zero? n) (square 1 "solid" "white")]
    [else
     (local [(define c (TannenReiheSolid (- n 1) g)) ; rekursiver Aufruf
             (define i (above/align "center" ; Übereinadersetzen der kleinen Dreicke mit above/align
                                    (dreieck4 g) ;oberstes Dreieck
                                    (beside (dreieck3 g) ; nebeneinandersetzen der zweiten Reihe
                                            (dreieck3 g)) 
                                    (beside (dreieck3 g)
                                            (dreieck4 g)
                                            (dreieck3 g))))]
       (beside i c))])) ; beside setzte die Dreiecke nebeneinander

; Parameter g: Größe der kleinen Dreiecke innerhalb der großen Dreiecke
(define (maleTannenbaumSolid g)
  (above/align "center"
               (TannenReiheSolid 1 g)
               (TannenReiheSolid 2 g)
               (TannenReiheSolid 3 g)
               (TannenReiheSolid 4 g)
               (TannenReiheSolid 5 g)
               (rectangle g g "solid" "SaddleBrown"))) ; Stamm – hat dieselbe Größe wie die Dreiecke

(define (maleTannenbaumOutline g)
  (above/align "center"
               (TannenReiheOutline 1 g)
               (TannenReiheOutline 2 g)
               (TannenReiheOutline 3 g)
               (TannenReiheOutline 4 g)
               (TannenReiheOutline 5 g)
               (rectangle g g "solid" "SaddleBrown")))

; Hauptfunktion; zeichnet die gesamte Szene mit Hilfe der Hilfsfunktionen
(define (zeichneSzene)
  

   (overlay/offset (beside
                   (GeschenkIndividuell2 50 "Maroon")
                   (GeschenkIndividuell2 75 "Crimson")
                   (GeschenkIndividuell2 50 "DarkRed"))
                  0 -100
  (overlay/offset (maleTannenbaumSolid 15)
                  300 0
                  (maleTannenbaumSolid 15)))
   )
  ;150 0
  ;(GeschenkIndividuell2 100 "Crimson"))


#|(define (GeschenkIndividuell2 g farbe)
  (overlay/offset
   (Schleife)
   0 (/ g 2)
   (overlay/align "center" "middle"
                  (line 0 g "gold")
                  (rechteckIndividuell g g farbe))))|#



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
     (rotate 90 (isosceles-triangle 50 50 "solid" "WhiteSmoke")))

  ))




(zeichneSzene)



#|(define UFO
( underlay/align "center"
                 "center"
                 ( circle 10 "solid" "green")
                 ( rectangle 40 4 "solid" "green")))|#

( define (create-christmas-scene t)
   (underlay/xy (zeichneSzene) 210 (+ (* 10 (sin (/ t 4))) 10) (zeichneEngel)))
( animate create-christmas-scene)