#lang racket
(require se3-bib/flaggen-module)

#|
Blatt 3, Gruppe 8, Mittwoch 10-12 Uhr, Raum G-210, Übungsleiter Rainer Jürgensen
Thomas Hofmann (6764839⁠⁠⁠)
Patricia Häußer (⁠⁠⁠6771401)
Ariana Sliwa (6816391)
|#

;;; 1 Die internationale Buchstabiertafel
;;  1.1 Datenstruktur für die internationale Buchtabiertafel

;   Wir erstellen eine Liste, die zu jedem Buchstaben einen Schlüssel liefert. Durch diesen Schlüssel können wir auf den Wert zugreifen

(define buchstabiertafel 
  '(
    (#\A Alfa)
    (#\B Bravo)
    (#\C Charlie)
    (#\D Delta)
    (#\E Echo)
    (#\F Foxtrott)
    (#\G Golf)
    (#\H Hotel)
    (#\I India)
    (#\J Juliett)
    (#\K Kilo)
    (#\L Lima)
    (#\M Mike)    
    (#\N November)   
    (#\O Oscar)
    (#\P Papa)
    (#\Q Quebec)
    (#\R Romeo)
    (#\S Sierra)   
    (#\T Tango)    
    (#\U Uniform)    
    (#\V Viktor)    
    (#\W Whiskey)    
    (#\X X-ray)    
    (#\Y Yankee)    
    (#\Z Zulu)    
    (#\0 Nadazero)    
    (#\1 Unaone)   
    (#\2 Bissotwo)    
    (#\3 Terrathree)   
    (#\4 Kartefour)    
    (#\5 Pantafive)
    (#\6 Soxisix)
    (#\7 Setteseven)   
    (#\8 Oktoeight)   
    (#\9 Novenine)   
    (#\, Decimal)   
    (#\. Stop)
    ))

;; 1.2 Codierungsfunktion
(define (natoalphabet schluessel)
  (cadr (assoc schluessel buchstabiertafel)))

;; 1.4 Buchstabieren eines Textes

;  Eingabeliste = Die Liste aus Chars, die mit string->list durch die Funktion (wort->natoalphabet) erstellt wurde
;  Ist die Liste leer, d.h. es gibt keine weiteren Chars zum Übersetzen, wird eine leere Liste ausgegeben.
;  Ist sie nicht leer, wird eine neue Liste erstellt: Das erste Element ist der Char, der übersetzt werden soll, das zweite Element der rekursive Aufruf der Funktion
(define (Liste->natoalphabet Eingabeliste)
  (if (empty? Eingabeliste)
      '() 
      (cons (natoalphabet (car Eingabeliste))
            (Liste->natoalphabet (cdr Eingabeliste)))))

; Wandelt einen String in eine Liste von Chars.
; wort = Das Wort, dass in Seesprech übersetzt werden soll
(define (wort->natoalphabet wort)
  (Liste->natoalphabet (string->list wort)))

;> (wort->natoalphabet "RACKET")
; '(Romeo Alfa Charlie Kilo Echo Tango)

;;; 2 Das internationale Flaggenalphabet

;;  2.1 Eine Datenstruktur für das Flaggenalphabet
;   Wir erstellen eine Liste, die zu jedem Buchstaben einen Schlüssel liefert. Durch diesen Schlüssel können wir auf die jeweilige Flagge zugreifen

(define Flaggentafel
  '(
    (#\A A)
    (#\B B)
    (#\C C)
    (#\D D)
    (#\E E)
    (#\F F)
    (#\G G)
    (#\H H)
    (#\I I)
    (#\J J)
    (#\K K)
    (#\L L)
    (#\M M)
    (#\N N)
    (#\O O)
    (#\P P)
    (#\Q Q)
    (#\R R)
    (#\S S)
    (#\T T)
    (#\U U)
    (#\V V)
    (#\W W)
    (#\X X)
    (#\Y Y)
    (#\Z Z)
    (#\0 Z0)
    (#\1 Z1)
    (#\2 Z2)
    (#\3 Z3)
    (#\4 Z4)
    (#\5 Z5)
    (#\6 Z6)
    (#\7 Z7)
    (#\8 Z8)
    (#\9 Z9)
    ))

;; 1.2 Codierungsfunktion
(define (Flaggenalphabet schluessel)
  (cadr (assoc schluessel Flaggentafel)))

;; 1.4 Buchstabieren eines Textes

;; TO DO: Ausgabe ist jetzt eine Liste. So werden aber keine Flaggensymbole ausgegeben. Müsste mit eval zu lösen sein, oder? Habe schon ein paar Dinge ausprobiert, vielleicht wisst ihr weiter?

;  Eingabeliste = Die Liste aus Chars, die mit string->list durch die Funktion (wort->flaggenalphabet) erstellt wurde
;  Ist die Liste leer, d.h. es gibt keine weiteren Chars zum Übersetzen, wird eine leere Liste ausgegeben.
;  Ist sie nicht leer, wird eine neue Liste erstellt: Das erste Element ist der Char, der übersetzt werden soll, das zweite Element der rekursive Aufruf der Funktion
(define (Liste->flaggenalphabet Eingabeliste)
  (if (empty? Eingabeliste)
      '()
      (cons (Flaggenalphabet (car Eingabeliste))
            (Liste->flaggenalphabet (cdr Eingabeliste)))))

; Wandelt einen String in eine Liste von Chars.
; wort = Das Wort, dass ins Flaggenalphabet übersetzt werden soll
(define (wort->flaggenalphabet wort)
  (Liste->flaggenalphabet (string->list wort)))