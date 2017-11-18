#lang racket

; re: 27 punkte

;; Blatt 1 Ali Ebrahimi und Vanessa Closius

; Aufgabe 1.1 Bogenmaß und Grad

(define (deg->rad x)
  (/ (* x pi) 180))

(define (rad->deg x)
  (/ (* x 180) pi))

; Aufgabe 1.2 acos

(define (acos x)
(atan (/ (sqrt (- 1 (expt x 2))) x)))


; Aufgabe 1.3 Seemeilen zu km

(define (nm->km x)
  (* x 1.852)
)

; Aufgabe 2.1 Großkreisentfernung

(define (dG a1 a2 b1 b2)
 (acos
      (+
       (* (sin (deg->rad a1)) (sin (deg->rad b1)))
       (* (cos (deg->rad a1)) (cos (deg->rad b1))
          (cos (abs (- (deg->rad a2) (deg->rad b2))))))))


(define (distanzAB a1 a2 b1 b2)
  (nm->km 
     (* 60 (rad->deg (dG a1 a2 b1 b2)))))

; Entfernung Oslo - Hong Kong
(distanzAB 59.93 10.75 22.20 114.10) ; 8589.412217586056

; Entfernung San Francisco - Honolulu
(distanzAB 37.75 -122.45 21.32 -157.83) ; 3844.6880504870555

; Entfernung Osterinsel - Lima
(distanzAB -27.10 -109.40 -12.10 -77.05) ; 3757.622218810056

; Aufgabe 2.2 Anfangskurs

(define (alpha a1 a2 b1 b2)
  (rad->deg (acos
             (/ (- (sin (deg->rad b1))
                   (* (cos (dG a1 a2 b1 b2))
                      (sin (deg->rad a1))))
                (* (cos (deg->rad a1))
                   (sin (dG a1 a2 b1 b2)))))))

; re: warum hier nicht einfach (>= a1 b1) und (< a1 b1)?
; ich glaube, ihr habt eure bedingungen falsch rum.
; (kurs 59.93 10.75 22.20 114.10) sollte 67.43567317710463 ergeben, ergibt aber
; ungefähr 292.
; -1 pkt

(define (kurs a1 a2 b1 b2)
  (cond
    [ (>= (- a1 b1) 0) (- 360 (alpha a1 a2  b1 b2))]
    [ (< (- a1 b1) 0) (alpha a1 a2 b1 b2)]))

; Aufgabe 2.3 Himmelsrichtungen

(define (grad->himmelsrichtung grad)
  (cond
  [ ( <= grad 180) (cond
                     [ (= grad 180) 'S]
                     [ (< 135 grad 180) 'SSE]
                     [ (= 135 grad)'SE]
                     [ (< 90 grad 135)'ESE]
                     [ (= 90 grad)'E]
                     [ (< 45 grad 90)'ENE]
                     [ (= 45 grad)'NE]
                     [ (< 0 grad 45)'NNE]
                     [ (= 0 grad)'N])
                   ]
  [else (cond
          [ (< 360 grad)'PLEASE_GIVE_ME_A_NUMBER_BETWEEN_0_AND_360]
          [ (= 360 grad)'N]
          [ (< 315 grad 360)'NWN]
          [ (= 315 grad)'NW]
          [ (< 270 grad 315)'WNW]
          [ (= 270 grad)'W]
          [ (< 225 grad 270)'WSW]
          [ (= 225 grad)'SW]
          [ (< 180 grad 225)'SSW])
        ]))

; re: das ist so nicht ganz richtig, ihr solltet den Kreis in 16 gleich große
; teile teilen, hier sind Süden, Norden etc keine richtigen Abschnitte sondern
; nur einzelne Punkte auf dem Kreis.
; Das heißt:
(grad->himmelsrichtung 1)
; sollte 'N ergeben. gleiches gilt für die Umkehrfunktion. -1pkt.


; Himmelsrichtung in Grad
; Parameterübergabe in String

; re: hier (und auch in den nächsten blättern)
; könnt ihr ruhig davon ausgehen, dass symbole übergeben werden.

(define (himmelsrichtung-->grad himmelsrichtung)
  (cond
  [ (eqv? (string->symbol himmelsrichtung) 'S) '180_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'SSE) '135-180_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'ESE) '90-135_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'E) '90_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'ENE) '45-90_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'NE) '45_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'NNE) '0-45_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'N) '0_ODER_360_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'NWN) '315-360_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'NW) '315_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'WNW) '270-315_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'W) '270_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'WSW) '225-270_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'SW) '225_GRAD]
  [ (eqv? (string->symbol himmelsrichtung) 'SSW) '180-225_GRAD]
  [ else 'DIES_IST_KEINE_GUELTIGE_HIMMELSRICHTUNG]))



        