 #lang racket


;Aufg 1.1
(define (degrees->radians deg) (/ deg (/ 180 pi)))

(define (radians->degrees rad) (* rad (/ 180 pi )))

;Aufg 1.2

(define (my-acos x) (atan
                      (/
                       (sqrt
                        (- 1
                           (sqr (cos x))))
                           (cos x)
                      )))


;Aufg 1.3
(define (nm->km nm) (* nm 1852))

;Aufg 2.1
(define (Großkreisentfernung->km dg) (nm->km (*(radians->degrees dg) 60)) )

(define (distanzAB ab al bb bl) (Großkreisentfernung->km
                                 (acos (+
                                 (* (sin (degrees->radians ab)) (sin (degrees->radians bb)))
                                 (* (cos (degrees->radians ab)) (cos ( degrees->radians bb))
                                    (cos (abs(- (degrees->radians al) (degrees->radians bl)))))))))


;Von Oslo bis Hongkong = 8589412.217586055 km
(distanzAB 59.93 10.75 22.2 114.1)
;Von San Francisco bis Honolulu = 3844688.050487055 km
(distanzAB 37.75 -122.45 21.32 -157.83)
;Von Osterinsel bis Lima = 3757622.2188100554 km
(distanzAB -27.10 -109.4 -12.1 -77.05)



;Aufgabe 2.2
(define (AnfangskursWinkel dg a b)(acos
                                   (/
                                    (- (sin b) (* (cos dg) (sin a) ) )
                                    (* (cos a) (sin dg))
                             )))

(define (Normalisierung alpha) ( if (< 180 alpha)
                                    (- 360 alpha)
                                    alpha)
                                    )


;Aufg 2.3

(define (Grad->Himmelsrichtung grad ) (if (< grad 30)
                                          "N"
                                          (if (< grad 60)
                                              "NNE"
                                              (if (< grad 90)
                                                  "ENE"
                                                  (if (< grad 120)
                                                      "E"
                                                      (if (< grad 150)
                                                          "EES"
                                                          (if (< grad 180)
                                                              "SES"
                                                              (if (< grad 210)
                                                                  "S"
                                                                  (if (< grad 240)
                                                                      "SSW"
                                                                      (if (< grad 270)
                                                                          "WSW"
                                                                          (if (< grad 300)
                                                                              "W"
                                                                              (if (< grad 330)
                                                                                  "WWN"
                                                                                  (if (< grad 360)
                                                                                      "NWN"
                                                                                      "Invalid Input"
                                          )))))))))))))

(define (Himmelsrichtung->Grad HR) (if (string-locale=? HR "N") 0
                                       (if (string-locale=? HR "NNE") 30
                                           (if (string-locale=? HR "ENE") 60
                                               (if (string-locale=? HR "E") 90
                                                   (if (string-locale=? HR "EES") 120
                                                       (if (string-locale=? HR "SES") 150
                                                           (if (string-locale=? HR "S") 180
                                                               (if (string-locale=? HR "SSW") 210
                                                                   (if (string-locale=? HR "WSW") 240
                                                                       (if (string-locale=? HR "W") 270
                                                                           (if (string-locale=? HR "WWN") 300
                                                                               (if (string-locale=? HR "NWN") 330
                                                                                       "Invalid Input"
                                       )))))))))))))


