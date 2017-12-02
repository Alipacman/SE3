#lang swindle

(require swindle/setf
         swindle/misc)

#|
Blatt 9, Gruppe 8, Mittwoch 10-12 Uhr, Raum G-210, Übungsleiter Rainer Jürgensen
Thomas Hofmann (6764839⁠⁠⁠)
Patricia Häußer (⁠⁠⁠6771401)
Ariana Sliwa (6816391)
|#

;;; ––– 1 CLOS und generische Funktionen –––
;;  ––– 1.1 Definition von Klassen –––

; Definition der Oberklasse: Literaturbeitrag/Wissenschaftliche Veröffentlichung
( defclass* Literaturbeitrag ()
   ( autor
     :reader get-autor
     :initarg :autor
     :initvalue " "
     :type <string>
     :documentation "Name des Autors"
     )
   ( erscheinungsjahr
     :reader get-erscheinungsjahr
     :initarg :erscheinungsjahr
     :initvalue 0000
     :type <number>
     :documentation "Erscheinungsjahr des Literaturbeitrags"
     )
   ( titel
     :reader get-titel
     :initarg :titel
     :initvalue ""
     :type <string>
     :documentation "Titel des Literaturbeitrags"
     )
   ( key
     :reader get-key
     :initarg :key
     :initvalue 0
     :type <number>
     :documentation "(* jahr (* (string-length autor)(string-length titel)))"
     )
   :printer #t
   :autopred #t
   )

; Unterklasse von Literaturbeitrag: Buch
( defclass Buch (Literaturbeitrag)
   ( Verlagsname
     :reader get-verlagsname
     :initarg :verlagsname
     :initvalue ""
     :type <string>
     :documentation "Name des Verlags"
     )
   ( Verlagsort
     :reader get-verlagsort
     :initarg :verlagsort
     :initvalue ""
     :type <string>
     :documentation "Ort des Verlags"
     )
   ( Reihe
     :reader get-reihe
     :initarg :reihe
     :initvalue ""
     :type <string>
     :documentation "Reihe des Buchs"
     )
   ( Seriennummer
     :reader get-seriennummer
     :initarg :seriennummer
     :initvalue 0
     :type <number>
     :documentation "Seriennummer des Buchs"
     )
   :printer #t
   :autopred #t
   )

; Unterklasse von Literaturbeitrag: Sammelband
( defclass Sammelband (Buch)
   ( Herausgeber
     :reader get-herausgeber
     :initarg :herausgeber
     :initvalue ""
     :type <string>
     :documentation "Herausgeber des Sammelbandes"
     )
   ( Seitenangabe
     :reader get-seitenangabe
     :initarg :seitenangabe
     :initvalue 0
     :type <number>
     :documentation "Seitenangabe des Artikels im Buch"
     )
   :printer #t
   :autopred #t
   )

; Unterklasse von Literaturbeitrag: Zeitschriftenartikel
( defclass Zeitschriftenartikel (Literaturbeitrag)
   ( Zeitschrift
     :reader get-zeitschrift
     :initarg :zeitschrift
     :initvalue ""
     :type <string>
     :documentation "Name der Zeitschrift"
     )
   ( Bandnummer
     :reader get-bandnummer
     :initarg :bandnummer
     :initvalue 0
     :type <number>
     :documentation "Nummer des Bandes"
     )
   ( Heftnummer
     :reader get-heftnummer
     :initarg :heftnummer
     :initvalue 0
     :type <number>
     :documentation "Nummer des Heftes"
     )
   ( Erscheinungsmonat
     :reader get-erscheinungsmonat
     :initarg :erscheinungsmonat
     :type <number>
     :documentation "Erscheinungsmonat des Heftes"
     )
   :printer #t
   :autopred #t
   )

; Hilfsfunktionen, um Literaturbeiträge zu erstllen
(define (make-literaturbeitrag autor jahr titel)
  (make Literaturbeitrag
        :autor autor
        :erscheinungsjahr jahr
        :titel titel
        :key (* jahr (* (string-length autor)(string-length titel)))))

(define (make-Buch autor jahr titel verlagsname verlagsort reihe seriennummer)
  (make Buch
        :autor autor
        :erscheinungsjahr jahr
        :titel titel
        :key (* jahr (* (string-length autor)(string-length titel)))
        :verlagsname verlagsname
        :verlagsort verlagsort
        :reihe reihe
        :seriennummer seriennummer
        ))

(define (make-Sammelband autor jahr titel verlagsname verlagsort reihe seriennummer herausgeber seitenangabe)
  (make Sammelband
        :autor autor
        :erscheinungsjahr jahr
        :titel titel
        :key (* jahr (* (string-length autor)(string-length titel)))
        :verlagsname verlagsname
        :verlagsort verlagsort
        :reihe reihe
        :seriennummer seriennummer
        :herausgeber herausgeber
        :seitenangabe seitenangabe
        ))

