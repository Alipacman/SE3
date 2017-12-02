#lang racket
(require se3-bib/prolog/prologInScheme)

; Bezugstransparenz – innere und äußere Reduktion führt zum selben Ergebnis – geht verloren wenn imperativ programmiert wird oder manchmal auch mit if

; Arten von Rekursion:
;  lineare Rekusion 
;  Baumrekursion – pro Rekursionsschritt wird Funktion zwei Mal gekursiv aufgerufen
;  Geschachtelte Rekursion – in Rekursionsaufruf kommt ein weiterer rekrusiver Aufruf vor
;  Endrekursiv
;  Direkt
;  Indirekt

; Ackermann-Funktion?  http://www.tutego.de/java/articles/Ackermann-Funktion.html 

; Datenbasis
(<- (Ergebnis "1a" 10))
(<- (Ergebnis "1b" 5))
(<- (Ergebnis "1c" 5))
(<- (Ergebnis "2" 8))

(<- (Frage "1a" "(+ 5 5) ergibt?" "(c) Hans"))
(<- (Frage "1b" "(- 10 5) ergibt?" "(c) Tester"))
(<- (Frage "1c" "(+ 5 1) ergibt?" "(c) Hans"))


; Unifikation
;(?- (= (Regal (Buch SciFi ?Titel) (Buch Tragödie Faust))
;      (Regal (Buch SciFi Dunkle_Templer) (Buch ?Kategorie Faust))))

; Anfragen zur Datenbasis
;(?- (Ergebnis ?Aufgabe 5))

;(?- (Ergebnis ?Aufgabe 5)
;    (Frage ?Aufgabe ?Frage ?Autor)

;(?- (Ergebnis ?Aufgabe 5)
;    (Frage ?Aufgabe ?Frage ?))



; ––––––––––––––––––
#|
> (?- (= (Regal (Buch SciFi ?Titel) (Buch Tragödie Faust))
   (Regal (Buch SciFi Dunkle_Templer) (Buch ?Kategorie Faust))))
?Titel = Dunkle_Templer
?Kategorie = Tragödie
;
 No.
> (?- (Ergebnis ?Aufgabe 5))
?Aufgabe = 1b
;
?Aufgabe = 1c


> (?- (= (Regal (Buch SciFi ?Titel) (Buch Tragödie Faust))
   (Regal (Buch SciFi Dunkle_Templer) (Buch ?Kategorie Faust))))
?Titel = Dunkle_Templer
?Kategorie = Tragödie
;
 No.
> (?- (Ergebnis ?Aufgabe 5))
?Aufgabe = 1b
;
?Aufgabe = 1c
.
 No.
> (?- (Ergebnis ßAufgabe 5)
    (Frage ?Aufgabe ?Frage ?))
 No.
> (?- (Ergebnis ?Aufgabe 5)
    (Frage ?Aufgabe ?Frage ?))
?Aufgabe = 1b
?Frage = (- 10 5) ergibt?
.
 No.
> (?- (Ergebnis ?Aufgabe 5)
    (Frage ?Aufgabe ? ?))
?Aufgabe = 1b
;
?Aufgabe = 1c
;
 No.

|#

(map sqrt '(1 9 4 25))

(car '(Alle meine Entchen))
