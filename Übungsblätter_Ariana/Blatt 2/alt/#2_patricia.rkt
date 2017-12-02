#lang racket
;;; 1 Symbole und Werte, Umgebungen
(define miau 'Plueschi)
(define katze miau)
(define tiger 'miau)

(define (welcherNameGiltWo PersonA PersonB)
  (let ((PersonA 'Sam)
        (PersonC PersonA))
        PersonC))

(define xs1 '(0 2 3 miau katze))

(define xs2 (list miau katze))
(define xs3 (cons katze miau))

;   1. miau -> 'Plueschi
;   Begründung: miau ist das Symbol 'Plueschi zugewiesen
;   2. katze -> 'Plueschi
;   Begründung: katze ist die Definition miau zugewiesen, und miau wird das Symbol 'Plueschi zugewiesen
;   3. tiger -> 'miau
;   Begründung: tiger ist das Symbol 'miau zugewiesen
;   4. (quote katze) -> 'katze
;   Begründung: die quote-Anweisung macht aus katze das Symbol 'katze
;   5. (eval tiger) -> 'Plueschi
;   Begründung: die eval-Anweisung wertet das Symbol 'miau, das tiger zugewiesen ist, zu miau aus und mia ist das Symbol #Plueschi zugewiesen
;   6. (eval katze) -> Plueschi: undefined
;   Begründung: die eval-Anweisung wertet das Symbol 'Pluschi, das katze zugewiesen ist, zu Plueschi aus; dann wird aber kein Wert gefunden, der Pluschi zugewiesen wird
;   7. (eval ’tiger) -> 'miau
;   Begründung:  die eval-Anweisung wertet das Symbol 'tiger zu tiger aus und gibt daher das Symbol 'miau aus, das tiger zugewiesen ist
;   8. (welcherNameGiltWo ’harry ’potter) -> 'harrry
;   Begründung: die Bindungen der Variablen werden nicht sequenziell in Abhängigkeit voneinander vorgenommen, daher wird am Ende PersonC ausgegeben, der PersonA (also 'harry) zugewiesen wurde und nicht 'Sam, obwohl 'Sam vorher PersonA zugewiesen wurde
;   9. (cdddr xs1) -> '(miau katze)
;   Begründung: Es wird die Liste xs1 ab dem vierten Element ausgegeben
;   10. (cdr xs2) -> '(Plueschi)
;   Begründung: Es wird die Liste xs2 ab dem zweiten Element ausgegeben und vorher das zweite Element ausgewertet (katze wird hier zu Plueschi)
;   11. (cdr xs3) -> 'Plueschi
;   Begründung: Es wird das zweite Element der konkatenierten Liste ausgewertet und ausgegeben
;   12. (eval (sqrt 3)) -> Die Wurzel von 3
;   Begründung: die eval-Anweisung wertet (sqrt 3) aus, es wird also die Wurzel von 3 gezogen
;   13. (eval ’(welcherNameGiltWo ’tiger ’katze)) -> 'tiger
;   Begründung: die eval-Anweisung wertet zuerst ’(welcherNameGiltWo ’tiger ’katze) zu (welcherNameGiltWo ’tiger ’katze) aus; der Rest geschieht analog zu 8.
;   14. (eval (welcherNameGiltWo ’katze ’tiger )) -> 'Plueschi
;   Begründung: die eval-Anweisung führt die Funktion welcherNameGiltWo aus und wertet das zurückgegebene Symbol 'katze zu katze und damit zu 'Plueschi aus


;;; 2 Rechnen mit exakten Zahlen
;;  2.1 Die Fakultät einer Zahl
;   0! = 1
;   n! = n·(n-1)!,n∈N TO DO: NATÜRLICH?
(define (fak n)
   (if (= n 0) 1
          (* n (fak (- n 1)))))

;;  2.2 Potenzen von Rationalzahlen TO DO: RATIONAL?
;   r^n
(define (power r n)
   (if (= n 0) 1
          (if (even? n)
              (sqr (power r (/ n 2)))
              (* (power r (- n 1)) r))))

;;  2.3 Die Eulerzahl e TO DO

;;  2.4 π

;;; 3 Typprädikate
(define (type-of exp)
   (cond
    [(boolean? exp) 'Boolean]
    [(list? exp) 'List]
    [(pair? exp) 'Pair]
    [(symbol? exp) 'Symbol]
    [(number? exp) 'Number]
    [(char? exp) 'Char]
    [(string? exp) 'String]
    [(vector? exp) 'Vector]
    [(procedure? exp) 'Procedure]
    ))

(define (id z) z)

;   (type-of (* 2 3 4))  -> 'Number
;   Begründung: (* 2 3 4) ergibt 24, das eine Nummer ist
;   (type-of (not 42))  -> 'Boolean
;   Begründung: der Ausdruck (not 42) ergibt #f
;   (type−of '(eins zwei drei))  -> 'List
;   Begründung: '(ein zwei drei) ist eine Liste (allerdings auch ein Pair; list? steht aber im cond vor pair?; pair? würde ausgegeben beispielsweise bei (type-of (cons 1 2)))
;   (type−of '())  -> 'List
;   Begründung: '() ist eine leere Liste
;   (type−of (id sin))  -> 'Procedure
;   Begründung: id nimmt einen Wert als Parameter und gibt ein Ergebnis aus und ist daher eine Operation
;   (type-of (string−ref "Harry␣Potter␣und␣der␣Stein␣der␣Weisen" 3))  -> 'Char
;   Begründung: Mit der string-ref Anweisung wird der Charakter an Stelle 3 des Strings "Harry..." ausgegeben
;   (type-of (lambda (x) x))  -> 'Procedure
;   Begründung: lambda nimmt einen Wert als Parameter und gibt ein Ergebnis aus und ist daher eine Operation
;   (type-of type-of )  -> 'Procedure
;   Begründung: TO DO 
;   (type−of (type−of type−of))  -> 'Symbol
;   Begründung: TO DO 
