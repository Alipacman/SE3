#lang racket
#|Blatt 2, Gruppe 8, Mittwoch 10-12 Uhr, Raum G-210, Übungsleiter Rainer Jürgensen
Thomas Hofmann (6764839⁠⁠⁠)
Patricia Häußer (⁠⁠⁠6771401)
Ariana Sliwa (6816391)
|#

;;; Aufgabe 1 - Symbole und Werte, Umgebungen

(define miau 'Plueschi)
(define katze miau)
(define tiger 'miau)

(define (welcherNameGiltWo PersonA PersonB)
  (let ((PersonA 'Sam)
        (PersonC PersonA))
    PersonC))

(define xs1 '(0 2 3 miau katze))
(define xs2 (list miau katze))
(define xs3 (cons katze miau))


; 1. miau: Wird zu 'Plueschi ausgewertet, da die Funktion (define miau) aufgerufen wird.
; 2. katze: Wird zu 'Plueschi ausgewertet, da die Funktion (define katze) miau ausgibt und miau wiederum die Funktion (define miau) aufruft.
; 3. tiger: Wird zu 'miau ausgewertet, da die Funktion (define tiger) aufgerufen wird.
; 4. (quote katze): Gibt 'katze aus, da durch quote ein Apostroph vor die Eingabe eingefügt wird.
; 5. (eval tiger): Gibt 'Plueschi auf. Wenn tiger 
; 6. (eval katze):
; 7. (eval 'tiger):

;;; Aufgabe 2.1
;; Die Funktion natural? prüft, ob die eingegebene Zahl eine natürliche Zahl ist.

(define (natural? n)
  (and (integer? n)
       (>= n 0)))

;; Die Funktion ! berechnet die Fakultät einer eingegebenen Zahl.

(define (! x)
  (if (natural? x)
      (if (= x 0) 1
          (* x (! (- x 1))))
      false))

;;; Aufgabe 2.2

(define (power r n)
  (if (and (rational? r)
           (natural? n))
      (if (= n 0) 1
          (if (even? n)
              (sqr (power r (/ n 2)))
              (* (power r (- n 1)) r)))
      false))

;;; Aufgabe 2.3

(define (eSum x acc)
  (if (>= (/ (+ 1 x) (! x)) (/ 1 (power 10 acc)))
      (+ (/ (+ 1 x) (! x))
         (eSum (+ x 1) acc))
      0))

(define e
  (/ (eSum 0 1000) 2))

;;; Aufgabe 3

(define (type-of x)
  (cond [(boolean? x) 'boolean]
        [(list? x) 'list]
        [(pair? x) 'pair]
        [(symbol? x) 'symbol]
        [(number? x) 'number]
        [(char? x) 'char]
        [(string? x) 'string]
        [(vector? x) 'vector]
        [(procedure? x) 'procedure]
        [else "Type not defined"]))

(define (id z) z)

#|
Erläuterungen noch ausführlicher auskommentieren

> (type-of  (* 2 3 4))
'number
> (type-of (not 42))
'boolean
> (type-of '(eins zwei drei))      
'pair
> (type-of '())
'list
> (type-of (id sin))
'procedure
> (type-of (string-ref "Harry_Potter_und_der_Stein_der_Weisen" 3))
'char
> (type-of (lambda (x) x))
'procedure
> (type-of type-of)
'procedure
> (type-of (type-of type-of))
'symbol
|#