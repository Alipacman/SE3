#lang racket
(max (min 2 (- 2 3)))
`(+ (unquote (- 2 4)) 2)
(car '(Alle meine Entchen))
(cdr '((schwimmen auf) (dem See)))
(cons 'Listen  'sind)
(cons 'Listen  '())
(equal? (list 'Java 'Racket 'Prolog) '(Java Racket Prolog))
(eq? (list ''Racket 'Prolog 'Java)
     (cons 'Racket '(Prolog Java)))
(map (lambda (x) (+ x x x))
     '(1 2 3))
(filter even? '(1 2 3 4 5))
((curry min 7) 2)
((curry = 2) 2)

(define *a* 10)
(define *b* '*a*)

(define (merke x)
  (lambda () x))

(or (> *a* 9) (> *b* 0))
(+ 2 ((merke 3)))

(define (test x)
  (let ((x (+ x *a*)))
    (+ x 2)))

(define (c a b)
  (if (rational? a)
      (if (rational? b)
          (sqrt (+ (sqr a)(sqr b)))
          (displayln "b ist keine rationale Zahl"))
      (displayln "a ist keine rationale Zahl")))

(define (mytan alpha)
  (if (and (< (- (/ pi 2)) alpha) (< alpha (/ pi 2)))
      (/ (sin alpha) (sqrt (- 1 (sqr (sin alpha)))))
      (displayln "Der Wert liegt nicht im erlaubten Bereich")))

(- (+ 1 (/ 4 2)) 1)
(/ (- 2 (/ (+ 1 3)(+ 3 (* 2 3))))
   (sqrt 3))

(define (make-length zahl maß)
  (list zahl maß))

(define (value-of-length x)
  (car x))

(define (value-of-unit x)
  (cadr x))

(define (scale-length len fac)
  (list (* (car len) fac) (cadr len)))

(define *conversiontable*
 '( (m . 1)
  (cm . 0.01)
  (mm . 0.001)
  (km . 1000)))

(define (factor unit)
  (cdr (assoc unit *conversiontable*)))