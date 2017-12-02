#lang racket
(require se3-bib/butterfly-module)


;Aufgb 1.1

#|

Die zwei Eltern Listen werden zu einer
Kind als Liste in abhängigkeit von dominanz

i)
Unserer Hauptfunktion sollen drei Parameter übergeben werden:
1. die Anzahl der gewünschten Kinder
3. die dominanten Merkmale des Vaters
5. die dominanten Merkmale der Mutter
|#


;Fügt zwei Eltern zu einer Liste mit Attributen als paar
(define (make-list x y) (list
                         (cons(car x)(car y))
                         (cons (cadr x) (cadr y))
                         (cons (caddr x) (caddr y))
                         (cons (cadddr x) (cadddr y))
  ))

(list 'red 'star 'curly 'hexagon)
(list 'green 'dots 'curved 'rhomb)

(make-list '(red star curly hexagon) '(green dots curved rhomb))


(define (random-rez-pattern x) (
                             (cond 
                                    [(eq? x 'star) (random-of x 'dots 'stripes 'nil 3)]
                                    [(eq? x 'dots) (random-of x 'stripes 'nil 'nil 2)]
                                    [(eq? x 'stripes) (x)]
                                    )))
(define (random-rez-color x) (
                             (cond 
                                    [(eq? x 'blue) (random-of x 'green 'yellow 'red 4)]
                                    [(eq? x 'green) (random-of x 'yellow 'red 'nil 3)]
                                    [(eq? x 'yellow) (random-of x 'red 'nil 'nil 2)]
                                    [(eq? x 'red) (x)]
                                    )))

(define (random-rez-sensor x) (
                             (cond 
                                    [(eq? x 'curved) (random-of x 'curly 'straight 'nil 3)]
                                    [(eq? x 'curly) (random-of x 'straight 'nil 'nil 2)]
                                    [(eq? x 'straight) (x)]
                                    )))

(define (random-rez-wings x) (
                             (cond 
                                    [(eq? x 'ellipse) (random-of x 'rhomb 'hexagon 'nil 3)]
                                    [(eq? x 'rhomb) (random-of x 'hexagon 'nil 'nil 2)]
                                    [(eq? x 'hexagon) (x)]
                                    )))




     
; Hilfsfunktion um random Wert zu erhalten
(define (random-of v w x y z )
 (list-ref  (list v w x y)
                  (random z)))