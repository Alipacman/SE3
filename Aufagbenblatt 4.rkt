#lang racket

;Aufgabe 1

#|
1. evaluiert zu 6, weil erst der kleinere Wert von 5 und 1 (8 - 7 = 1) ausgewählt wird durch die Funktion min.
Dannach wird durch die Funktion max der größere Wert von 1 (aus der ersten Funktion min) und 6 ausgewählt. 
Wert
2. ?
3. Evaluiert zum Symbol King, weil durch die Funktion cadr wird aus der Liste aus dem Schwanz der Liste, das erste Element ausgegeben wird.
4. Evaluiert zur leeren Liste, da aus der Liste mit 3 Elementen mit der Funktion cdddr das vierte Element returnt wird, und das letzte Element einer
Liste ist die leere Liste.
5. ?
6. Evaluiert zu einem Pair ('((Deep and) . crisp)), bei welchen die Liste the '(Deep and)
das erste Element und das Symbol crisp das zweite Element ist
7. Erstelt erst eine Liste  durch :(list ’and ’even) und prüft dann ob Gleicheit besteht mit der Liste ’(and even), und returnt dann true,
weil die Elemente identisch sind
8. Erstellt erst eine Liste  mit der funktion list und eine mit der Funktion cons. Die Listen sind beide gleich, aber nicht identisch,
da sie verschiedene verschiedene Refferenzen haben udn mit eq? wird dies geprüft und liefert daher false.
|#

;Aufgabe 2.1

#|
1.
In unserer Lösung muss ein Satz nicht gramatikalisch korrekt sein und kann auch aus nur einem Wort oder Zeichen bestehen.
Außerdem kann der Schiffsname auch aus nur einem Zeichen oder aus mehreren Wörtern bestehen.


<Notmeldung> ::= <Überschrift> <Standort> <NotfallArt> <WeitereAngaben> <Peilzeichen> <Peilzeichen> <Unterschrift> <Over>

<Überschrift> ::=
<NotzeichenMayDay> <NotzeichenMayDay> <NotzeichenMayDay>
<Hier Ist>
<Schiffsname> <Schiffsname> <Schiffsname> <Rufzeichenbuchstabiert>
<NotzeichenMayDay> <Schiffsname> <Schiffsnamebuchstabiert>
<Rufzeichenbuchstabiert>

<Standort> ::= <Satz>
<NotfallArt> ::= <Satz>
<WeitereAngaben> ::= <Satz>
<Peilzeichen> ::= -
<Unterschrift> ::= <Schiffsname> <Rufzeichenbuchstabiert>
<Over> ::= OVER

<NotzeichenMayDay> ::= MAYDAY
<Hier Ist> ::= HIER IST | DELTA ECHO
<Schiffsname> ::= <Satz>
<Schiffsnamebuchstabiert> ::= <Satz>
<Rufzeichenbuchstabiert> ::= <Satz>

<Satz>            ::= <Satz> <Wort> | <Wort>
<Wort>            ::= <Textzeichen> <Wort> | <Textzeichen> 
<Textzeichen>     ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z |
                      A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z |
                      ä | Ä | ö | Ö | ü | Ü | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | ° | ' | , | | .
|#

;Aufgabe 2.2

(define tafel '(
                (#\A "Alpha")
                (#\B "Bravo")
                (#\C "Charlie")
                (#\D "Delta")
                (#\E "Echo")
                (#\F "Foxtrot")
                (#\G "Golf")
                (#\H "Hotel")
                (#\I "India")
                (#\J "Juliet")
                (#\K "Kilo")
                (#\L "Lima")
                (#\M "Mike")
                (#\N "November")
                (#\O "Oscar")
                (#\P "Papa")
                (#\Q "Quebec")
                (#\R "Romeo")
                (#\S "Sierra")
                (#\T "Tango")
                (#\U "Uniform")
                (#\V "Viktor")
                (#\W "Whisky")
                (#\X "X-Ray")
                (#\Y "Yankee")
                (#\Z "Zulu")
                (#\0 "Nadazero")
                (#\1 "Unaone")
                (#\2 "Duotwo")
                (#\3 "Terrathree")
                (#\4 "Carrefour")
                (#\5 "Pentafive")
                (#\6 "Soxisix")
                (#\7 "Setteseven")
                (#\8 "Oktoeight")
                (#\9 "Novonine")
                (#\, "Decimal")
                (#\. "Stop")
                (#\Space "Bank")
                ))

;Funktionen um den Schlüssel zu beliebigen Charakter auszugeben aus der Tafel
(define (give-char-pair x) (assoc x tafel ))

(define (give-Key x)  (cdr(give-char-pair x)) )


(define (text-to-Key x)
  (
   define (make-list xs) (
                          if (empty? xs) xs
                             (cons (give-Key (car xs))
                                   (make-list (cdr xs))))
    )
  (make-list ( string->list x) 
             ))


;Hauptfunktion
(define (notruf-generator schiffsname rufzeichen position art-und-angaben) (
                                                                     string-upcase (string-append
                                                                                    (überschrift-generieren schiffsname rufzeichen) " \n "
                                                                                    position " \n "
                                                                                    art-und-angaben
                                                                                    "--"  " \n "
                                                                                    (buchstabierer schiffsname) " \n "
                                                                                    (buchstabierer rufzeichen) " \n "
                                                                                    "OVER"
                                                                    
                                                                                   )))
;Funktion um überschrift zu generieren
(define (überschrift-generieren schiffsname rufzeichen )(
                                                         string-append
                                                         "MAYDAY MAYDAY MAYDAY" " \n "
                                                         "DELTA ECHO" ; oder man benutzt "HIER IST"
                                                         " \n "
                                                         schiffsname " " schiffsname " " schiffsname " "  (buchstabierer rufzeichen) " \n "
                                                         "MAYDAY " schiffsname " " (buchstabierer schiffsname) " \n "
                                                         (buchstabierer rufzeichen)
                                                         ))


;funktion wählt random aus ob HIER IST oder DELTA ECHO genommen wird. Funktioniert leider nicht, obwohl es genau wie in den Folien benutzt wurde. :(
;(define (hier-ist-oder-DE) (one-of ’("HIER IST" "DELTA ECHO" )))
                                 


;Buchstabiert String im Schiffahrts Alphabet
(define (buchstabierer x) 
  (list-to-string(text-to-Key (string-upcase x))))


;Hilfsfunktion
(define (list-to-string x)
  (if ( > (length  x) 1)
      (string-append 
       (caar x) " "
       (list-to-string(cdr x)))
      (string-append(caar x))
      ))


(notruf-generator "UNICORN" "UCRN" "NOTFALLPOSITION UNGEFÄHR 5 SM NORDWESTLICH LEUCHTTURM ROTER SAND"
          "NOTFALLZEIT 1000 UTC SCHWERE SCHLAGSEITE WIR SINKEN KEINE VERLETZTEN SECHS MANN GEHEN IN DIE RETTUNGSINSEL SCHNELLE HILFE ERFORDERLICH ICH SENDE DEN TRÄGER")

(notruf-generator "Nautilus" "DEYJ" "Notfallposition un- gefähr 10 sm östlich Point Nemo 48° 52’ 31,75” S, 123° 23’ 33,07“ W"
           "ein Riesenkrake hat das Schiff umschlungen, ein grosses Leck im Rumpf. Weitere Angaben: 20 Personen an Bord, treiben an- triebslos an der Wasseroberfläche.")

(notruf-generator "Maltese Falcon" "HUQ9" "N 54° 34’ 5,87”, E 8° 27’ 33,41"
           "auf eine Sandbank aufgelaufen ist: 10 Mann an Bord, das Schiff ist 88m lang, schwarzer Rumpf. Unfallzeit 0730 UTC." )



