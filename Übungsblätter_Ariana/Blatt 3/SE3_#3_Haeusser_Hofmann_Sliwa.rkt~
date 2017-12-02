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
;  Ein eingegebener Buchstabe (char) wird auf den passenden Schlüssel aus der buchstabiertafel abgebildet.
(define (natoalphabet schluessel)
  (cadr (assoc schluessel buchstabiertafel)))

;; 1.4 Buchstabieren eines Eingabeworts
;  @param: Eingabewort: Das Wort, das in Seesprech übersetzt werden soll.
(define (Liste->Alphabet Eingabewort)
  (if (not (list? Eingabewort))
      (Liste->Alphabet (string->list Eingabewort))
      (if (pair? Eingabewort)
      (cons (natoalphabet(car Eingabewort)) (Liste->Alphabet (cdr Eingabewort)))
      '() )))

;> (Liste->Alphabet "RACKET")
;'(Romeo Alfa Charlie Kilo Echo Tango)

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
  (eval
   (cadr (assoc schluessel Flaggentafel))))

;; 1.3 Buchstabieren eines Textes
;  @param: Eingabewort: Das Wort, das mit Flaggen übersetzt werden soll.
(define (Liste->Flaggenalphabet Eingabewort)
  (if (not (list? Eingabewort))
      (Liste->Flaggenalphabet (string->list Eingabewort))
      (if (pair? Eingabewort)
      (cons (Flaggenalphabet(car Eingabewort)) (Liste->Flaggenalphabet (cdr Eingabewort)))
      '() )))
