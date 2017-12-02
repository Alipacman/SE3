#lang racket


;Probeklausur
(define (make-length zahl maß)
  (list zahl maß))

(define probezahl (make-length 3 'cm))
(define probezahl2 (make-length 4 'm))


(define (value-of-length len)
  (car len))

(define (unit-of-length len)
  (cadr len))

(define (scale-length len fac)
  (list (* (car len) fac) (cadr len)))

(define *conversiontable*
  '((m . 1)
    (cm . 0.01)
    (mm . 0.001)
    (km . 1000)
    (inch . 0.0254)
    (feet . 0.3048)
    (yard . 0.9144)))

(define probeliste '((6 km)(2 feet)(10 cm)(3 inch)(1 mm)))


(define (factor unit)
  (cdr (assoc unit *conversiontable*)))

(define (length->meter len)
  (list (* (value-of-length len) (factor (unit-of-length len)))
        'm))

(define (length< len1 len2)
  (< (car (length->meter len1)) (car (length->meter len2))))

(define (length= len1 len2)
  (= (car (length->meter len1)) (car (length->meter len2))))

(define (length+ len1 len2)
  (+ (car (length->meter len1)) (car (length->meter len2))))

(define (length- len1 len2)
  (- (car (length->meter len1)) (car (length->meter len2))))


(filter (curry < 1)(map value-of-length (map length->meter probeliste)))

(apply min (map value-of-length (map length->meter probeliste)))