;  Mit Monatsangabe
(define (make-Zeitschriftenartikel1 autor jahr titel zeitschrift  bandnummer heftnummer monat)
  (make Zeitschriftenartikel
        :autor autor
        :erscheinungsjahr jahr
        :titel titel
        :key (* jahr (* (string-length autor)(string-length titel)))
        :zeitschrift zeitschrift
        :bandnummer bandnummer
        :heftnummer heftnummer
        :erscheinungsmonat monat
        ))

;  Ohne Monatsangabe
(define (make-Zeitschriftenartikel2 autor jahr titel zeitschrift  bandnummer heftnummer)
  (make Zeitschriftenartikel
        :autor autor
        :erscheinungsjahr jahr
        :titel titel
        :key (* jahr (* (string-length autor)(string-length titel)))
        :zeitschrift zeitschrift
        :bandnummer bandnummer
        :heftnummer heftnummer
        ))

; Erzeugen von Literaturbeitrag-Objekten
(define Nessie
  (make-Buch "Nessie"
             1790
             "Mein Leben im Loch Ness: Verfolgt als Ungeheuer"
             "Minority-Verlag"
             "Inverness"
             "Die besondere Biographie"
             1
             ))

(define Prefect
  (make-Sammelband "Prefect, F"
                   1979
                   "Mostly harmless - some observations concerning the third planet of the solar sytem"
                   "Galactic Press"
                   "Vega-System, 3rd planet"
                   "Travel in Style"
                   5   
                   "Adams, D."
                   500
                   ))

(define Wells
  (make-Zeitschriftenartikel2 "Wells, H. G."
                              3200
                              "Zeitmaschinen leicht gemacht"
                              "Heimwerkerpraxis für Anfänger"
                              500
                              3
                              ))

;; ––– 1.2 Generische Funktionen und Methoden –––

; Generische Funktion cite
( defgeneric* cite ( (lb Literaturbeitrag))
   :documentation "Einen Literaturbeitrag zitieren."
   )

; cite für einen Literaturbeitrag
( defmethod cite ((l Literaturbeitrag))
   (concat (get-autor l)
           " ("(number->string (get-erscheinungsjahr l))"). "
           (get-titel l)"."))

; cite für ein Buch
( defmethod cite ((b Buch))
   (concat (get-autor b)
           " ("(number->string (get-erscheinungsjahr b))"). "
           (get-titel b)", "
           "Band " (number->string (get-seriennummer b))" der Reihe: "
           (get-reihe b)". "
           (get-verlagsname b)", "
           (get-verlagsort b)"."))

; cite für einen Sammelband
( defmethod cite ((s Sammelband))
   (concat (get-autor s)
           " ("(number->string (get-erscheinungsjahr s))"). "
           (get-titel s)". "
           (get-herausgeber s)", editor, "
           "volume "(number->string (get-seriennummer s))
           " of "(get-reihe s)"'. "
           (get-verlagsname s)", "
           (get-verlagsort s)", "
           "p. "(number->string (get-seitenangabe s))"."))

; cite für einen Zeitschriftenartikel
( defmethod cite ((z Zeitschriftenartikel))
   (concat (get-autor z)
           " ("(number->string (get-erscheinungsjahr z))"). "
           (get-titel z)". "
           (get-zeitschrift z)", "
           (number->string (get-bandnummer z))
           "("(number->string (get-heftnummer z))")."))

(displayln (cite Nessie))
(displayln (cite Prefect))
(displayln (cite Wells))     


;; ––– 1.3 Ergänzungsmethoden –––

#|
Ergänzungsmethoden sind Methoden der Unterklasse, die das Verhalten einer Methode der Oberklasse ergänzen oder erweitern können.
Sie haben den gleichen Namen, sind aber mit den Schlüsselwörtern :before :after oder :around markiert. So wird deutlich, ob die Methode
vor oder nach der Methode der Oberklasse zusätzlich aufgerufen werden soll. Im Gegensatz zum super call ist hier sichergestellt, dass
alle Ergänzungsmethoden aufgerufen werden. So können keine Initialisierungen vergessen oder unterdrückt werden, die in den Oberklassen definiert wurden.

In unserem Fall könnten Ergänzungsmethoden bei cite eingesetzt werden, indem mit dem Schlüsselwort :after mehr Attribute hinzugefügt werden.
|#

;;; ––– 2 CLOS und Vererbung –––
;;  ––– 2.1 Definition von Klassen –––
#|
( defclass Fahrzeug ())

( defclass Landfahrzeug (Fahrzeug))
( defclass Schienenfahrzeug (Landfahrzeug))
( defclass Straßenfahrzeug (Landfahrzeug))
( defclass Zweiwegefahrzeug (Schienenfahrzeug Straßenfahrzeug))

( defclass Schwimmfahrzeug (Fahrzeug))
( defclass Amphibienfahrzeug (Landfahrzeug Schwimmfahrzeug))

( defclass Luftfahrzeug (Fahrzeug))
( defclass Amphibienflugzeug (Luftfahrzeug Landfahrzeug Schwimmfahrzeug))

