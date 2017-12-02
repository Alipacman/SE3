#lang racket

#|
Blatt 4, Aufgabe 1 und 2, Gruppe 8, Mittwoch 10-12 Uhr, Raum G-210, Übungsleiter Rainer Jürgensen
Thomas Hofmann (6764839⁠⁠⁠)
Patricia Häußer (⁠⁠⁠6771401)
Ariana Sliwa (6816391)
|#

;;; 1 Auswertung von Ausdrücken

; 1. (max (min 5 (- 6 7)) 8)
;    Der Ausdruck evaluiert zu 8. Erst wird das Min von 5 und -1 genommen, dann das Max von -1 und 8.
; 2. '(+ (- 11 13) 17)
;    Der Ausdruck verändert sicht nicht, da es eine Liste ist und die Werte nicht in der Liste verändert werden.
; 3. (cadr '(Alle Jahre wieder))
;    Der Ausdruck evaluiert zu 'Jahre, da das zweite Element der Liste ausgegeben wird.
; 4. (cddr '(kommt (das Christuskind)))
;    Gibt eine leere Liste aus, da durch cddr beide Elemente der Liste entfernt werden.
; 5. (cons 'Auf '(die Erde nieder))
;    Das Element 'Auf wird am Anfang der Liste '(die Erde nieder) eingefügt: '(Auf die Erde nieder)
; 6. (cons 'Wo 'wir)
;    Es wird eine neue Liste mit dem Pair '(Wo . wir) gebildet
; 7. (equal? (list 'Menschen 'sind) '(Menschen sind))
;    Gibt #t zurück, da beide Listen gleich sind.
; 8. (eq? (list 'Rudolph 'Das 'Rentier) (cons 'Rudolph '(Das Rentier)))
;    Es wird #f ausgegeben, da mit eq? auf Identität und nicht Gleichheit geprüft wird. Die Listen sind zwar gleich, aber nicht identisch.

;;; 2   – Textgenerierung
;;  2.1 – Die Grammatik
#|
<Wort>            ::= <Textzeichen> <Wort> | <Textzeichen> 
<Textzeichen>     ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z |
                      A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z |
                      ä | Ä | ö | Ö | ü | Ü | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | ° | ' | , | . 
<Satz>            ::= <Satz> <Wort> | <Wort>

<Notmeldung>      ::= <Überschrift> <Standortangabe> <Notfallart> <Hilfeleistung> <Peilzeichen> <Unterschrift> <OVER>

<Überschrift>     ::= MAYDAY MAYDAY MAYDAY
                      DE
                      <Schiffsname> <Schiffsname> <Schiffsname> <Rufzeichenbuchstabiert>
                      MAYDAY <Schiffsname> ICH BUCHSTABIERE <Schiffsamebuchstabiert>
                      RUFZEICHEN <Rufzeichenbuchstabiert>

<Schiffsname>     ::= <Wort>
<Rufzeichen>      ::= <Buchstabe> <Buchstabe>  <Buchstabe>  <Buchstabe> 

<Standortangabe>  ::= NOTFALLPOSITION <Notfallposition>

<Notfallposition> ::= <Satz>

<Notfallart>      ::= <Satz>

<Hilfeleistung>   ::= <Satz>

<Peilzeichen>     ::= – –

<Unterschrift>    ::= <Schiffsname> <Rufzeichenbuchstabiert>

<OVER>            ::= OVER
|#

;; 2.2 – Der Generator
;; Notmeldungsgenerator
;  @param: Schiffsname, Rufzeichen, Position, Notfallart, Hilfeleistung
(define (notmeldungsgenerator schiffsname rufzeichen position notfallart hilfeleistung)
  (display (string-upcase(string-append (überschrift schiffsname rufzeichen) "\n"
                                        "NOTFALLPOSITION " position "\n"
                                        notfallart "\n"
                                        hilfeleistung " – –" "\n"
                                        (unterschrift schiffsname rufzeichen) "\n"
                                        "OVER" "\n"  "\n" ))))

; Generierung der Überschrift
(define (überschrift schiffsname rufzeichen)
  (string-append "MAYDAY MAYDAY MAYDAY" "\n"
                 (stringlist->string (Liste->Alphabet (string->list "DE"))) "\n"
                 schiffsname " " schiffsname " " schiffsname " " (buchstabiert rufzeichen)  "\n"
                 "MAYDAY" " " schiffsname " " "ICH BUCHSTABIERE " (buchstabiert schiffsname) "\n"
                 "RUFZEICHEN " (buchstabiert rufzeichen)))

; Generierung der Unterschrift
(define (unterschrift schiffsname rufzeichen)
  (string-append  schiffsname " " (buchstabiert rufzeichen)))


; - – – Hilfsfunktionen – – –
; Hilfsfunktion, die aus einer Liste von Strings (Beispiel: '(Delta Echo)) einen String macht
(define (stringlist->string slist)
  (string-join (map symbol->string slist) " "))

; Hilfsfunktion, buchstabiert ein eingegeben Wort nach den Regeln des Natoalphabet und gibt als Ergebnis einen String zurück 
(define (buchstabiert wort)
  (stringlist->string (Liste->Alphabet (string->list (string-upcase wort)))))

; Buchstabiertafel aus Aufgabenblatt 3
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

; Codierungsfunktion aus Aufgabenblatt 3
(define (natoalphabet schluessel)
  (cadr (assoc schluessel buchstabiertafel)))

; Buchstabierfunktion aus Aufgabenblatt 3
(define (Liste->Alphabet Eingabewort)
  (if (not (list? Eingabewort))
      (Liste->Alphabet (string->list Eingabewort))
      (if (pair? Eingabewort)
          (cons (natoalphabet(car Eingabewort)) (Liste->Alphabet (cdr Eingabewort)))
          '() )))
; – – – – – – 

;; 2.3 – Der Test
; Seaside
(notmeldungsgenerator "Seaside" "SSDE" "Ungefähr 10 sm nordöstlich Leuchtturm Kiel" "Notfallzeit 1000 UTC Schwerere Wassereinbruch wir sinken Keine Verletzten" "Vier Mann gehen in die Rettungsinsel Schnelle Hilfe Erfoderlich Ich sende den Träger")
; Amira
(notmeldungsgenerator "Amira" "AMRY" "57°46'N, 006°31'E" "Notfallzeit 0640 UTC Kenterung in schwerer See wir sinken" "9 Mann an Bord, das Schiff ist 15m lang, grüner Rumpf")