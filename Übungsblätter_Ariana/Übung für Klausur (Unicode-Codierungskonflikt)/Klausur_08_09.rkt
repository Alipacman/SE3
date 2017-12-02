#lang racket
;Klausur 08/09

#|
> (car '(((An) de Eck) steiht een Jung))
'((An) de Eck)
> (cdr '(mit (nem) trudelband)) 
'((nem) trudelband)
> (car '(mit (nem) trudelband)) 
'mit
> (map car '((1 2) (1 4) (1 3))) 
'(1 1 1)
> (filter number? '( #f 42 (drei) (1 2))) 
'(42)
> ((lambda (x) (* x x)) 2) 
4
>

Losung:
Praxnotation: Bei der Praxnotation stehen die Operatoren am Anfang des
Ausdrucks, gefolgt von den Operanden.
Vorteile: Die Operatoren konnen mehr als zwei Argumente haben. Es gibt
keinen syntaktischen Unterschied zwischen Operatoren und Funktionen.
Prazedenzregeln und Klammern sind uber
ussig, wenn die Operatoren
eine feste Stelligkeit haben.
Nachteile: ungewohnte Notation
Beispiel: + 1 * 3 4 5
Inxnotation: Bei der Inxnotation stehen die Operatoren zwischen den Operanden.
Vorteile: vertraute Notation aus der Mathematik. Klammern sind uber
ussig,
wenn Prazedenzregeln vereinbart werden.
Nachteile: Die Stelligkeit der Operatoren ist auf zwei beschrankt.
Beispiel: 1 + 3*4*5

Losung: (let ((sx (sin 3.1414))) (sqrt (- 1 
oder
(sqrt (- 1 (* (cos 3.1414) (cos 3.1414))))

Losung: Eine Liste ist eine rekursive Datenstruktur, die entweder eine leere
Liste ist oder ein Kopfelement, gefolgt von einer Liste.

Losung: Es wird kein Stack fur Bindungsumgebungen der rekursiven Funktionsaufrufe
benotigt. Der Speicherbedarf ist konstant und nicht von der
Tiefe der rekursionabhangig.
|#

(define (my-length xs)
  (letrec ([inner (lambda (list zahl)
                    (if (empty? list) zahl
                        (inner (cdr list) (+ 1 zahl))))])
    (inner xs 0)))

(my-length '(1 2 3))

(define (my-length2 xs)
  (if (empty? xs) 0
      (+ 1 (my-length2 (cdr xs)))))

(my-length2 '(1 2 3))


(define (make-deposit amount currency)
  (list amount currency ))


(define (amount-of deposit)
  (car deposit ))

(define (currency-of deposit)
  (cadr deposit ))


(define (multiply-deposit deposit fac)
  (make-deposit
   (* (amount-of deposit) fac)
   (currency-of deposit )))

(define *Kurse*
  '((NOK . 0.1106265) ;  Kronen
    (USD . 0.7807) ; US Dollar
    (SEK . 0.0932937) ; Schwedische Kronen
    (EURO . 1.0)))

(define (deposit->euro deposit)
  (make-deposit (* (amount-of deposit)
                   (cdr (assoc (currency-of deposit) *Kurse*)))
                'EUR))

(define (deposit+ deposit1 deposit2)
  (make-deposit (+ (amount-of (deposit->euro deposit1))
                    (amount-of (deposit->euro deposit2)))
                'EUR))


(define *bordkasse*
(list (make-deposit 10 'Euro) (make-deposit 5 'Euro)
(make-deposit 500 'DKK) (make-deposit 200 'DKK)
(make-deposit 20 'NOK) (make-deposit 100 'NOK)
(make-deposit 200 'USD) (make-deposit 100 'GBP) (make-deposit 300 'USD )))


(define (bestand kasse waehrung)
(filter (lambda (x) (equal? (currency-of x) waehrung )) kasse ))

(define (summeWährung bordkasse währung)
  (make-deposit (foldl + 0 (map amount-of (bestand bordkasse währung)))
                währung))
