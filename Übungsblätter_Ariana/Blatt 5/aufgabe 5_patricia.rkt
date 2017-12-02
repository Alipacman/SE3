#lang racket
(require se3-bib/butterfly-module)

#|
--- Analyse und Grobentwurf ---
Ansatz:
Wir minimieren schrittweise die Anzahl der zu verarbeitenden Listen:
Wir beginnen mit 4 Listen: 2 Merkmalslisten (dominant und rezessiv) vom Vater und 2 Merkmalslisten der Mutter. --> 4 Listen
Wir erstellen eine neue Liste für den Vater und eine für die Mutter, in der randomisiert je eine der beiden Merkmalsausprägungen vorkommt.
Diese Liste enthält dann das Genom des Schmetterlingkindes.--> 2 Listen
Aus den beiden randomisierten Listen erstellen wir eine neue Liste, in der nur die dominanteren der beiden Merkmalsausprägungen vorkommen.
Diese Liste bestimmt letztendlich das Erscheinungsbild des Schmetterlingkindes. --> 1 Liste

--> als Datenstruktur zur Repräsentation des Genoms eines Schmetterlinges wählen wir also Listen

Um diesen Ansatz umzusetzen brauchen wir grob die folgenden Funktionen:

i)
Unserer Hauptfunktion sollen fünf Parameter übergeben werden:
1. die Anzahl der gewünschten Kinder
2. die rezessiven Merkmale des Vaters
3. die dominanten Merkmale des Vaters
4. die rezessiven Merkmale der Mutter
5. die dominanten Merkmale der Mutter

ii)
Außerdem brauchen wir eine Funktion, die zwei Merkmale miteinander vergleichen kann, und am Ende das dominantere Merkmal ausgibt.
Dafür benötigen wir die member-Funktion:
Für eines der Merkmale (merkmal1) rufen wir Folgendes auf: (member <merkmal1> <entsprechende_sortierte_Merkmalsliste>).
Dies gibt in jedem Fall eine Restliste aus, da es nie #f ausgibt da merkmal1 auf jeden Fall in der entsprechenden Merkmalsliste zu finden ist.
Auf dieser Restliste rufen wir nun Folgendes auf: (member <merkmal2> <Restliste>).
Wird dabei nicht #f aufgegeben, so wissen wir, dass merkmal2 in der sortierten Merkmalsliste weiter hinten steht als merkmal1, und somit ist merkmal2 dominanter als merkmal1.
Wird dabei #f ausgegeben, so wissen wir, dass merkmal2 in der sortierten Merkmalsliste entweder an der selben Stelle steht wie merkmal1, oder weiter vorne.
Damit erkennen wir auch, wenn merkmal1 dominanter ist als merkmal 2.

iii)
Den genetischen Grundlagen nach liegen für jedes Merkmal zwei Merkmalsausprägung auf unterschiedlichen Allelen vor. Dabei ist eine der Merkmalesausprägungen die dominante, und eine die rezessive.
Bei der Vererbung wird zufällig eines der Allele an das Kind weitergegeben.
Diese Funktionalität haben wir in der Funktion "randomize" implementiert.
|#

