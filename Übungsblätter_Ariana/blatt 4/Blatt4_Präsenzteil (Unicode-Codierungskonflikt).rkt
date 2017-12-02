#lang racket
(require se3-bib/tools-module)

(define liste '(1 2 3))

;Mit car das erste Element nehmen. Mit cons an die Liste ranhängen. Cdr nutzen, um den Rest der Liste weiter rekursiv zu bearbeiten
;(define (addOne liste)
;  (letrec [(innere (lambda (in out)
;                   (if (empty? in)
;                      (reverse out))
;                     (innere (cdr in) (cons (+ 1 (car in)) out))))])
;(innere liste '()))

(define (addOne2 liste)
  (if (empty? liste)
      '()
      (cons (+ 1 (car liste) (addOne2 (cdr liste))))))

(define (bestellung firma straße ort absender)
  (display (string-append (anschrift firma straße ort) "\n"
                 (anrede firma) "\n"
                 (artikel) "\n"
                 (schluss absender))))
(define (anschrift firma straße ort)
  (string-append firma "\n"
                 straße "\n"
                 ort))
(define (anrede firma)
  (string-append "Sehr geehrte DAmen und Herren der Firma " firma
                 "\nHiermit möchte ich folgendes bestellen:"))
(define (artikel)
  (if (= (random 2) 0)
  (string-append (produkt) " " (artikel))
  (produkt)))
(define produktliste '("Tastatur" "Maus" "USB-Stick"))
(define (produkt)
  (car (one-of produktliste)))
(define (schluss absender)
  (string-append "Mit freundlichen Grüßen " absender))