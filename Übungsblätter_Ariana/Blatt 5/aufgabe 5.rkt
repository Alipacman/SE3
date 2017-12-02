#lang racket
(require se3-bib/butterfly-module)


;Datenstruktur wie in Aufgabe vorher, sodass rezessiv bis dominant von links nach rechts geordnet sind mit Werten aufsteigend.

 
(define Musterung '(stripes dots star))
(define Ffarbe '(yellow blue red green))
(define Füform '(straight curly curved))
(define Flform '(hexagon ellipse rhomb))
(define merkmalsliste '((yellow blue red green) (star dots stripes) (straight curly curved) (hexagon ellipse rhomb)))


(define (dominanztestliste m1 m2 merkmalsliste)
  (if (and (empty? m2) (empty? m1))
      '()
      (if (member (car m2) (member (car m1) (car merkmalsliste)))
          (cons (car m2) (dominanztestliste (cdr m1) (cdr m2) (cdr merkmalsliste)))
          (cons (car m1) (dominanztestliste (cdr m1) (cdr m2) (cdr merkmalsliste))))))

(define (randomize dominant rezessiv)
  (if (empty? dominant)
      '()
      (cons (car(shuffle(list(car dominant) (car rezessiv)))) (randomize (cdr dominant) (cdr rezessiv)))))

(define (chewbaccafly vaterR vaterD mutterR mutterD)
      (dominanztestliste (randomize vaterR vaterD) (randomize mutterR mutterD) merkmalsliste))

(define (rekursivebutterfliegen anzahlKinder vaterR vaterD mutterR mutterD)
  (letrec ( [inner (lambda (i kinderliste)
                   (if (= i 0)
                       (zeichnebutter kinderliste)
                       (inner (- i 1) (append kinderliste (list (chewbaccafly vaterR vaterD mutterR mutterD))))))])
                       
    (inner anzahlKinder '())))

(define (zeichnebutter kinderliste)
  (for-each (lambda (arg)
              (printf "This ~a\n" arg)
              23)
            kinderliste))

; erste KLammer weg
; (car '(((green stripes curly rhomb) (green stripes curved hexagon) (green dots curly hexagon))))
;> '((green stripes curly rhomb) (green stripes curved hexagon) (green dots curly hexagon))

; erste LIste
;(car '((green stripes curved rhomb) (green stripes curved rhomb) (green stripes curved rhomb)))
;>'(green stripes curly rhomb)

; zweite LIste
;(car (cdr '((green stripes curved rhomb) (green stripes curved rhomb) (green stripes curved rhomb))))
;>'(green stripes curved hexagon)

; dritte LIste
;  (cdr (cdr '((green stripes curved rhomb) (green stripes curved rhomb) (green stripes curved rhomb))))
;>'((green dots curly hexagon))

(rekursivebutterfliegen 3 '(green stripes curly hexagon) '(green dots curved rhomb) '(blue stripes straight hexagon) '(red star curly ellipse))