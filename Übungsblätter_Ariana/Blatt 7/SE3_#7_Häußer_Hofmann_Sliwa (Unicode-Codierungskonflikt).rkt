#lang racket
(require 2htdp/image)
(require 2htdp/universe)

#|
Blatt 7, Gruppe 8, Mittwoch 10-12 Uhr, Raum G-210, Übungsleiter Rainer Jürgensen
Thomas Hofmann (6764839⁠⁠⁠)
Patricia Häußer (⁠⁠⁠6771401)
Ariana Sliwa (6816391)
|#

;;; --- 1 – Abbilden ---
;;  Allgemein rekursive Funktion
(define (product1 list faktor)
  (if (empty? list)
      '()
      (cons (* faktor (car list)) (product1 (cdr list) faktor))))

;   (product1 '(2 4 3) 3) -> '(6 12 9)


;;  Endrekursive Funktion
(define (product2 list faktor)
  (letrec ( [ innere (lambda (liste produkte)
                       (if (empty? liste)
                           (reverse produkte)
                           (innere (cdr liste) (cons  (* faktor (car liste)) produkte))))])
    (innere list '())))

;   (product2 '(2 4 3) 3) -> '(6 12 9)


;;  Mit Funktion höherer Ordnung
(define (product3 list faktor)
  (map (curryr * faktor) list))

; (product3 '(2 4 3) 3) -> '(6 12 9)


;;; --- Aufgabe 2 – Sieben-Segment-Anzeige ---

;;  --- 2.1 – Zustände ---

; Ansatz:
; Wir wählen als Datenstruktur Listen.
; Jedes Display besteht aus sieben Strichen (Segmenten): o(ben), m(itte), u(nten), o(ben)l(inks), o(ben)r(echts), u(unten)l(inks), u(unten)r(echts)
; Wir speichern daher für jeden dieser Striche eine Liste ab, in der die Ziffern stehen, bei denen der Strich rot sein soll.
; Wenn später eingegeben wird, welche Ziffer angezeigt werden soll, wird für die gegebene Ziffer auf Enthalt in jeder der unten definierten sieben Listen geprüft.
; Ist die gegebene Ziffer in der Liste des Segments, so wird das entsprechende Segment rot gezeichnet, sonst grau.

(define o  '(0 2 3 5 6 7 8 9))
(define m  '(2 3 4 5 6 8 9))
(define u  '(0 2 3 5 6 8 9))
(define ol '(0 4 5 6 8 9))
(define or '(0 1 2 3 4 7 8 9))
(define ul '(0 2 6 8))
(define ur '(0 1 3 4 5 6 7 8 9))

; Daraus ergibt sich als Liste, die die Zustände der Segmente für jede Zahl entält, wobei jeder Zahl eine Liste an zu beleuchtenden Segmenten zugeordnet ist:
;                                            '((o u ol or ul ur) (or ur) (o m u or ul) (o m u or ur) (m ol or ur) (o m u ol ur) (o m u ol ul ur) (o or ur) (o m u ol or ul ur) (o m u ol or ur))
; Wobei die Zurodnung wie folgt aussieht:             0             1          2             3            4             5              6             7              8                 9
; Soll also die Ziffer 0 angezeigt werden und von da aus in einer Animation hochgezählt werden, so müssen sequenziell die in den Unterlisten enthaltenen Segmente rot gezeichnet werden.



;;  --- 2.2 – Grafische Darstellung ---

;   --- Hilfsfunktion ---
;   Definition eines senkrechten Segmentes
;   @param farbe wird von zeichneZiffer übergeben und hat entweder den Wert #t oder enthält eine Restliste.
(define (senkrecht farbe)
  (rectangle 10 80 'solid (if farbe
                              'red
                              'dimgray)))

;   --- Hilfsfunktion ---
;   Definition eines waagerechten Segmentes
;   @param farbe wird von zeichneZiffer übergeben und hat entweder den Wert #t oder enthält eine Restliste.
(define (waagerecht farbe)
  (rectangle 80 10 'solid (if farbe
                              'red
                              'dimgray)))

;   --- Hauptfunktion für Aufgabe 2.2 --- 
;   Zeichnet statisch Eine Sieben-Segment Anzeige für eine Ziffer.
;   Es wird für die Ziffer jedes der sieben Segmente über die Funktionen waagerecht und senkrecht in red oder dimgray gezeichnet.
;   Die Farbe ist abhängig davon, ob die Ziffer in der entprechenden Liste der einzelnen Segmente (o, m, u , usw.) enthalten ist.
;   Alle Segmente werden dann per underlay untereinander angeordnet, was hier aber keine Auswirkung zeigt, da sich nie zwei Segmente schneiden.
;   Auf unterster Ebene liegt ein schwarzes Rechteck der Höhe 200 und Breite 100.
;   @param ziffer wird in Aufgabe 2.3 übergeben, und sollte eine Ziffer sein. Es kann aber auch beispielsweise die Zahl 10 übergeben werden.
;   In diesem Fall wird keines der Segmente rot gezeichnet. Diese Funktion wird in Aufgabe 2.5 zum Blinken nach Ablauf des Timers ausgenutzt.
(define (zeichneZiffer ziffer)
  (underlay/xy (underlay/xy (underlay/xy (underlay/xy (underlay/xy (underlay/xy (underlay/xy (rectangle 100 200 'solid 'black)
                                                                                             0 105 (senkrecht (member ziffer ul)))  ; ul
                                                                                90 105 (senkrecht (member ziffer ur)))  ; ur
                                                                   0 15 (senkrecht (member ziffer ol)))   ; ol
                                                      90 15 (senkrecht (member ziffer or)))   ; or
                                         10 5 (waagerecht (member ziffer o)))  ; o
                            10 95 (waagerecht (member ziffer m)))  ; m
               10 185 (waagerecht (member ziffer u))) ; u
)



;;  --- 2.3 – Simulation 1: Einzelanzeige---

;   --- Hauptfunktion für Aufgabe 2.3 ---
;   Ruft die Funktion zeichneZiffer auf Aufgabe 2.2 auf in Abhängigkeit der fortschreitenden Sekundenzahl auf (sobald die animate-Fuktion eine Zeile darunter aktivgesetzt wird)
(define (zeige-7segment t)
  (zeichneZiffer (modulo (quotient t 28) 10)))

;   Animiert die seige-7segment-Funktion
;   (animate zeige-7segment)



;;  --- 2.4 – Simulation 2: Zeitmessungsanzeige ---

;   --- Hilfsfunktion ---
;   Definition des Trennzeichen zwischen Stunden, Minuten und Sekunden
(define (zeichneTrennzeichen)
  (underlay/xy (underlay/xy (rectangle 100 200 'solid 'black)
                            40 70 (rectangle 20 20 'solid 'red))
               40 140 (rectangle 20 20 'solid 'red)))

;   --- Hilfsfunktion ---
;   Definition eines Abstandes zwischen den Einzelnen Sieben-Segment Anzeigen und den Trennzeichen
(define (space)
  (rectangle 10 200 'solid 'black))


;   --- Haupfunktion für Aufgabe 2.4 ---
;   Zeichnet aus sechs Sieben-Segment Anzeigen und zwei Trennzeichen eine Zeitmessungsanzeige der Form SS:MM:SS,
;   wobei S(tunden), M(inuten) und S(ekunden) je mit der Hauptfunktion auf Aufgabe 2.2 gezeichnet werden.
;   @param t wird von (animate zeichneZeitmessungsanzeige) übergeben
;   Aus dem Tick t wird je für Sekunden (sekunden), Zehnersekunden (sekundenz), Minuten (minuten), Zehnerminuten (minutenz), Stunden (stunden) und Zehnerstunden (stundenz) die Änderung berechnet.
;   Wenn 23 Stunden, 59 Minuten und 59 Sekunden vergangen sind, so wird wieder bei 00:00:00 abgefangen um einen Tagesablauf zu simulieren.
;   Später werden die entsprechendesn Sieben-Segment Anzeigen per besides nebeneinander (mit space, s.o.) angeordnet.
(define (zeichneZeitmessungsanzeige t)
  ( let* ([t (modulo t (* 28 60 60 24))] ; nach einem Tag beginnt die Zeitanzeige wieder bei 00:00:00
          [sekunden (modulo (quotient t 28) 10)] ; Berechnung der Ziffer, die auf den entsprechenden Einzelanzeigen angezeigt werden soll in Abhängigkeit von t
          [sekundenz (modulo (quotient t (* 28 10)) 6)]
          [minuten  (modulo (quotient t (* 28 60)) 10)]
          [minutenz  (modulo (quotient t (* 28 600)) 6)]
          [stunden   (modulo (quotient t (* 28 3600)) 10)]
          [stundenz  (modulo (quotient t (* 28 36000)) 3)])
     (beside ; Anordnen und Zeichnen aller benögten Einzelanzeigen inklusive spaces und Trennzeichen (:)
      (space)
      (zeichneZiffer stundenz) (space)
      (zeichneZiffer stunden) (space)
      (zeichneTrennzeichen) (space)
      (zeichneZiffer minutenz) (space)
      (zeichneZiffer minuten) (space)
      (zeichneTrennzeichen) (space)
      (zeichneZiffer sekundenz)(space)
      (zeichneZiffer sekunden) (space))
     ))

;   Animiert zeichneZeitmessungsanzeige
(animate zeichneZeitmessungsanzeige)



;;  --- 2.5 – Zusatzaufgabe: Timer ---

;   --- Hilfsfunktion ---
;   Wird aufgerufen wenn die in der animate-Funktion eingegebene Zeit abgelaufen ist.
;   Lässt die Zeitmessungsanzeige blinken, in dem abwechsechselnd alle Segmente rot und grau gezeichnet werden.
;   @param t wird über timer von animate übergeben
(define (blinke t)
  ( let* ([t (quotient t 5)])
     (if (odd? t)
         (beside ; alle Segmente grau
          (space)
          (zeichneZiffer 10) (space)
          (zeichneZiffer 10) (space)
          (zeichneTrennzeichen) (space)
          (zeichneZiffer 10) (space)
          (zeichneZiffer 10) (space)
          (zeichneTrennzeichen) (space)
          (zeichneZiffer 10)(space)
          (zeichneZiffer 10) (space))
         (beside ; alle Segmente rot
          (space)
          (zeichneZiffer 8) (space)
          (zeichneZiffer 8) (space)
          (zeichneTrennzeichen) (space)
          (zeichneZiffer 8) (space)
          (zeichneZiffer 8) (space)
          (zeichneTrennzeichen) (space)
          (zeichneZiffer 8)(space)
          (zeichneZiffer 8) (space)))))

;   --- Hauptfunktion für Aufgabe 2.5 ---
;   Zeichnet eine Zeitmessungsanzeige wie in Aufgabe 2.4 mit dem Unterschied, dass hier nicht die abgelaufenenen Stunden, Minuten und Sekunden agezeigt werden,
;   sondern die noch verbleibenden - also einen Timer. Ist der Timer abgelaufen, so wird dies durch ein Blinken der Segmente signalisiert.
;   @param zeit wird von animate übergeben und bezeichnet eine Sekundenanzahl, von der heruntergezählt werden soll
;   @param t wird von animate übergeben und beschreibt den Tick
(define (timer zeit t)
  ( let* ([t (- (* 28 zeit) t)] ; Herunterzählen der Zeit in Sekundenschritten
          [t (modulo t (* 28 60 60 24))]
          [sekunden (modulo (quotient t 28) 10)]
          [sekundenz (modulo (quotient t (* 28 10)) 6)]
          [minuten  (modulo (quotient t (* 28 60)) 10)]
          [minutenz  (modulo (quotient t (* 28 600)) 6)]
          [stunden   (modulo (quotient t (* 28 3600)) 10)]
          [stundenz  (modulo (quotient t (* 28 36000)) 3)])
     (if (> (* 28 zeit) t) ; verbleibende Zeit wird nur angezeigt, wenn sie mehr als 0 Sekunden beträt
         (beside ; zeichnet Zeitmessungsanzeige analog zu Aufgabe  2.4
          (space)
          (zeichneZiffer stundenz) (space)
          (zeichneZiffer stunden) (space)
          (zeichneTrennzeichen) (space)
          (zeichneZiffer minutenz) (space)
          (zeichneZiffer minuten) (space)
          (zeichneTrennzeichen) (space)
          (zeichneZiffer sekundenz)(space)
          (zeichneZiffer sekunden) (space))
         (blinke t)))) ; sonst blinken die Segmente (siehe dazu Hilfsfunktion oben)

; animiert timer und setzt die Sekundenanzahl, von der aus der Timer runterzählen soll (hier 120 Sekunden, also 2 Minuten)
(animate (curry timer 120))

