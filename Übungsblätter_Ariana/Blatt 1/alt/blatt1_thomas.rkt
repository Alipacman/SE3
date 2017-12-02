#lang racket


(define (my-acos cos)
  (* 2 (atan(sqrt(/ (- 1 cos) (+ 1 cos))))))

(define (dr grad)
  (* grad (/ (* 2 pi) 360)))

(define (rd radians)
  (* radians (/ 360 (* 2 pi))))

(define (nm->km nm)
  (* nm 1.852))


(define (distanzAB A An B Bn)
  (nm->km(* 60 (rd(acos(+ (* (sin (dr A)) (sin (dr B))) (* (cos (dr A)) (cos (dr B))(cos (dr(- Bn  An))))))))))


(distanzAB 59.91 10.73 22.39 114.10)
(distanzAB 37.75 -122.45 21.32 -157.83)
(distanzAB -27.10 -109.40 -12.10 -77.05)


(define (G->H G)
  (cond
    [(<= G 180) (cond
                  [(= G 180) 'S]
                  [(> G 135) 'SSE]
                  [(= G 135) 'SE]
                  [(> G 90) 'ESE]
                  [(= G 90) 'E]
                  [(> G 45) 'ENE]
                  [(= G 45) 'NE]
                  [(> G 0) 'NNE]
                  [(= G 0) 'N])
                ]
    [else (cond
            [(= G 360) 'N]
            [(> G 315) 'NWN]
            [(= G 315) 'NW]
            [(> G 270) 'WNW]
            [(= G 270) 'W]
            [(> G 225) 'WSW]
            [(= G 225) 'SW]
            [(> G 180) 'SSW]
            )]))

(define (H->G H)
  (cond
    [(equal? H "S") '180]
    [(equal? H "SSE") write "136 - 179"]
    [(equal? H "SE") '135]
    [(equal? H "ESE") write "91 - 134"]
    [(equal? H "E") '90]
    [(equal? H "ENE") write "46 - 89"]
    [(equal? H "NE") '45]
    [(equal? H "NNE") write "1-44" ]
    [(equal? H "N") write "0 oder 360"]
    [(equal? H "NWN") write "316 - 359"]
    [(equal? H "NW") '315]
    [(equal? H "WNW") write '"271 - 314"]
    [(equal? H "W") '270]
    [(equal? H "WSW") write "226 - 269"]
    [(equal? H "SW") '225]
    [(equal? H "SSW") write "181 - 224"]
    ))
                