( defclass Zeitzug (Luftfahrzeug Schienenfahrzeug))
|#


( defclass Fahrzeug ()
   ( Medium
     :reader get-medium
     :initvalue '()
     :initarg :medium
     :type <list>
     )
   ( Maximalgeschwindigkeit
     :reader get-maximalgeschwindigkeit
     :initvalue 0
     :initarg :maximalgeschwindigkeit
     :type <number>
     )
   ( Zuladung
     :reader get-zuladung
     :initvalue 0
     :initarg :zuladung
     :type <number>
     )
   ( Verbrauch
     :reader get-verbrauch
     :initvalue 0
     :initarg :verbrauch
     :type <number>
     )
   ( PAX
     :reader get-pax
     :initvalue 0
     :initarg :pax
     :type <number>
     )
   :printer #t
   :autopred #t
   )

( defclass Landfahrzeug (Fahrzeug)
   (Medium
    :initvalue '(Land)
    :printer #t
    ))

( defclass Schienenfahrzeug (Landfahrzeug)
   (Medium
    :initvalue '(Land und Schiene)
    :printer #t
    ))

( defclass Straßenfahrzeug (Landfahrzeug)
   (Medium
    :initvalue '(Land und Straße)
    :printer #t
    ))

( defclass Zweiwegefahrzeug (Schienenfahrzeug Straßenfahrzeug)
   :printer #t
   )

( defclass Schwimmfahrzeug (Fahrzeug)
   (Medium
    :initvalue '(Wasser)
    :printer #t
    ))

( defclass Amphibienfahrzeug (Landfahrzeug Schwimmfahrzeug)
   :printer #t
   )

( defclass Luftfahrzeug (Fahrzeug)
   (Medium
    :initvalue '(Luft)
    :printer #t
    ))

( defclass Amphibienflugzeug (Luftfahrzeug Landfahrzeug Schwimmfahrzeug)
   :printer #t
   )

( defclass Zeitzug (Luftfahrzeug Schienenfahrzeug)
   :printer #t
   )


; Generische Methoden
( defgeneric read-medium ((f Fahrzeug))
  :combination generic-append-combination) ;Es ist wichtig, dass jedes Medium dargestellt wird, daher append. 

( defgeneric read-maximalgeschwindigkeit ((f Fahrzeug))
   :combination generic-min-combination ) ;Das Fahrzeug wird mindestens so schnell fahren, wie das langsamste Fahrzeug der kombinierten Klassen.

( defgeneric read-zuladung ((f Fahrzeug))
   :combination generic-min-combination ) ;Das Fahrzeug wird mindestens so viel tragen können, wie das, das am wenigsten tragen kann.

( defgeneric read-verbrauch ((f Fahrzeug))
   :combination generic-max-combination ) ;Der Verbrauch des Fahrzeugs mit dem höchsten Verbrauch.

( defgeneric read-pax ((f Fahrzeug))
   :combination generic-min-combination ) ;Maximale Passagieranzahl des Fahrzeugs mit der geringsten Passagieranzahl.

; Implementation der generischen Methode read-medium

( defmethod read-medium (( f Fahrzeug))
   (get-medium f))

( defmethod read-medium (( l Landfahrzeug))
   (get-medium l))

( defmethod read-medium (( s Schienenfahrzeug))
   (get-medium s))

( defmethod read-medium (( st Straßenfahrzeug))
   (get-medium st))

( defmethod read-medium (( z Zweiwegefahrzeug))
   (get-medium z))

( defmethod read-medium (( sch Schwimmfahrzeug))
   (get-medium sch))

( defmethod read-medium (( amfa Amphibienfahrzeug))
   (get-medium amfa))

( defmethod read-medium (( lu Luftfahrzeug))
   (get-medium lu))

( defmethod read-medium (( amflu Amphibienflugzeug))
   (get-medium amflu))

( defmethod read-medium (( ze Zeitzug))
   (get-medium ze))


(define fancyauto
  (make Zweiwegefahrzeug :maximalgeschwindigkeit 200 :zuladung 1800 :verbrauch 10 :pax 5))

(define segelbus 
  (make Amphibienfahrzeug :maximalgeschwindigkeit 120 :zuladung 6000 :verbrauch 5 :pax 7))

(define helibusboot 
  (make Amphibienflugzeug :maximalgeschwindigkeit 280 :zuladung 1000 :verbrauch 20 :pax 3))

(define doc 
  (make Zeitzug :maximalgeschwindigkeit 400 :zuladung 10000 :verbrauch 30 :pax 100))

;(read-medium fancyauto)
; > (Land und Schiene Land und Schiene Land und Schiene Land und Schiene Land und Schiene)
;TO DO: Das scheint irgendwie noch nicht so zu klappen.

;CLOS legt eine Präzedenzliste für die Klassen an, die nach folgenden Regeln geordnet ist:
;– Jede Klasse hat Vorrang vor ihren Oberklassen.
;– Jede Klasse legt die Präzedenz der direkten Oberklassen fest.

