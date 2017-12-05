#lang racket
(require se3-bib/butterfly-module)


;Aufgb 1.1

#|
1.
Als Datenstruktur für einzelnde Attribute benutzen wir Listen, wobei immer das Dominante und das Rezzesive Gen abgespeichert sind.
Auf Dominanz können wir dann mit einer Funktion vergleichen, und da pro Liste nur zwei Attribute enthalten sind können wir die Liste so sortieren
, dass das vordere Element das Dominante ist .
Rezessive Gene können wir auch durch eine Funktion bestimmen die als Eingabe ein Gen bekommt und zufällig
ein mögliches rezessives Gen ausgibt.

2.
Wir Implementieren jeden Schmetterling als eine Liste mit Unterlisten für die einzelnden Attribute
, wobei das dominante Gen immer vorne steht und das rezessive hinten.
Dann kann einfach auf die Liste zugegriffen werden und abgefragt werden auf 


3.
Unserer Hauptfunktion sollen drei Parameter übergeben werden:
1. die Anzahl der gewünschten Kinder
2. die dominanten Merkmale des Vaters
3. die dominanten Merkmale der Mutter

Mit Hilfe einer Funktion werden die Merkmale der Eltern in eine Liste gegeben mit jeweiligen Unterlisten für jedes Merkmal. Dabei wird zufällig
bei jedem Merkmal das dominante oder das rezessive Merkmal ausgewählt von den Elternteilen.
Danach werden die Merkmale analisiert, so dass das dominante Merkmal in einer neue Liste geschrieben wird.
Danach wird über die Liste iteratiert und die Merkmale so sortiert, dass die dominanten vorne stehen in den einzelenen Unterlisten.
Beim visuellen darstellen eines Schmetterlings werden dann nur die dominanten bzw vorne stehenden Merkmale übergeben.
|#

;Aufgb 1.2

;1.2.1

;Gibt für ein Merkmal ein mögliches rezzesives Gen zurück. Funktionen Aufgeteilt in die 4 Merkmalsarten
;, aber auch möglich in einer Funktion mit einem conditional.

(define (random-rez-pattern x) 
  (cond 
    [(eq? x 'star) (random-of x 'dots 'stripes 'nil 3)]
    [(eq? x 'dots) (random-of x 'stripes 'nil 'nil 2)]
    [(eq? x 'stripes) x]
    ))
(define (random-rez-color x) 
  (cond 
    [(eq? x 'blue) (random-of x 'green 'yellow 'red 4)]
    [(eq? x 'green) (random-of x 'yellow 'red 'nil 3)]
    [(eq? x 'yellow) (random-of x 'red 'nil 'nil 2)]
    [(eq? x 'red) x]
    ))

(define (random-rez-sensor x) 
  (cond 
    [(eq? x 'curved) (random-of x 'curly 'straight 'nil 3)]
    [(eq? x 'curly) (random-of x 'straight 'nil 'nil 2)]
    [(eq? x 'straight) x]
    ))

(define (random-rez-wings x) 
  (cond 
    [(eq? x 'ellipse) (random-of x 'rhomb 'hexagon 'nil 3)]
    [(eq? x 'rhomb) (random-of x 'hexagon 'nil 'nil 2)]
    [(eq? x 'hexagon) x]
    ))



; Hilfsfunktion um random Wert zu erhalten
(define (random-of v w x y z )
  (list-ref  (list v w x y)
             (random z)))


(define pattern-order '(star dots stripes))
(define color-order '(blue green yellow red))
(define sensor-order '(curved curly straight))
(define wings-order '(ellipse rhomb hexagon))

  
;1.2.2 Funktionen um domminantes Merkmal zu bestimmen

(define (give-dominant-pattern x)
  (if (memq (cadr x) (memq (car x) pattern-order))
      (car x)(cadr x)
      ))

(define (give-dominant-color x)
  (if (memq (cadr x) (memq (car x) color-order))
      (car x)(cadr x)
      ))

(define (give-dominant-sensor x)
  (if (memq (cadr x) (memq (car x) sensor-order))
      (car x)(cadr x)
      ))

(define (give-dominant-wings x)
  (if (memq (cadr x) (memq (car x) wings-order))
      (car x)(cadr x)
      ))


;1.2.3 erzeugt eine Liste mit den gegebenen dominanten Merkmalen und generiert passende rezesive Merkmale

(define (make-butterfly color pattern sensor wings) 
                                                     (list (list color (random-rez-color color)) (list pattern (random-rez-pattern pattern))
                                                           (list sensor (random-rez-sensor sensor)) (list wings (random-rez-wings wings)))
                                                     )
                                                     
;1.2.4 Akzessoren zu den dominanten Merkmalen
(define (get-dom-color b) (cond
                            [(assoc 'red b)'red]
                            [(assoc 'blue b)'blue]
                            [(assoc 'green b)'green]
                            [(assoc 'yellow b)'yellow]
                            )

  )

(define (get-dom-pattern b) (cond
                            [(assoc 'star b)'star]
                            [(assoc 'dots b)'dots]
                            [(assoc 'stripes b)'stripes]
                            )

  )

(define (get-dom-sensor b) (cond
                            [(assoc 'curved b)'curved]
                            [(assoc 'curly b)'curly]
                            [(assoc 'straight b)'straight]
                            )

  )

(define (get-dom-wings b) (cond
                            [(assoc 'hexagon b)'hexagon]
                            [(assoc 'rhomb b)'rhomb]
                            [(assoc 'ellipse b)'ellipse]
                            )

  )

;1.2.5 Zeigt Schmetterlin an


(define (draw-butterfly b) (show-butterfly (get-dom-color b) (get-dom-pattern b) (get-dom-sensor b) (get-dom-wings b)
                            ))





;1.2.6

                        




(define (get-values l) (cond
                         [(not(equal? l '())) ((caar l) (get-values (cdr l)))]
                         ))

#|

(define (give-child-list a b anzahl) 
                                      ((make-butterfly (car a) (make-butterfly a)
                                      ))

|#


;Fügt zwei Eltern zu einer Liste mit Attributen als paar
(define (make-list x y) (list
                         (list (car x)(car y))
                         (list (cadr x) (cadr y))
                         (list (caddr x) (caddr y))
                         (list (cadddr x) (cadddr y))
                         ))

(list 'red 'star 'curly 'hexagon)
(list 'green 'dots 'curved 'rhomb)


(make-list '(red star curly hexagon) '(green dots curved rhomb))
