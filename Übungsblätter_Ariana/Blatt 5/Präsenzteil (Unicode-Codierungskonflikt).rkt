#lang racket
(require se3-bib/butterfly-module)
(require 2htdp/image)

(show-butterfly 'red 'stripes ' curved 'rhomb)
(show-butterfly 'green 'stripes 'straight 'hexagon)

(apply + '(1 2 3))

; member gibt den Rest der Liste ab dem Member an, #f wenn element nicht in liste

(scale 0.5 (show-butterfly 'green 'stripes 'curly 'rhomb))

(beside (show-butterfly 'red 'stripes ' curved 'rhomb)
        (show-butterfly 'green 'stripes 'straight 'hexagon))


; (mittelwert-l '(2 2 4 4))

(define liste '(2 2 4 4))

(define (mittelwert-1 ls)
  (letrec ([mitrec (lambda (restListe summe counter)
                     (if (empty? restListe)
                         (/ summe counter)
                         (mitrec (cdr restListe) (+ summe (car restListe)) (+ counter 1))))])
    (mitrec ls 0 0))) ; --> Aufruf der inneren Funktion mit Startparameter


(define (mittelwert-2 ls)
  (letrec ([sum (lambda (restListe)
                  (if (empty? restListe)
                      0
                      (+ (car restListe) (sum (cdr restListe)))))]
           [length1 (lambda (restListe)
                     (if (empty? restListe)
                         0
                         (+ 1 (length1 (cdr restListe)))))])
    (/ (sum ls) (length1 ls))))
