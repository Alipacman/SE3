#lang racket
(require se3-bib/flaggen-module)
(require se3-bib/tools-module)

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


;wandelt einen string in eine Liste mit Chars um, danach wird nach und nach das erste Element der Liste umgewandelt und an eine neue
;Liste gehangen und aus der vorherigen mittels cdr entfernt.
;wenn die Liste leer ist, sprich kein pair mehr, dann wird die leere Liste rangehangen (Abbruchbedingung)

(define (s->string str)
 (if (list? str)
     (if (pair? str)
     (string-append (seesprech (car str)) " " (s->string (cdr str))) "")
     (s->string (string->list str))))




;name MUSS groß sein
(define (notsignal sname rufz sort artn weitere)
  (display (string-append mayday mayday mayday "\n"
                          (hierist sname rufz) "\n"
                          mayday (namebuchst sname) "\n"
                          "RUFZEICHEN: " (rufzeichen rufz) "\n"
                          "STANDORT CA.: " sort "\n"
                          "PROBLEM: " artn "\n"
                          "WEITERES: " weitere "\n"
                          (peilzeichen sname rufz))))
                          


 (define (namebuchst sname)
   (string-append sname " ICH BUSTABIERE " (s->string sname)))
 (define mayday "MAYDAY ")

 (define (hierist dername rufzs)
   (string-append "HIER IST \n" dername " " dername " " dername " " (rufzeichen rufzs)))

 (define (rufzeichen rufz)
   (s->string rufz))

 (define (peilzeichen dername2 rufz2)
   (string-append "ICH SENDE DEN TRÄGER -- \n" dername2 " " (rufzeichen rufz2)  "\nOVER"))

(notsignal "AMIRA" "AMRY" "57°46'N, 006°31'E" "nach Kenterung in schwerer See sinkt 9 Mann an Bord, das Schiff ist 15m lang, grüner Rumpf"
           "Notfallzeit 0640 UTC")




  

  