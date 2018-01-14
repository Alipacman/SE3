#lang swindle

;Aufgabe 1

(defclass* Literaturbeitrag ()
  (autor
   :reader beitrag-autor
   :writer set-autor
   :initarg :autor
   :initvalue ""
   :type <string>
   :documentation
   "Der_Autor_von_einem_Beitrag")
  (erscheinungsjahr
   :reader beitrag-jahr
   :writer set-jahr
   :initarg :erscheinungsjahr
   :initvalue 0000
   :type <number>
   :documentation
   "Das_Erscheinungsjahr_von_einem_Beitrag")
    (titel
   :reader beitrag-titel
   :writer set-titel
   :initarg :titel
   :initvalue ""
   :type <string>
   :documentation
   "Titel_der_Veröffentlichung_von_einem_Beitrag")
    (schlüssel
   :reader beitrag-schlüssel
   :initarg :schlüssel
   :initvalue '()
   :type <list>
   :documentation
   "(list (string->number beitrag-autor) beitrag-jahr string->number beitrag-titel)")
  :autopred #t
  :pringer #t
  :documentation
  "The_top_class_of_all_Literaturbeiträge"
   )

(defclass* Buch (Literaturbeitrag)
    (verlag
   :reader buch-verlag
   :writer set-verlag
   :initarg :verlag
   :initvalue ""
   :type <string>
   :documentation
   "Der_Verlag_eines_Buches")
    (verlagsort
   :reader buch-verlagsort 
   :writer set-verlagsort
   :initarg :verlagsort
   :initvalue ""
   :type <string>
   :documentation
   "Der_Verlagsort_eines_Buches")
  (reihe
   :reader buch-reihe
   :writer set-reihe
   :initarg :reihe
   :initvalue ""
   :type <string>
   :documentation
   "Die_Reihe_eines_Buches")
    (seriennummer
   :reader buch-seriennummer
   :writer set-seriennummer
   :initvalue 0
   :type <number>
   :documentation
   "Die_Seriennummer_eines_Buches")
  :autopred #t
  :printer #t
  :documentation
  "Klasse_Buch_welche_eine_Unterklasse_von_Literaturbeiträge_ist"
  )

(defclass* Sammelband (Buch)
    (herausgeber
   :reader sammelband-herausgeber
   :writer set-herausgeber
   :initarg :herausgeber
   :initvalue ""
   :type <string>
   :documentation
   "Der_Name_des_Herausgebers_eines_Sammelbadnes")
    (seitenangabe
   :reader sammelband-seitenangabe
   :writer set-seitenangabe
   :initarg :seitenangabe
   :initvalue 0
   :type <number>
   :documentation
   "Seitenangaben_zum_Artikel_im_Buch")
  :autopred #t
  :printer #t
  :documentation
  "Klasse_Sammelband_welche_eine_Unterklasse_von_Buch_ist"
  )

(defclass* Zeitschriftenartikel (Literaturbeitrag)
    (zeitschrifts-name
   :reader zeitschrift-name
   :writer set-zeitschrift-name
   :initarg :zeitschrifts-name
   :initvalue ""
   :type <string>
   :documentation
   "Der_Name-der-Zeitschrift")
    (band-nummer
   :reader band-nummer
   :writer set-band-nummer
   :initarg :band-nummer
   :initvalue 0
   :type <number>
   :documentation
   "Die_Nummer_des_Bandes")
    (heft-nummer
   :reader heft-nummer
   :writer set-heft-nummer
   :initarg :heft-nummer
   :initvalue 0
   :type <number>
   :documentation
   "Die_Nummer_des_Heftes")
    (erscheinungs-monat
   :reader zeitschrift-erscheinungs-monat
   :writer set-erscheinungs-monat
   :initarg :erscheinungs-monat
   :initvalue ""
   :type <string>
   :documentation
   "Der Erscheinungsmonat eines Zeitschriftenartikels")
  :autopred #t
  :printer #t
  :documentation
  "Klasse_Zeitschriftenartikel_welche_eine_Unterklasse_von_Literaturbeiträge_ist"
  )

(make Buch
      :autor "Nessie"
      :erscheinungsjahr 1790
      :titel "Mein Leben im Loch Ness: Verfolgt als Ungeheuer"
      :schlüssel (list "Nessie" (number->string 1790) "Mein Leben im Loch Ness: Verfolgt als Ungeheuer")
      :verlag "Minority-Verlag"
      :verlagsort "Inverness"
      :reihe "Die besondere Biographie"
      :seriennummer 1)

(make Sammelband
      :autor "Adams, D."
      :erscheinungsjahr 1979
      :titel: "Prefect, F"
      :schlüssel (list "Adams, D." (number->string 1790) "Prefect, F")
      :verlag "Galactic Press"
      :verlagsort  "Vega-System, 3rd planet"
      :reihe "Travel in Style"
      :seriennummer 5
      :herausgeber "Galactic Press"
      :seitenangabe 500
      )

(make Zeitschriftenartikel
      :autor "Wells, H. G."
      :erscheinungsjahr 3200
      :titel "Zeitmaschinen leicht gemacht"
      :schlüssel (list "Wells, H. G." (number->string 3200) "Zeitmaschinen leicht gemacht")
      :reihe "Heimwerkerpraxis für Anfänger"
      :band-nummer 500
      :heft-nummer 4
      )








  