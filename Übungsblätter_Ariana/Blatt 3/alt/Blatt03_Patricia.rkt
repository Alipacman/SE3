#lang racket
(require se3-bib/flaggen-module)

;;; 1 Die internationale Buchstabiertafel
;;  1.1 Datenstruktur für die internationale Buchtabiertafel
(define buchstabiertafel '( ("Alfa" . "A") ("Bravo" . "B")))

;; 1.2 Codierungsfunktion
(define (natoalphabet schluessel)
  (cdr (assoc schluessel buchstabiertafel)))

;; 1.4 Buchstabieren eines Textes
;  Buchstabiertafel reverse, damit bei Eingabe eines einzelnen Buchstaben der entsprechende längere String herausgegeben wird 
(define reversebuchstabiertafel '( ("A" . "Alfa") ("B" . "Bravo") ("C" . "Charlie") ("D" . "Delta") ("E" . "Echo") ("F" . "Foxtrott")
                                                  ("G" . "Golf") ("H" . "Hotel") ("I" . "India") ("J" . "Juliett") ("K" . "Kilo") ("L" . "Lima")
                                                  ("M" . "Mike") ("N" . "November") ("O" . "Oscar") ("P" . "Papa") ("Q" . "Quebec") ("R" . "Romeo")
                                                  ("S" . "Sierra") ("T" . "Tango") ("U" . "Uniform") ("V" . "Viktor") ("W" . "Whiskey") ("X" . "X-ray")
                                                  ("Y" . "Yankee") ("Z" . "Zulu") ("0" . "Nadazero") ("1" . "Unaone") ("2" . "Bissotwo") ("3" . "Terrathree")
                                                  ("4" . "Kartefour") ("5" . "Pantafive") ("6" . "Soxisix") ("7" . "Setteseven") ("8" . "Oktoeight") ("9" . "Novenine") ("," . "Decimal") ("." . "Stop"))) 

; Codierungsfunktion zu reversebuchstabiertafel
(define (reversenatoalphabet buchstabe)
 (cdr (assoc buchstabe reversebuchstabiertafel)))

; Buchstabieren eines Textes in Seesprech
(define (text->natoalphabet eingabetext)
(letrec ( [inner (lambda (eingabetext ausgabetext)
                  (if (not (list? eingabetext))
                      (inner (string->list eingabetext) '())
                      (if (empty? eingabetext)
                          (list (reverse ausgabetext))
                          (inner (cdr eingabetext) (cons (reversenatoalphabet (string(car eingabetext))) ausgabetext)))
                      ))]) 
    (inner eingabetext '())))


;;; 2 Das internationale Flaggenalphabet
;;  2.1 Eine Datenstruktur für das Flaggenalphabet
(define flaggentafel '( ("A" . A) ("B" . B)))

;; 2.2 Eine Codierungsfunktion
;  Eingabe des Schlüssels als String
(define (inflaggen schluessel)
  (eval (cdr (assoc schluessel flaggentafel))))

;; Buchstabieren eines Textes
;  Rekursion ist doof!