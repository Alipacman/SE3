#lang racket
(require se3-bib/flaggen-module)

;wir haben diese Datenstruktur gewählt, weil wir mittels dem Key bzw. der Abkürzung schnell auf den Wert kommen ( "A" -> "Alfa" )
;dafür benutzen wir (cdr(assoc ...). Das gibt uns dann letztendlich den Wert zurück.
(define seesprechliste '(("A"."Alfa") ("B" ."Bravo") ("C" ."Charlie") ("D" . "Delta")
                        ("E". "Echo") ("F" ."Foxtrott") ("G" . "Golf") ("H"."Hotel")
                        ("I" . "India") ("J" . "Juliett") ("K" . "Kilo") ("L" . "Lima")
                        ("M" . "Mike") ("N" . "November") ("O". "Oscar") ("P" . "Papa")
                        ("Q" . "Quebec") ("R"."Romeo") ("S" . "Sierra") ("T" . "Tango")
                        ("U" ."Uniform") ("V" . "Viktor") ("W" ."Whiskey") ("X" ."X-ray")
                        ("Y" . "Yankee") ("Z" ."Zulu") ("0" . "Nadazero") ("1"."Unaone")
                        ("2" . "Bissotwo") ("3" ."Terrathree") ("4" ."Kartefour") ("5" ."Pantafive")
                        ("6" ."Soxisix") ("7" ."Setteseven") ("8" ."Oktoeight") ("9" ."Novenine")
                        ("," ."Decimal") ("." ."Stop")))

;make-string macht aus einem char, welcher als Eingabe voraussgesetzt wird, einen String
(define (seesprech schlüssel)
  (cdr(assoc (make-string 1 schlüssel) seesprechliste)))

;hier für gibt es auch eine fertige Racket Funktion. Irgendetwas mit upcase und downcase.
(define (seesprech2 x)
  (if ( < 96 (char->integer x) 123)
      (seesprech(integer->char(- (char->integer x) 32)))
      (seesprech x)))

;wandelt einen string in eine Liste mit Chars um, danach wird nach und nach das erste Element der Liste umgewandelt und an eine neue
;Liste gehangen und aus der vorherigen mittels cdr entfernt.
;wenn die Liste leer ist, sprich kein pair mehr, dann wird die leere Liste rangehangen (Abbruchbedingung)
(define (s->text str)
  (if (not (list? str))
      (s->text (string->list str))
      (if (pair? str)
      (cons (seesprech(car str)) (s->text (cdr str)))
      '() )))

(define flaggentafel '(("A" . A) ("B" . B) ("C" . C) ("D" . D) ("E" . E) ("F" . F) ("G" . G)
                       ("H" . H) ("I" . I) ("J" . J) ("K" . K) ("L" . L) ("M" . M) ("N" . N)
                       ("O" . O) ("P" . P) ("Q" . Q) ("R" . R) ("S" . S) ("T" . T) ("U" . U)
                       ("V" . V) ("W" . W) ("X" . X) ("Y". Y) ("Z" . Z) ("0" . Z0) ("1" . Z1)
                       ("2" . Z2) ("3" . Z3) ("4" . Z4) ("5" . Z5) ("6" . Z6) ("7" . Z7) ("8" . Z8)
                       ("9" . Z9)))

;quasi wie oben bloß mit eval um die Flagge auszuwerten, sonst wird ein Symbol rausgegeben.
(define (flagge cha)
  (eval (cdr(assoc (make-string 1 cha) flaggentafel))))

;das selbe wie in Aufgabe 1, es bezieht sich nur auf die Flaggenliste.
(define (flaggen flag)
  (if (not(list? flag))
      (flaggen (string->list flag))
      (if (pair? flag)
          (cons (flagge(car flag)) (flaggen (cdr flag)))
          '() )))



  

  