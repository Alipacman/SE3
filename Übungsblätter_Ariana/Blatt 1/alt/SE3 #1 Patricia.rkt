#lang racket

;;; 1 Konversionsfunktionen

;; 1.1 Bogenmaß und Grad

; Gradzahlen in Bogenmaß
(define (degrees->radians degrees)
  (* degrees (/ (* 2 pi) 360)))

; Bogenmaß in Gradzahlen
(define (radians->degrees radians)
  (* radians (/ 360 (* 2 pi))))

;; 1.2 Umkehrfunktion acos
(define (my-acos a)
  (atan (/ (sqrt (- 1 (* a a))) a)))
 
;; 1.3 Kilometer und Seemeilen
(define (nm->km seemeilen)
  (* seemeilen 1.852))


;;; 2 Großkreisentfernung und Kurse
; stimmt nicht
; cosdG
(define (dG breiteA laengeA breiteB laengeB)
  (+ (* (sin breiteA) (sin breiteB)) (* (cos breiteA) (cos breiteB) (cos (- laengeB laengeA)))))
  
;; 2.1 Großkreisentfernung
; Breiten: N und S, wobei N positiv und S negativ sein soll
; Längen:  E und W, wobei E positiv und W negativ sein soll
(define (distanzAB breiteA laengeA breiteB laengeB)
  (nm->km (* 60 (radians->degrees (my-acos (dG breiteA laengeA breiteB laengeB))))))

; Oslo (59.93oN, 10.75oE) nach Hongkong (22.20oN, 114.10oE)
(distanzAB 59.91 10.73 22.39 114.10)

; San Francisco(37.75oN, 122.45oW) nach Honolulu (21.32oN,157.83oW)
(distanzAB 37.75 -122.45 21.32 -157.83)

; Osterinsel (27.10oS, 109.40oW) nach Lima (12.10oS, 77.05o W)
(distanzAB -27.10 -109.40 -12.10 -77.05)

;; 2.2 Anfangskurs
;(define (anfangskurs breiteA laengeA breiteB laengeB)
;  (my-acos (/ (- (sin breiteB) (* (dG breiteA laengeA breiteB laengeB) (sin breiteA))) (* (cos breiteA) (/ (sin  (dG breiteA laengeA breiteB laengeB)) (tan (dG breiteA laengeA breiteB laengeB)))))))

;; 2.3 Himmelsrichtungen
; Grad in Himmelsrichtung
; 0         Grad -> N
; 1-44      Grad -> NNE
; 45        Grad -> NE
; 46-89     Grad -> ENE
; 90        Grad -> E
; 91-134    Grad -> ESE
; 135       Grad -> SE
; 136-179   Grad -> SSE
; 180       Grad -> S
; 181-224   Grad -> SSW
; 225       Grad -> SW
; 226 - 269 Grad -> WSW
; 270       Grad -> W
; 271-314   Grad -> WNW
; 315       Grad -> NW
; 316-359   Grad -> NNW
; 360       Grad -> N
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
                                                                     

; Himmelsrichtung in Grad
; Parameterübergabe in String
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
        