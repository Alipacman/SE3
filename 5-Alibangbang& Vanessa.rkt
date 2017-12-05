#lang racket
(require se3-bib/butterfly-module)

;Aufgb 1.1

#|
1.
Als Datenstruktur für einzelnde Attribute benutzen wir Listen, wobei immer das Dominante und das Rezzesive Gen abgespeichert sind.
Auf Dominanz können wir dann mit einer Funktion vergleichen, und da pro Liste nur zwei Attribute enthalten sind können wir die Liste so sortieren
, dass das vordere Element das Dominante ist.
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
(4. Akkumulator falls Endrekursion implementiert wird)

Mit Hilfe einer Funktion werden die Merkmale der Eltern in eine Liste gegeben mit jeweiligen Unterlisten für jedes Merkmal. Dabei wird zufällig
bei jedem Merkmal das dominante oder das rezessive Merkmal ausgewählt von den Elternteilen.
Danach werden die Merkmale analisiert, so dass das die dominanten Merkmale in einer neuen Liste hinzugefügt werden, welche dann das Kind ist.
Beim visuellen darstellen eines Schmetterlings werden dann nur die dominanten bzw vorne stehenden Merkmale übergeben.
|#

;; Aufgabe 1.2

; Eltern müssen die folgende Form haben:
;(define mother '(flügelfarbe musterung fühlerform flügelform))

; Sortierte Liste der einzelnen Attribute
(define flügelfarbe '(blue green yellow red))

(define musterung '(star dots stripes))

(define fühlerform '(curly curved straight))

(define flügelform '(ellipse rhomb hexagon))

; Funktion, die eine Liste aller möglichen Ausprägungen eines Attributs für die Kinder ausgibt, wenn ein bestimmtes dominantes Merkmal bei den Eltern vorliegt
(define (attr-list list dom-attr)
  (if (equal? (car list) dom-attr)
      list
      (attr-list (cdr list) dom-attr)))

; Funktion, die ein beliebiges Element aus einer Liste wählt
(define (choose-attr list)
  (list-ref list (random (length list))))

; Funktion, die eine Liste mit dem dominanten Merkmal des Kindes an erster Stelle und dem rezessiven an zweiter Stelle zurück gibt
(define (sorted-attr-list liste attr-mother attr-father)
  (if (> (index-of liste attr-mother) (index-of liste attr-father))
      (list attr-father attr-mother)
      (list attr-mother attr-father)))

; Hilfsfunktion, die die vorherigen Funktionen kombiniert
(define (child-help attr index mother father)
  (sorted-attr-list attr (choose-attr (attr-list attr (list-ref mother index))) (choose-attr (attr-list attr (list-ref father index)))))

; Funktion, die ein zufällig generiertes Kind zweier Schmetterlinge erzeugt
(define (child mother father)
  (list (child-help flügelfarbe 0 mother father)
        (child-help musterung 1 mother father)
        (child-help fühlerform 2 mother father)
        (child-help flügelform 3 mother father)))

; Funktion, die das dominante/rezessive Merkmal eines Kindes für ein bestimmtes Attribut zurückgibt
(define (find-attr-child child attr d-r)
  (let ([x (index-of '(flügelfarbe musterung fühlerform flügelform) attr)]
        [y (index-of '(dominant rezessiv) d-r)])
  (list-ref (list-ref child x) y)))

; Funktion, die ein Schmetterlingskind abbildet
(define (print-child child)
  (show-butterfly (find-attr-child child 'flügelfarbe 'dominant)
                  (find-attr-child child 'musterung 'dominant)
                  (find-attr-child child 'fühlerform 'dominant)
                  (find-attr-child child 'flügelform 'dominant)))

; Funktion, die eine Liste mit möglichen Kindern zweier Eltern generiert
(define (generate-children mother father nr-children [acc '()])
  (if (> nr-children 0)
      (generate-children mother father (- nr-children 1) (cons (child mother father) acc))
      acc))

; Funktion, die eine Liste von Schmetterlingskindern textuell und visuell darstellt
(define (print-children liste [acc '()])
  (writeln (car liste))
  (if (> (length liste) 1)
      (print-children (cdr liste) (cons (print-child (car liste)) acc))
      (cons (print-child (car liste)) acc)))

; Testen der Funktionen aus Aufgabenteil 1.2

; 1.2.1 Finde alle rezessiven Merkmale zu einem dominanten Merkmal. Wähle das erste und letzte Element in der Liste zum Testen:
; Beziehungsweise, diese Funktion gibt alle rezessiven sowie das dominante Merkmal zurück, da das für unsere Implementation sinnvoller ist
(attr-list flügelfarbe 'blue)
(attr-list flügelfarbe 'red)

; 1.2.2 Vergleich zwei Merkmale auf Dominanz
; Beziehungsweise, diese Funktion gibt eine Liste zurück, in der das dominante Merkmal an erster und das rezessive an zweiter Stelle steht, da das für unsere Implementation sinnvoller ist
(sorted-attr-list flügelfarbe 'blue 'red)

; 1.2.3 Erzeugen eines Schmetterlings anhand dominanter und rezessiver Merkmale seiner Eltern
; In dieser Funktion werden nur die dominanten Merkmale der Eltern mitgegeben und die rezessiven berechnet
; Für die Testdaten, habe ich je Attribut mal gleiche Daten für beide Eltern, mal unterschiedliche, mal die ersten in der Rangordnungsliste und mal die letzten genutzt
(define kind (child '(blue dots straight ellipse) '(red dots straight rhomb)))
(writeln kind)

; 1.2.4 Abfrage aller sichtbaren und unsichtbaren Merkmale eines Schmetterlings
; Hier nehmen wir als Testdaten den Schmetterling, der im letzten Test erzeugt wurde und fragen einmal ein dominantes und einmal ein rezessives Merkmal ab
(find-attr-child kind 'musterung 'dominant)
(find-attr-child kind 'flügelform 'rezessiv)

; 1.2.5 Zeichnen der sichtbaren Merkmale eines Schmetterlings als Bild
; Hier nehmen wir wieder den eben erzeugten Schmetterling
(print-child kind)

; 1.2.6 Generieren einer Liste von möglichen Schmetterlingskindern
; Hier nehmen wir wieder die Eltern aus 1.2.3 als Testdaten
(define liste-kinder (generate-children '(blue dots straight ellipse) '(red dots straight rhomb) 5))
(writeln liste-kinder)

; 1.2.7 Darstellen einer Liste von Kindern
; Hier nehmen wir die im vorherigen Aufgabenteil erzeugte Liste als Testdaten
(print-children liste-kinder)

;; Aufgabe 2

; Parents:
(define mariposa '(red stripes curved hexagon))
(define papillon '(yellow star curly rhomb))

; Children:
(define papallona '(blue star curved hexagon))
(define farfalla '(green dots straight rhomb))
(define alibangbang '(yellow stripes curly ellipse))
; Die Kinder stammen alle nicht von den angeblichen Eltern ab

; Testkind, dass von beiden Eltern abstammen kann
(define test '(red stripes curved hexagon))

; Funktion, die testet, ob ein Kind von den zugehörigen Eltern abstammt oder nicht
(define (vaterschaftstest child mother father [attr '(flügelfarbe musterung fühlerform flügelform)])
  (let* ([index-child (index-of (eval (list-ref attr 0)) (list-ref child 0))]
        [index-mother (index-of (eval (list-ref attr 0)) (list-ref mother 0))]
        [index-father (index-of (eval (list-ref attr 0)) (list-ref father 0))]
        [true (and (>= index-child index-mother) (>= index-child index-father))])
    (if true
        (if (> (length child) 1) ; problem mit pair
            (vaterschaftstest (cdr child) (cdr mother) (cdr father) (cdr attr))
            true)
        #f)))


