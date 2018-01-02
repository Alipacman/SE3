#lang racket

(require 2htdp/image)
(require 2htdp/universe)

;Aufg 1

; allgemein rekursiv
(define (zaehlen x xs)
  (cond
    [(empty? xs) 0]
    [(equal? (car xs) x)  (+ 1 (zaehlen x (cdr xs)))]
    [else (zaehlen x (cdr xs))]))

; end-rekursiv
(define (zaehlen2 x xs [acc 0])
  (cond
    [(empty? xs) acc]
    [(equal? (car xs) x)  (zaehlen2 x (cdr xs) (+ acc 1))]
    [else (zaehlen2 x (cdr xs) acc)]))

; Funktionen höherer Ordnung
(define (zaehlen3 x xs)
  (length (filter ((curry equal?) x) xs)))
  
;Version 2
(define (higher-func-count_lst num lst)
  (foldl + 0 (map (lambda (x)
                    (if (eq? x num) 1 0)) lst
                                          )))

;List to check
(define list_test '(2 3 4 5 6 75 3 2 3) )

;check the test list for how many times number 3 comes
(zaehlen 3 list_test)
(zaehlen2 3 list_test 0)
(zaehlen3 3 list_test)


;Aufg 2

;2.1
#|
Als Datenstruktur für unsere Spiel des Lebens verwenden wir Listen. Es gibt eine Hauptliste die einzelne Unterlisten besitzt.
Die Unterlisten stehen jeweils für einzelne Zeilen, wobei jede Unterliste die Werte der Zeile speichert, ob die Pixel in einer Zeile gezündet sind oder nicht.

Wir schreiben eine Funktion, welche mit Hilfe vom Index (x,y) rausgibt welchen Wert ein bestimmter Zelle hat,
wobei #t #f dafür stehen könnte ob der Zelle angezündet ist oder nicht.
Wir können auf die benachbarten Zelle zugreifen, indem wir zum Beispiel für den Zelle über einem den Index y + 1 in unserer Funktion eingeben.
Für den Zelle rechts diagonal unter einem  müssen wir dann nur den x Index + 1 auf die Nummer den Zelle addieren und den y -1.
Weitere fälle sind analog dazu.

Um die einzelenen Zelle abzubilden, können wir jeweils durch die einzelnen Unterlisten (wobei jede Unterliste für eine Reihe steht)
durchgehen und jeh nach Werten die Reihen mit beside abbilden und mit der above Funktion unseren Spielzustand von unten nach oben aufbauen.
|#

;; Aufgabe 2.2
(require 2htdp/image)

; möglicher Startzustand

;buildlist example:
(define (integer->boolean i)
  (case i
    ((1) #f)
    ((2) #t)))

(define (random-field num) (build-list num (lambda (x) (build-list num (lambda (y) (integer->boolean (random 1 3)))))))

; Bild einer lebenden Zelle
(define (living-cell)
  (rectangle 10 10 "solid" "black"))

; Bild einer toten Zelle
(define (dead-cell)
  (rectangle 9 9 "outline" "black"))

; Hilfsfunktion die den true und false Werten, das Bild einer lebenden oder toten Zelle übergibt
(define (boolean->bild x)
  (if x
      (living-cell)
      (dead-cell)))

; Visualisierung des Spielzustands
(define (playing-field x [acc (rectangle 0 0 "solid" "black")])
  (let ([field (above acc (apply beside (map boolean->bild (car x))))])
    (if (empty? (cdr x))
        field
        (playing-field (cdr x) field))))

;; Aufgabe 2.3
; Funktion die Wert eines Pixels gibt und wenns außerhalb ist false zurück gibt
(define (value-of-loc lst x y)
  (cond
    [(and (<= 0 y (-(length lst) 1)) (<= 0 x (-(length lst) 1)))
          (list-ref (list-ref lst x) y)]
    [else #f])) 

; gibt den Zustand der Nachbarn einer Zelle als Liste aus
(define (neighbours x y lst)
  (let ([y-values (list (- y 1) y (+ y 1))])
    (append
     (map (curry value-of-loc lst (- x 1)) y-values)
     (map (curry value-of-loc lst x) (list  (- y 1) (+ y 1)))
     (map (curry value-of-loc lst (+ x 1)) y-values))))

;Gibt für eine Zelle den nächsten Zustand an
(define (next-cellstate lst x y)
  (let ([anzahl (zaehlen3 #t (neighbours x y lst))]
        [cellstate (value-of-loc lst x y)])
  (cond [(or (and cellstate (equal? anzahl 2)) (equal? anzahl 3)) #t]
        [else #f])))



; gibt Spielfeld zum Zeitpunkt t+1 aus
(define (generate-new-state current-state [y 0] [acc '()])
  (if (< y (length current-state))
      (generate-new-state current-state (+ y 1)
                          (cons (map (curry next-cellstate current-state y) (range (length current-state))) acc))
      (reverse acc)))


;2.4
;animiert unser Game

(define (game-of-life field tick)
  (big-bang field
    (on-tick generate-new-state tick)
    (to-draw playing-field)))

;Eig mit 4 aber 0.2 sieht besser aus
(game-of-life (random-field 30) 0.2)


  