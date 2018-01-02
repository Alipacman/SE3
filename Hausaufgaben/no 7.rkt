#lang racket

(require 2htdp/image)

;Aufg 1


;List to check
(define list_test '(2 3 4 5 6 75 3 2 3) )


;allgemein Rekursiv

(define (rek-count_lst num lst)
  (if (eq? lst '()) 0
      (if (eq? (car lst) num)
          (+ 1 (rek-count_lst num (cdr lst)))
          (rek-count_lst num (cdr lst)))                        
      ))


;endrekursive Funktion

(define (endrek-count_lst num lst acc)
  (if (eq? lst '()) acc
      (if (eq? (car lst) num)
          (endrek-count_lst num (cdr lst) (+ 1 acc))
          (endrek-count_lst num (cdr lst) acc)                        
          ))
  )


;mittels geeigneter Funktionen höherer Ordnung


(define (higher-func-count_lst num lst)
  (foldl + 0 (map (lambda (x)
           (if (eq? x num) 1 0)) lst
   )))

;check the test list for how many times number 3 comes
(rek-count_lst 3 list_test)
(endrek-count_lst 3 list_test 0)
(higher-func-count_lst 2 list_test)


;Aufg 2

;2.1
#|
Als Datenstruktur für unsere Spiel des Lebens verwenden wir Listen. Es gibt eine Hauptliste die einzelne Unterlisten besitzt.
Die Unterlisten stehen jeweils für einzelne Pixel, wobei jede Unterliste zwei Werte speichert.
Einmal die Nummer des Pixels im Canvas und einmal ob der Pixel gezündet ist oder nicht.
Dadurch dass wir Unterlisten besitzen und der erste Wert für die Pixelnummer steht, können wir mit Hilfe der assoc funktion auf die Unterliste zugreifen
und den zweiten Wert auslesen, welcher als #t #f oder als 1 oder 0 dafür stehen könnte ob der Pixel angezündet ist oder nicht.
Da wir außerdem wissen wie groß unser Canvas ist, können wir auf die benachbarten Pixel zugreifen
, indem wir für den Pixel über einem anderen die breite von der Nummer des Pixels abziehen.
Für den Pixel rechts diagonal unter eines anderen müssten wir dann nur die breite + 1 auf die Nummer den Pixels addieren.
Weitere fälle sind analog dazu.
Um die einzelenen Pixel aufs Canvas abzubilden, können wir mit Hilfe von der Canvasgröße die Pixelnummern aus der Liste rauslesen
und mit Hilfe von Modulo auf die verschiedenen Reihen abbilden.
|#


; Hilfsfunktion um random Wert zu erhalten
;TODO gibt aus irgendeinemgrund nur false aus
(define random-tf
  (list-ref  '(#t #f)
             (random 2)))

;generiert für gegebene Pixelnummer, ob Pixel lebendig oder nicht
(define (make-pixel-pair num)
  (list num random-tf)
   )

;generiert Pixelpaare nach Eingabe. Bei einem Spielfeld von 30 würde die Funktion 30 Paare generieren
;TODO Unterlisten sind geschachtelt anstatt eigene Listen :(
(define (generate-pixel-pairs num)
  (if (> num 1)
  (list (make-pixel-pair num) (generate-pixel-pairs (- num 1)))
  (list (make-pixel-pair num))
   )
  )





;2.2
; mit (build-rows-from-bottum 30 30) kann die Test Szene aufgerufen werden
; TODO bis jetzt ist die Testszene nicht random generiert, weil die funktionen aus 2.1 nicht funktionieren :D

(define alive-cell (square 10 "solid" "black"))
(define (costom-alive-cell x) (square x "solid" "black"))

(define dead-cell (square 10 "outline" "black"))
(define (costom-dead-cell x) (square x "oultine" "black"))

(define (create-row width)
  (if (> width 1)
       (beside dead-cell (create-row (- width 1)))
  alive-cell
  ))

(define (build-rows-from-bottum width height)
  (if (> height 1)
      (above (create-row width) (build-rows-from-bottum width (- height 1)))
  (create-row width)
   ))

(build-rows-from-bottum 30 30)







