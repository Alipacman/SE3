#lang racket
#|
Blatt 4, Aufgabe 3, Gruppe 8, Mittwoch 10-12 Uhr, Raum G-210, Übungsleiter Rainer Jürgensen
Thomas Hofmann (6764839⁠⁠⁠)
Patricia Häußer (⁠⁠⁠6771401)
Ariana Sliwa (6816391)


3 – Funktionen vs. Spezialformen

3 – 1
Generell: Bei der inneren Reduktion werden Ausdrücke von innen nach außen reduziert, während sie bei der äußeren Reduktion von außen nach innen reduziert werden.


Beispiel 1: Auswertung des gegebenen Ausdrucks nach innerer Reduktionsstrategie:

   (hoch4 (* 3 (+ 1 (hoch4 2))))
-> (hoch4 (* 3 (+ 1 (* 2 2 2 2))))
-> (hoch4 (* 3 (+ 1 16)))
-> (hoch4 (* 3 17))
-> (hoch4 51)
-> (* 51 51 51 51)
-> 6765201


Beispiel 2: Auswertung des gegebenen Ausdrucks nach äußerer Reduktionsstrategie:

   (hoch4 (* 3 (+ 1 (hoch4 2))))
-> (* (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2))))
-> (* (* 3 (+ 1 (* 2 2 2 2)))    (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2))))
-> (* (* 3 (+ 1 16))             (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2))))
-> (* (* 3 17)                   (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2))))
-> (* 51                         (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2))))
-> (* 51                         (* 3 (+ 1 (* 2 2 2 2)))    (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2))))
-> (* 51                         (* 3 (+ 1 16))             (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2))))
-> (* 51                         (* 3 17)                   (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2))))
-> (* 51                         51                         (* 3 (+ 1 (hoch4 2)))      (* 3 (+ 1 (hoch4 2))))
-> (* 51                         51                         (* 3 (+ 1 (* 2 2 2 2)))    (* 3 (+ 1 (hoch4 2))))
-> (* 51                         51                         (* 3 (+ 1 16))             (* 3 (+ 1 (hoch4 2))))
-> (* 51                         51                         (* 3 17)                   (* 3 (+ 1 (hoch4 2))))
-> (* 51                         51                         51                         (* 3 (+ 1 (hoch4 2))))
-> (* 51                         51                         51                         (* 3 (+ 1 (* 2 2 2 2))))
-> (* 51                         51                         51                         (* 3 (+ 1 16)))
-> (* 51                         51                         51                         (* 3 17))
-> (* 51                         51                         51                         51)
-> 6765201

3 – 2
In Racket wird für Funktionen die innere Reduktionsstrategie angewendet und für Spezialformen die äußere Reduktionsstrategie.

3 – 3
TODO @Thomas ;)
Das Problem liegt hier darin, dass durch innere Reduktion erst die rekursive Funktion faculty aufgerufen wird und
deswegen die (Abbruch-) Bedingung nicht geprüft wird und wir in einer Endlosschleife landen. Das ist der Grund
warum if eine Spezialform ist und äußere Reduktion voraussetzt.


|#


