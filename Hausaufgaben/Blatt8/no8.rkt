#lang racket

;Aufg 1
#|
1. Eine Funktion höherer Ordnung ist eine Funktion die als Input
mindestens eine Funktion bekommt oder eine Funktion returned.

2.
a)
Keine Funktion höherer Ordnung, da eine Integer Zahl als Input vorgesehen ist,
und sonst nichts returned wird. und falls ein vorgesehener Input eingegeben wurde,
kann nur das Symbol 'gerade oder 'ungerade returned werden, aber keine Funktion.

b)
map ist eine Funktion höherer Ordnung, da sie laut Racket Doc
eine Funktion /proc als Input nimmt:
(map proc lst ...+)-> list?

c)
Ist eine Funktion höherer Ordnung, da xs eine Funktion seien muss,
damit map funktionieren kann (siehe b)

d)
Keine Funktion höherer Ordnung, da x und y auf größer/kleiner / gleicheit
 geprüft werden und dies ist nicht möglich mit Funktionen, außerdem wird keine Funkt. returend.

e)Ist eine Funktion höherer Ordnung da als Input eine Funktion genommen wird kann,
siehe Aufgabe 3

3.
Bei der Funktion schweinchen-in-der-mitte wird list an das Argument f gebunden und die Zahl 4 an das Argument arg1.
Dann wird in der inneren Funktion die Zahl 1 an das Argument arg2 und die Zahl 3 an das Argument arg3 gebunden.
Die FUnktionsdefiniton geschieht im Kontext der aktuellen Bindungsumgebung, daher handelt es sich um ein Closure.
-----muss hier nochwas hin?

4.

a)
Der Wert 21 wird ausgegeben, da mit Foldl eine Funktion auf jedem Element einer Liste ausgeführt wird mit einem Anfangswert.
Der Anfangswert ist 3 und die Funktion ist eine Addition, wobei immer mit 2 addiert wird, wegen des currys, welches eine 2 als erstes Argument immer mitgiebt.
Das bedeutet, dass der Anfangswert 3 mit der ersten 3 in der Liste addiert wird und dann noch plus 2. Dieser Wert wird mit der 4 addiert plus 2
und dann mit der 5 plus 2 = 21.

b)
Die Liste '(ungerade gerade ungerade gerade gerade gerade gerade ungerade) wird ausgegeben, weil die Funktion Map, die Funktion gerade-oder-ungerade
auf jedem Element der Liste einzelnt ausführt und die einzelnen Ausgaben geordnet in einer Liste speichert.

c)
Gibt '(1 4 -7) aus, da die filter Funktion über die Liste '((a b) () 1 (()) 4 -7 "a")) rüber iteriert
und die Funktion number? ausführt auf jedem Element und nur die Werte bei denen ein true Value ausgegeben wird in eine Liste schreibt und zurückgibt.

d)
Gibt -51 aus, da compose eine neue Funktion ausgibt die die Liste '(5682 48 24915 -45 -6 48) als Input bekommt.
Die Funktion die Compose erstellt verknüpft die Funktionen (curry foldl + 0) und (curry filter (curryr < 0)), wobei die zweite Funktion als erstes Ausgeführt wird.
Die Funktion (curry filter (curryr < 0)) filtert alle Zahlen die kleiner als 0 raus, sodass nur noch '(-45 -6) übrig bleibt (curryr ist wie curry
, nur dass es von rechts anfängt und sich nach links arbeitet).
Danach wird auf die Liste '(-45 -6) die Funktion (curry foldl + 0) angewendet, wobei die Werte in der Liste einzelnd auf addiert werden + 0 (siehe teil a).
|#

;Aufg 2

(define swag '(2 11 4 5 11 9 9))

;Aufgabe 2.1
(define (sqr-list lst)
  (map
   (curryr expt 2) lst))

;2.2 

;2.3
(define (sum-of-big-six lst)
  (foldl + 0 ((compose (curry filter odd?)(curry filter (curry < 6))) lst)  
   ))

;2.4




  
