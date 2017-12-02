#lang racket

(define spiel #(  0 0 0 0 0 9 0 7 0
                  3 0 0 0 8 2 0 5 0
                  0 2 7 0 0 0 0 4 0
                  0 1 6 0 4 0 0 0 0
                  0 5 0 0 0 0 3 0 0
                  0 0 0 0 9 0 7 0 0
                  0 0 0 6 0 0 0 0 5
                  8 0 2 0 0 0 0 0 0
                  0 0 4 2 0 0 0 0 8 ))

(define spiel2 #( 6 8 5 4 3 9 2 7 1
                  4 9 1 7 8 2 6 5 3
                  3 2 7 5 6 1 8 4 9
                  9 1 6 3 4 7 5 8 2
                  7 5 8 1 2 6 3 9 4
                  2 4 3 8 9 5 7 1 6
                  1 3 9 6 7 8 4 2 5
                  8 6 2 9 5 4 1 3 7
                  5 7 4 2 1 3 9 6 8))

(define (xy->index x y)
      (+  x (* 9 y)))

(define (zeile->indizes zeile)
  (build-list 9 (curry + (* zeile 9))))

(define (spalte->indizes spalte)
  (build-list 9 (compose (curry + spalte) (curry * 9))))

(define (quadrant->indizes quadrant)
  (map (curry + (* (remainder quadrant 3) 3)
                (* (quotient quadrant 3) 27))
       '(0 1 2 9 10 11 18 19 20)))

(define  (spiel->einträge spiel indizes)
  (map (curry vector-ref spiel) indizes))

(define (check-zeilen spiel)
  (map check-duplicates (map (curry spiel->einträge spiel) (map zeile->indizes '(0 1 2 3 4 5 6 7 8)))))

(define (check-spalten spiel)
  (map check-duplicates (map (curry spiel->einträge spiel) (map spalte->indizes '(0 1 2 3 4 5 6 7 8)))))

(define (check-quadranten spiel)
  (map check-duplicates (map (curry spiel->einträge spiel) (map quadrant->indizes '(0 1 2 3 4 5 6 7 8)))))

(define (equal-list list1)
      (if (equal? (length(remove-duplicates list1)) 1)
          #t
          #f))


(define (check-konsistenz spiel)
  (let ([all (append (check-zeilen spiel) (check-spalten spiel) (check-quadranten spiel))])
    (if (and (equal-list all) (member #f all))
        #t
        #f)))

(define (check-lösung spiel)
  (if (and (check-konsistenz spiel) (not (vector-member 0 spiel)))
      #t
      #f))
  


