#lang racket

(require racket/vector)
;;; 1   – Sudoku

;;  1.1 – Konsistenz eines Spielzustands

; ––– Beispielspiele –––
; zum Testen der Funktionen unten 
(define spielUngeloestKonsistent  (vector
                                   0 0 0 0 0 9 0 7 0
                                   0 0 0 0 8 2 0 5 0
                                   3 2 7 0 0 0 0 4 0
                                   0 1 6 0 4 0 0 0 0
                                   0 5 0 0 0 0 3 0 0
                                   0 0 0 0 9 0 7 0 0
                                   0 0 0 6 0 0 0 0 5
                                   8 0 2 0 0 0 0 0 0
                                   0 0 4 2 0 0 0 0 8))


(define spielInkonsistent (vector
                           1 1 1 1 1 9 1 7 1
                           1 1 1 1 8 2 1 5 1
                           3 2 7 1 1 1 1 4 1
                           1 1 6 1 4 1 1 1 1
                           1 5 1 1 1 1 3 1 1
                           1 1 1 1 9 1 7 1 1
                           1 1 1 6 1 1 1 1 5
                           8 1 2 1 1 1 1 1 1
                           1 1 4 2 1 1 1 1 8))

(define spielGeloestKonsistent (vector
                                6 8 5 4 3 9 2 7 1
                                4 9 1 7 8 2 6 5 3
                                3 2 7 5 6 1 8 4 9
                                9 1 6 3 4 7 5 8 2
                                7 5 8 1 2 6 3 9 4
                                2 4 3 8 9 5 7 1 6
                                1 3 9 6 7 8 4 2 5
                                8 6 2 9 5 4 1 3 7
                                5 7 4 2 1 3 9 6 8))


;   1.1.1
(define (xy->index x y)
  (+  x (* 9 y)))

; 1.1.2
(define (zeile->indizes zeile)
  (build-list 9 (curry + (* zeile 9))))

(define (spalte->indizes spalte)
  (build-list 9 (compose (curry + spalte) (curry * 9))))

(define (quadrant->indizes quadrant)
  (map (curry + (* (remainder quadrant 3) 3)
                (* (quotient quadrant 3) 27))
       '(0 1 2 9 10 11 18 19 20)))

;   1.1.3
(define (spiel->einträge spiel indexmenge)
  (map (curry vector-ref spiel) indexmenge))

;   1.1.4

; ––– Hilfsfunktion –––
; Checkt ob Duplikate enthalten sind. (außer 0 und X)

(define (check-zeilen spiel)
  (map check-duplicates (map (curry remove* (list 0 'X)) (map (curry spiel->einträge spiel) (map zeile->indizes '(0 1 2 3 4 5 6 7 8))))))

(define (check-spalten spiel)
  (map check-duplicates (map (curry remove* (list 0 'X)) (map (curry spiel->einträge spiel) (map spalte->indizes '(0 1 2 3 4 5 6 7 8))))))

(define (check-quadranten spiel)
  (map check-duplicates (map (curry remove* (list 0 'X)) (map (curry spiel->einträge spiel) (map quadrant->indizes '(0 1 2 3 4 5 6 7 8))))))

; Hilfsfunktion checkt ob alle Elemente einer Liste gleich sind.
(define (equal-list list1)
      (if (equal? (length(remove-duplicates list1)) 1)
          #t
          #f))

; ––– Hauptfunktion -––
; Gibt false aus, wenn in einem Spiel eine Zahl (außer 0) mehr als ein Mal in einer Zeile, einer Spalte oder einem Quadranten vorkommt.
(define (check-konsistenz spiel)
  (let ([all (append (check-zeilen spiel) (check-spalten spiel) (check-quadranten spiel))])
    (if (and (equal-list all) (member #f all))
        #t
        #f)))

; ––– Hauptfunktion –––
; Prüft, ob ein Spiel konsistent ist und keine 0en mehr darin vorkommen.
(define (check-lösung spiel)
  (if (and (check-konsistenz spiel) (not (vector-member 0 spiel)))
      #t
      #f))


; (spiel-geloest? spielUngeloestKonsistent)
; -> #f

; (spiel-konsistent? spielUngeloestKonsistent)
; -> #t

; (spiel-geloest? spielInkonsistent)
; -> #f

; (spiel-konsistent? spielInkonsistent)
; -> #f

; (spiel-geloest? spielGeloestKonsistent)
; -> #t

; (spiel-konsistent? spielGeloestKonsistent)
; -> #t



;; 1.2 – Sudoku lösen (ohne Backtracking)

(define (markiere-ausschluss spiel eingabe)
  (letrec ( [inner (lambda (copyvec i eingabe)
                     (if (= 81 i) 
                         copyvec
                         (if (= 0 (vector-ref copyvec i)) 
                             (if (check-konsistenz (let* ([x (vector-copy! copyvec i (vector eingabe))])  copyvec))
                                 (inner (let* ([x (vector-copy! copyvec i #(0))])  copyvec) (+ 1 i) eingabe)
                                 (inner (let* ([x (vector-copy! copyvec i (vector 'X))])  copyvec) (+ 1 i) eingabe)
                                 )
                                 
                             (inner copyvec (+ i 1) eingabe))))])
    (inner (vector-copy spiel) 0 eingabe)))


; (markiere-ausschluss spielUngeloestKonsistent 4)
; -> '#(0 0 X 0 X 9 X 7 0 0 X 0 8 2 X 5 X 3 2 7 X X X X 4 X X 1 6 X 4 X X X X 0 5 X X X X 3 X 0 0 0 X X 9 X 7 X 0 X X X 6 X 0 0 X 5 8 X 2 0 X 0 0 X 0 X X 4 2 X X X X 8)

;  Vergleich  Originalvektor      und        Ausschlussvektor
;                  |                                |

;  (vector  0 0 0 0 0 9 0 7 0      –      '#(0 0 X 0 X 9 X 7 X
;           0 0 0 0 8 2 0 5 0      –         0 0 X 0 8 2 X 5 X
;           3 2 7 0 0 0 0 4 0      –         3 2 7 X X X X 4 X
;           0 1 6 0 4 0 0 0 0      –         X 1 6 X 4 X X X X
;           0 5 0 0 0 0 3 0 0      –         0 5 X X X X 3 X 0
;           0 0 0 0 9 0 7 0 0      –         0 0 X X 9 X 7 X 0
;           0 0 0 6 0 0 0 0 5      –         X X X 6 X 0 0 X 5
;           8 0 2 0 0 0 0 0 0      –         8 X 2 0 X 0 0 X 0
;           0 0 4 2 0 0 0 0 8))    –         X X 4 2 X X X X 8)
