#lang racket
(require se3-bib/setkarten-module)


;;; 1 Funktionen höherer Ordnung und Closures

;;  1. Wann ist eine Racket-Funktion eine Funktion höhrer Ordnung?
;;  Wenn sie als Argument eine Funktion erhalten oder als Wert zurückgeben.

;;  2. Welche der folgenden Funktionen sind Funktionen höherer Ordnung?

;;  (a) foldr
;;  foldr ist eine Funktion höherer Ordnung, da sie als Argument einen Operator übergeben bekommt.

;;  (b) (define (plus-oder-minus x)
;;           (if (< x 0)
;;                  'Plus     ; PLus und Minus müssten eigentlich getauscht werden
;;                  'Minus))
;;
;;  Dies ist keine Funktion höherer Ordnung, da keine Funktion als Argument übergeben wird und auch keine Funktion als Wert zurückgegeben wird.

;;  (c) (define (masala f arg1)
;;          (lambda (arg2)
;;               (f arg1 arg2)))
;;
;;  masala ist eine Funktion höherer Ordnung, da sie als Argument einen Operator übergeben bekommt.

;;  (d) (define (flip f)
;;           (lambda (x y) (f y x)))

;;  3. tbd.

;;  4. 
;;  (foldl (curry * 3) 1 '(1 2 3))
;;  -> 162
;;  Begründung: Indem foldl als Argument die Funktion (curry * 3) übergeben wird, wird jedes Element der Liste erst mit 3 multipliziert,
;;  bevor diese Ergebnisse wiederum mit sich selbst multipliziert werden. (3 * 6 * 9 = 162)

;;  (map (flip cons) '(1 2 3) '(3 2 1)) 
;;  '((3 . 1) (2 . 2) (1 . 3))
;;  Begründung: tbd.

;;  (map (compose (curryr / 1.8) (curry - 32))
;;          '(9941 212 32 -469.67))
;;  '(-5505.0 -100.0 0 278.7055555555556)
;;  Begründung: Compose wendet jede Funktion, die über Curry übergeben wurden, beginnend bei der letzten, auf die Liste an. Über map wird sie auf jedes Element der Liste angewandt. Erst werden von
;;  jedem Element der Liste 32 abgezogen, dann durch 1.8 geteilt
;;  TBD -> Warum ist die Zahl negativ???? TBD


;;; 2 Einfache funktionale Ausdrücke höherer Ordnung

(define xs '(-1 -2 -10 -13 1 2 3 4 5 6 12 13 14 20 26 30 39))

;;  1. Berechnet den Absolutbetrag aller Zahlen in der Liste
(foldr + 0 xs)

;; 2. Geben Sie einen Ausdruck an, der die Teilliste aller glatt durch 13 teilbaren Zahlen von xs konstruiert.
(map (curry * 13)(filter integer? (map (curryr / 13) xs)))

;; 3. Geben Sie einen Ausdruck an, der die Summe der geraden Zahlen größer 3 in xs ermittelt.
(foldl + 0 (filter positive? (filter even? (remove* '(0 1 2 3) (sort xs <)))))

;;; 3 Spieltheorie: Das Kartenspiel SET!

;;  3.1

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


