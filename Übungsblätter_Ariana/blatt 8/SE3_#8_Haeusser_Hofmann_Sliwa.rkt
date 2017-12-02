#lang racket
(require se3-bib/setkarten-module)

#|
Blatt 8, Gruppe 8, Mittwoch 10-12 Uhr, Raum G-210, Übungsleiter Rainer Jürgensen
Thomas Hofmann (6764839⁠⁠⁠)
Patricia Häußer (⁠⁠⁠6771401)
Ariana Sliwa (6816391)
|#

;;; 1 Funktionen höherer Ordnung und Closures

;;  1.1 Wann ist eine Racket-Funktion eine Funktion höherer Ordnung?
;   Wenn sie als Argument eine Funktion erhalten oder als Wert zurückgeben.

;;  1.2 Welche der folgenden Funktionen sind Funktionen höherer Ordnung?

;  (a) foldr
;  foldr ist eine Funktion höherer Ordnung, da sie als Argument einen Operator übergeben bekommt, der eine Funktion darstellt.

;  (b) (define (plus-oder-minus x)
;           (if (< x 0)
;                  'Plus     ; Plus und Minus müssten eigentlich getauscht werden
;                  'Minus))
;
;  plus-oder-minus ist keine Funktion höherer Ordnung, da sie als Argument lediglich eine Zahl erhalten kann (da nur eine Zahl in die if-Bedingung eingesetzt werden kann)
;  und als Rückgabewert nur ein Symbol ('Plus oder 'Minus) herausgegeben wird.

;  (c) (define (masala f arg1)
;          (lambda (arg2)
;               (f arg1 arg2)))
;
;  masala ist eine Funktion höherer Ordnung, da sie als Argument die Funktion f (einen Operator) übergeben bekommt.

;  (d) (define (flip f)
;          (lambda (x y) (f y x)))
;
;  flip ist eine Funktion höherer Ordnung, da sie die Funktion f (einen Operator) als Argument übergeben.

;;  1.3
;   Zunächst wird der Operator / an das Argument f gebunden und die Zahl 1 an das Argument arg1. Dann wird die Zahl 3 an das Argument arg2 der inneren Funktion gebunden.
;   Bei der Ausführung des Aufrufes wird nun folgendes ausgewertet: (f arg1 arg2) und damit durch die Bindungen der Argumente (/ 1 3).
;   Als Ergebnis folgt darauf 1/3.
;   In Racket lassen sich Zahlen und Listen durch Closures repräsentieren.
;   Man könnte an Stelle der Zahl 1/3 auch den Aufruf ((masala / 1) 3) schreiben, da es sich hier um ein Closure handelt.
  
;;  1.4 
;  (foldl (curry * 3) 1 '(1 2 3))
;  -> 162
;  Begründung: Indem foldl als Argument die Funktion (curry * 3) übergeben wird, wird jedes Element der Liste erst mit 3 multipliziert,
;  bevor alle Elemente (von links nach rechts) miteinander multipliziert werden. (3 * 6 * 9 = 162)

;  (map (flip cons) '(1 2 3) '(3 2 1)) 
;  -> '((3 . 1) (2 . 2) (1 . 3))
;  Begründung: Durch map wird aus je dem ersten, zweiten und dritten Elementen der beiden Listen  in der flip-Funktion durch die cons-Anweisung ein Pair gebaut.

;  (map (compose (curryr / 1.8) (curry - 32))
;          '(9941 212 32 -469.67))
;  '(-5505.0 -100.0 0 278.7055555555556)
;  Begründung: Compose wendet jede Funktion, die über Curry übergeben wurden, beginnend bei der letzten, auf die Liste an. Über map wird sie auf jedes Element der Liste angewandt. Erst wird
;  jedes Element der Liste von 32 abgezogen, das Ergebnis wird dann durch 1.8 geteilt


;;; 2 Einfache funktionale Ausdrücke höherer Ordnung

(define xs '(-1 -2 -10 -13 1 2 3 4 5 6 12 13 14 20 26 30 39))

;;  2.1 Geben Sie einen Ausdruck an, der die Liste der Absolutbeträge aller Zahlen der Liste xs berechnet

(map abs xs)
; -> '(1 2 10 13 1 2 3 4 5 6 12 13 14 20 26 30 39)

;; 2.2 Geben Sie einen Ausdruck an, der die Teilliste aller glatt durch 13 teilbaren Zahlen von xs konstruiert.
(map (curry * 13)(filter integer? (map (curryr / 13) xs)))
; -> '(-13 13 26 39)

;; 2.3 Geben Sie einen Ausdruck an, der die Summe der geraden Zahlen größer 3 in xs ermittelt.
(foldl + 0 (filter positive? (filter even? (filter (curry < 3) xs))))
; -> 112

;; 2.4 Geben Sie einen Ausdruck an, welcher eine Liste anhand eines Prädikats (z.B. odd?) in zwei Teillisten aufspaltet und zurückgibt.
(partition odd? xs)

;;; 3 Spieltheorie: Das Kartenspiel SET!

;;  3.1
;   Entwerfen und implementieren Sie die Repräsentation der verfügbaren Ausprägungen einer Spielkarte, und bedenken Sie dabei bereits die folgenden Schritte
;   (z.B. dass sich Funktionen höherer Ordnung leich- ter auf Listen als auf andere Strukturen anwenden lassen). Fahren Sie anschließend mit der Repräsentation einer Spielkarte fort.

(define n '(1 2 3))
(define the-pattern '(waves oval rectangle))
(define the-mode '(outline solid hatched))
(define the-color '(red green blue))

(define attributes '(n the-pattern the-mode the-color))

(define (card n the-pattern the-mode the-color)
  (list n the-pattern the-mode the-color))

;(card 2 'waves 'outline 'red)

;;  3.2
(define (card-deck)
  (for*/list ([i n]
         [j the-pattern]
         [k the-mode]
         [l the-color])
    (append (list i j k l))))

(define (visualize-deck)
  (for*/list ([i n]
         [j the-pattern]
         [k the-mode]
         [l the-color])
    (show-set-card i j k l)))

;; 3.3

;; prüft ob alle Elemente einer Liste equal sind.
(define (equal-list list1)
      (if (equal? (length(remove-duplicates list1)) 1)
          #t
          #f))

;; prüft ob kein Element gleich ist.
(define (no-equals list1)
      (if (equal? (check-duplicates list1) #f)
          #t
          #f))

;;Nutzt die beiden oberen Funktionen um 3 Karten auf ein Set zu überprüfen. 
(define (is-this-set? liste)
  (if (= 3 (length liste))
      (if (> 1 (length (car liste)))
          #t
          (and (or (no-equals (map car liste)) (equal-list (map car liste)))
               (is-this-set? (map cdr liste))))
      #f))

;; 3.4


(define (mischedDeck)
  (shuffle (card-deck)))

(define (get-12)
  (take (mischedDeck) 12))

(define (erstelleKarte karte)
   (apply show-set-card karte)
   )

(define (zeichne12)
  (map erstelleKarte (get-12)))

(zeichne12)

 (define (tripel)
   (remove-duplicates (map (curry take 3) (permutations (get-12)))))