; --- Implementation ---
; Datenstruktur: Wir speichern alle möglichen Merkmalsausprägungen in insgesamt 4 Listen, wobei die Merkmale so geordnet sind, dass in aufsteigender Reihenfolge links die rezessiven und rechts die dominanten Merkmale stehen.
(define musterung '(stripes dots star))
(define flügelfarbe '(yellow blue red green))
(define fühlerform '(straight curly curved))
(define flügelform '(hexagon ellipse rhomb))

; Diese Liste brauchen wir zur Überprüfung auf Enthalten eines Elements in der dem Element zugeordneten Liste durch member (siehe Funktion "dominanztest").
(define merkmalsliste '((yellow blue red green) (stripes dots star) (straight curly curved) (hexagon ellipse rhomb)))

; Hilfsfunktion, die auf zwei Listen, die (neben der Merkmalsliste aller möglichen Mermale) jeweils die dominanteren Merkamle der zwei Listen in einer neuen Liste ausgibt
(define (dominanztestAufListen m1 m2 merkmalsliste)
  (if (and (empty? m2) (empty? m1))
      '()
      (if (member (car m2) (member (car m1) (car merkmalsliste)))
          (cons (car m2) (dominanztestAufListen (cdr m1) (cdr m2) (cdr merkmalsliste)))
          (cons (car m1) (dominanztestAufListen (cdr m1) (cdr m2) (cdr merkmalsliste))))))

; Hilfsfunktion, die eines der beiden Allele (dominant oder rezessiv; werden als Parameter übergeben) random aussucht -> aus zwei Listen wird eine gemacht mit den Merkmalen, die an das Kind vererbt werden
(define (randomize dominant rezessiv)
  (if (empty? dominant)
      '()
      (cons (car(shuffle(list(car dominant) (car rezessiv)))) (randomize (cdr dominant) (cdr rezessiv)))))

; Hilfsfunktion, die als Parameter vier Listen bekommt:
; 1. rezessive Merkmale des Vaters, 2. dominante Merkmale des Vaters, 3. rezessive Merkmale der Mutter, 4. dominante Merkmale der Mutter
; Die Funktion wendet auf die je zwei Listen der Eltern die randomize-Funktion an und auf die beiden Ergebnislisten wird der Dominanztest angewendet um den Phänotyp den Schmetterlingkindes heruaszufinden.
(define (chewbaccafly vaterR vaterD mutterR mutterD)
      (dominanztestAufListen (randomize vaterR vaterD) (randomize mutterR mutterD) merkmalsliste))

; Hilfsfunktion, die von der Funktion zeichneFamilie aufgerufen wird.
; Sie zeichnet alle Kinder und beide Eltern, wobei...
; (1)   der erste Schmetterling die Mutter ist,
; (2)   der zweite der Vater und
; (3-n) die restlichen Schmetterlinge die Kinder sind.
; Als Parameter werden die Merkmale aller Kinder  als Listen in einer Liste (kinderliste) übergegeben, sowie die dominaten Merkmale der Mutter und die des Vaters (je in einer Liste)
(define (zeichne kinderliste mutter vater)
 (display  (map (lambda (arg)
         (apply show-butterfly arg))
         (append (list mutter vater) kinderliste))))

;--- Hauptfunktion ---;
;; Hauptfunktion, der als Parameter…
;  1. die gewünschte Anzahl an Kindern,
;  2. die rezessiven Merkmale des Vaters,
;  3. die dominanten Merkmale des Vaters,
;  4. die rezessiven Merkmale der Mutter un
;  5. die dominanten Merkmale der Mutter übergeben werden,
;  wobei 2.-5. je als Liste übergeben werden und 1. eine natürliche Zahl ist.
;  In der Merkmalsliste sind die Merkmale in folgender Reihenfolge einzugeben: flügelfarbe musterung fühlerform flügelform
(define (zeichneFamilie anzahlKinder vaterR vaterD mutterR mutterD)
  (letrec ( [inner (lambda (i kinderliste)
                   (if (= i 0)
                       (zeichne kinderliste mutterD vaterD)
                       (inner (- i 1) (append kinderliste (list (chewbaccafly vaterR vaterD mutterR mutterD))))))])
    (inner anzahlKinder '())))

; --- Erprobung ---
; Kinder, die hier gezeichnet werden, können nicht grün sein
(zeichneFamilie 2 '(red stripes curly hexagon) '(yellow dots curved rhomb) '(yellow stripes straight hexagon) '(blue star curly ellipse))

; Beispieleltern aus Tabelle:
; Hier müssen alle Kinder die Flügelfarbe grün haben, da der Vater sowohl als dominantes, als auch als rezessives Merkmal die Flügelfarbe grün trägt.
; Deshalb bekommt jedes Kind das Merkmal grün. Da grün die dominanteste der Flügelfarben ist, zeigt sich diese Merkmalsausprägung immer und unabhängig der von der Mutter geerbten Flügelfarbe.
(zeichneFamilie 3 '(green stripes curly hexagon) '(green dots curved rhomb) '(blue stripes straight hexagon) '(red star curly ellipse))