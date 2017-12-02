#lang racket
#|Blatt 1 Gruppe: Thomas Hofmann, Patricia Häußer, Ariana Sliwa|#

;;;Aufgabe 1.1 Bogenmaß und Grad

;Funktion, die Grad zu Bogenmaß umrechnet
(define (GradZuBogenmaß g)
  (* (/ (* 2 pi) 360) g))

;Funktion, die Bogenmaß zu Grad umrechnet
(define (BogenmaßZuGrad b)
  (* (/ 360 (* 2 pi)) b))
  

;;;Aufgabe 1.2 Umkehrfunktion acos
;arcsin = PI() / 2 - arccos(x)
(define (my-acos a)
  


;;;Aufgabe 1.3 Kilometer und Seemeilen

;Funktion, die Seemeilen in Kilometer umrechnet
(define (NmInKm nm)
  ((* nm 1.852)))

;;;Aufgabe 2.1 Großkreisentfernung
(define (distanzAB)
(+ (* (sin -59.93) (sin -22.20)) (* (cos -59.93) (cos -22.20) 103.35)))

;;;Aufgabe 2.2 Anfangskurs

