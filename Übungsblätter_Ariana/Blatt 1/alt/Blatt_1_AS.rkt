#lang racket
#|Blatt 1 Gruppe: Thomas Hofmann, Patricia Haeusser, Ariana Sliwa|#

;Aufgabe 1.1 Bogenmaß und Grad

;Funktion, die Grad zu Bogenmaß umrechnet
(define (degrees->radians d)
  (* (/ (* 2 pi) 360) d))

;Funktion, die Bogenmaß zu Grad umrechnet
(define (radians->degrees r)
  (* (/ 360 (* 2 pi)) r))


;Aufgabe 1.2 Umkehrfunktion acos
(define (my-acos a)
  (cond [(< 0 a 1) (atan (sqrt (- (/ 1 (sqr a)) 1)))]
        [(< -1 a 0) (- pi (atan (sqrt (- (/ 1 (sqr a)) 1))))]
        [(= a 0) 0]
        [else (error "Eingabe liegt außerhalb des Defintionsbereichs")]))


;Aufgabe 1.3 Kilometer und Seemeilen
;Funktion, die Seemeilen in Kilometer umrechnet
(define (nm->km nm)
  (* nm 1.852))

;Aufgabe 2.1 Großkreisentfernung

;Die Funktion dG berechnet die Großkreisentfernung zweier Orte (A,B)
;phiA und phiB bezeichnen die geographische Breite
;LA und LA die geographische Länge
(define (dG phiA LA phiB LB)
  (my-acos (+  (* (sin phiA) (sin phiB)) 
               (* (cos phiA) (cos phiB) (cos (- LA LB)) ))))

;Die Funktion distanzAB berechnet die Distanz zweier Orte in km. Eingabe der Werte in Bogenmaß.
;Die dG Funktion liefert die Großkreisentfernung der Orte A und B in Bogenmaß.
;Die Funktion radians->degrees rechnet den Wert in Grad um, der mit 60 multipliziert wird.
;Der Wert wird von nautischen Meilen in Kilometer mit der Funktion nm->km um gerechnet und in km ausgegeben.
(define (distanzAB phiA LA phiB LB)
  (nm->km (* 60 (radians->degrees(dG phiA LA phiB LB)))))

;Umrechnung der gegebenen Werte von Grad in Bogenmaß
;Oslo
(define phiOslo (degrees->radians 59.93)) ;Breite
(define LOslo (degrees->radians 10.75))   ;Länge

;Hongkong
(define phiHK (degrees->radians 22.20))   ;Breite
(define LHK (degrees->radians 114.10))    ;Länge

;San Francisco
(define phiSF (degrees->radians 37.75))   ;Breite
(define LSF (degrees->radians -122.45))   ;Länge

;Honolulu
(define phiHon (degrees->radians 21.32))  ;Breite
(define LHon (degrees->radians -157.83))  ;Länge

;Osterinsel
(define phiOI (degrees->radians -27.10))  ;Breite
(define LOI (degrees->radians -109.40))   ;Länge

;Lima
(define phiLima (degrees->radians -12.10));Breite
(define LLima (degrees->radians -77.05))  ;Länge

;Ergebnisse:

;(distanzAB phiOslo LOslo phiHK LHK)
;8589.412217586058

;(distanzAB phiSF LSF phiHon LHon)
;3844.688050487052

;(distanzAB phiOI LOI phiLima LLima)
;3757.6222188100514


;Aufgabe 2.3 Himmelsrichtungen
;Die Funktion Grad->Himmelsrichtung gibt für eingegebene Gradwerte die Himmelsrichtung aus
(define x 11.25)
(define (Grad->Himmelsrichtung g)
  (cond [(> g (* 32 x)) "Eingabe liegt außerhalb des Defintionsbereichs. Bitte geben Sie eine Zahl zwischen 0 und 360 ein."]
        [(< g 0) "Eingabe liegt außerhalb des Defintionsbereichs. Bitte geben Sie eine Zahl zwischen 0 und 360 ein."]
        [(= g 0) "N"]
        [(< g x) "N"]
        [(>= g (* 31 x)) "N"]
        [(<= g (* 32 x)) "N"]
        [(>= g x) "NNE"]
        [(< g (* 3 x)) "NNE"]
        [(>= g (* 3 x)) "NE"]
        [(< g (* 5 x)) "NE"]
        [(>= g (* 5 x)) "ENE"]
        [(< g (* 7 x)) "ENE"]
        [(>= g (* 7 x)) "E"]
        [(< g (* 9 x)) "E"]
        [(>= g (* 9 x)) "ESE"]
        [(< g (* 11 x)) "ESE"]
        [(>= g (* 11 x)) "SE"]
        [(< g (* 13 x)) "SE"]
        [(>= g (* 13 x)) "SSE"]
        [(< g (* 15 x)) "SSE"]
        [(>= g (* 15 x)) "S"]
        [(< g (* 17 x)) "S"]
        [(>= g (* 17 x)) "SSW"]
        [(< g (* 19 x)) "SSW"]
        [(>= g (* 19 x)) "SW"]
        [(< g (* 21 x)) "SW"]
        [(>= g (* 21 x)) "WSW"]
        [(< g (* 23 x)) "WSW"]
        [(>= g (* 23 x)) "W"]
        [(< g (* 25 x)) "W"]
        [(>= g (* 25 x)) "WNW"]
        [(< g (* 27 x)) "WNW"]
        [(>= g (* 27 x)) "NW"]
        [(< g (* 29 x)) "NW"]
        [(>= g (* 29 x)) "NNW"]
        [(< g (* 31 x)) "NNW"]))
        
;;Die Bedingungen müssen noch logisch verknüpft werden. Hab aber noch nicht rausgefunden wie...





        