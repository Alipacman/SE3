#lang swindle
(require swindle/setf
         swindle/misc)

;;; ––– CLOS und generische Funktionen –––
;;  ––– 1.1 Definition von Klassen –––

; Definition der Oberklasse: Literaturbeiträge/Wissenschaftliche Veröffentlichung
( defclass* lb ()
   ( namen
     :initvalue '("A")
     :type <list>
     :reader n
     :initarg :n )
   ( jahr
     :initvalue "0000"
     :type <string>
     :reader j
     :initarg :j )
   ( titel
     :initvalue "titel"
     :type <string>
     :reader t
     :initarg :t )
   ( schluessel
     :initvalue '()
     :type <list>
     :reader s
     :initarg :s )
   :printer #t
   :autopred #t)

; Unterklasse von Literaturbeitrag: Buch
( defclass buch (lb)
   ( verlag
     :initvalue " "
     :type <string>
     :reader v
     :initarg :v )
   ( ort
     :initvalue " "
     :type <string>
     :reader o
     :initarg :o )
   ( reihe 
     :initvalue " "
     :type <string>
     :reader r
     :initarg :r )
   ( snummer
     :initvalue " "
     :type <string>
     :reader sn
     :initarg :sn )
   :printer #t
   :autopred #t)

; Unterklasse von Literaturbeitrag: Sammelband
( defclass sammelband (buch)
   ( herausgeber
     :initvalue " "
     :type <string>
     :reader h
     :initarg :h )
   ( seitenangaben
     :initvalue " "
     :type <string>
     :reader sa
     :initarg :sa )
   :printer #t
   :autopred #t)

; Unterklasse von Literaturbeitrag: Zeitschriftenartikel
( defclass zeitschriftenartikel (lb)
   ( name
     :initvalue " "
     :type <string>
     :reader zn
     :initarg :zn )
   ( bandnr
     :initvalue " "
     :type <string>
     :reader bn
     :initarg :bn )
   ( heftnr
     :initvalue " "
     :type <string>
     :reader hn
     :initarg :hn )
   ( monat 
     :type <string>
     :reader m
     :initarg :m )
   :printer #t
   :autopred #t)


; Hilfsfunktionen, um Literaturbeiträge zu erstllen
(define (erstellebuch  n j t v o r sn)
  (make buch :n n :j j :t t :s (list n j t) :v v :o o :r r :sn sn))

(define (erstellesammelband  n j t v o r sn h sa)
  (make sammelband :n n :j j :t t :s (list n j t) :v v :o o :r r :sn sn :h h :sa sa))

(define (erstelleartikelmitmonat  n j t zn bn hn m)
  (make zeitschriftenartikel :n n :j j :t t :s (list n j t) :zn zn :bn bn :hn hn :m m))

(define (erstelleartikelohnemonat  n j t zn bn hn )
  (make zeitschriftenartikel :n n :j j :t t :s (list n j t) :zn zn :bn bn :hn hn))

; Erzeugen von Literaturbeitrag-Objekten
; Buch
(define Nessie1790
  (erstellebuch '("Nessie") "1790" "Mein Leben im Loch Ness: Verfolgt als Ungeheuer" "Minority-Verlag" "Inverness" "Die Besondere Biographie" "1"))
; Sammelband
(define Prefect1979
  (erstellesammelband '("Prefect, F.") "1979" "Mostly harmless - some observations concerning the third planet of the solar sytem" "Galactic Press" "Vega-System, 3rd planet" "The Hitchhiker's Guide to the Galaxy" "volume 5 of 'Travel in Style'" "Adams, D." "1500 edition, p. 500"))
; Zeitschriftenartikel
(define Wells3200
  (erstelleartikelohnemonat '("Wells, H.G.") "3200" "Zeitmaschinen leicht gemacht." "Heimwerkerpraxis für Anfänger" "500" "3"))


;; ––– 1.2 Generische FUnktionen und Methoden –––
( defgeneric* cite ( (literaturbeitrag lb))
   :documentation
   "Einen Literaturbeitrag zitieren." )

; TO DO: mehrere Autoren auflisten und mit Leerzeichen trennen

; Generische Funktion cite
; @param literaturbeitrag der Klasse lb
(defmethod cite ((literaturbeitrag lb))
  (cond
    [(sammelband? literaturbeitrag)
     (concat  (apply concat (n literaturbeitrag)) " ("
              (j literaturbeitrag) "). "
              (t literaturbeitrag) ". " "In "
              (h literaturbeitrag) ", editor, "
              (r literaturbeitrag) ", "
              (sn literaturbeitrag) ". "
              (v literaturbeitrag) ", "
              (o literaturbeitrag) ", "
              (sa literaturbeitrag) ".")
     ]
    [(buch? literaturbeitrag)
     (concat  (apply concat (n literaturbeitrag)) " ("
              (j literaturbeitrag) "). "
              (t literaturbeitrag) ", " "Band "
              (sn literaturbeitrag) " der Reihe: "
              (r literaturbeitrag) ". "
              (v literaturbeitrag) ", "
              (o literaturbeitrag) ".")
     ]
    
    [(zeitschriftenartikel? literaturbeitrag)
     (concat  (apply concat (n literaturbeitrag)) " ("
              (j literaturbeitrag) "). "
              (t literaturbeitrag) ". "
              (zn literaturbeitrag) ", "
              (bn literaturbeitrag) "("
              (hn literaturbeitrag) ").")
     ]
    ))

; Erprobung der generischen Funktion cite an obigen Beispielen
(cite Nessie1790)
(cite Prefect1979)
(cite Wells3200)