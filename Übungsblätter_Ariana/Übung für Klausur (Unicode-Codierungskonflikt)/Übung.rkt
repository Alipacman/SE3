#lang racket
;(+ 3 (- 6 7))
;
;(map (curry < 6) '(1 2 7 8))
;
;(map (curryr < 6) '(1 2 7 8))
;
;(map (curry + 1) '(1 2 3))
;
;(foldl * 1 '(2 3 4))
;
;(foldl + 0 '(2 3 4 0))
;
;(foldl max 3 '(10 4 5 6 5) '(2 7 6 9 8))
;
;(foldl cons '(2) '(1 2 3 4))
;
;(cdr '((B(e.i))(s.p)iel))
;
;
;(define miau 'Plueschi)
;(define katze miau)
;(define tiger 'miau)
;
;(define (welcherNameGiltWo PersonA PersonB)
;  (let ((PersonA 'Sam)
;        (PersonC PersonA))
;    PersonC))
;
;
;(define xs1 '(0 2 3 miau katze))
;(define xs2 (list miau katze))
;(define xs3 (cons katze miau))
;
;(let* ([x 6]
;       [y (* x x)])
;  (+ x y))
;
;(define *a* 10)
;(define *b* '*a*)
;
;(define (merke x)
;  (lambda () x))
;
;(define zahlen (quote (1 2 3)))

(define xs5 '(1 2))

(define (laengen xss)
  (letrec ([innere (lambda (liste)
                     (if (null? liste) '()
                         (list* (length (car liste))
                                (innere (cdr liste)))))])    
    (innere xss)))

(define listen '((1 2 3) () (a b) (a a a)))
(define liste '(1 1 2 3 1))

(define (laengen2 xss)
  (if (null? xss)'()
      (cons (length (car xss))
             (laengen2 (cdr xss)))))

(define (laengen4 xss)
  (if (null? xss)'()
      (list* (length (car xss))
             (laengen4 (cdr xss)))))

;(laengen listen)
(laengen2 listen)
(laengen4 listen)

(define (Anzahl-von item xs)
  (if (null? xs) 0
      (if (equal? item (car xs)) (+ 1 (Anzahl-von item (cdr xs)))
          (+ 0 (Anzahl-von item (cdr xs))))))

(define (Anzahl-von2 item xs)
  (letrec ([innere (lambda (liste gesucht)
                     (if (null? liste) 0
                         (if (equal? gesucht (car liste)) (+ 1 (innere (cdr liste) gesucht))
                             (+ 0 (innere (cdr liste) gesucht)))))])
    (innere xs item)))

(define liste1 '((1 . 3) (2 . 4) (3 . 5)))

(define (Anzahl-von3 item xs)
  (length (filter (curry = item) xs)))

(define (xliste xs)
  (letrec ([inner (lambda (list)
                    (if (empty? list) '()
                        (cons (caar list) (inner (cdr list)))))])
    (inner xs)))


;(xliste liste1)

(define (yliste xs)
  (letrec ([inner (lambda (list)
                    (if (empty? list) '()
                        (cons (cdar list) (inner (cdr list)))))])
    (inner xs)))

;(foldr append '((da) (steh) (ich) (nun)) '())

;(map char-upcase (string->list "test"))
(define testliste '(#\T #\E #\S #\T #\A #\B))

(define abc '(#\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z))

(define abc2 '(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z))
(define abc3 '((a) (b) (c)))

(define (häufigkeiten chars)
  (letrec ([innere (lambda (charliste buchstabe)
                     (if (empty? charliste) '()
                         (cons (cons (car buchstabe) (length (filter (curry equal? (car buchstabe)) charliste))) (innere (cdr charliste) (cdr buchstabe)))))])
    (innere chars abc)))

(häufigkeiten testliste)

(define (häufigkeiten2 chars)
  (letrec ([innere (lambda (charliste buchstabe)
                     (if (empty? buchstabe) '()
                         (cons (cons (car buchstabe) (length (filter (curry equal? (car charliste)) buchstabe))) (innere (cdr charliste) (cdr buchstabe)))))])
    (innere chars abc)))

(define (häufigkeiten3 chars)
  (letrec ([innere (lambda (charliste buchstabe)
                     (if (empty? charliste) '()
                         (if (empty? buchstabe) '()
                             (cons (cons (car buchstabe) (length (filter (curry equal? (car buchstabe)) charliste))) (innere (cdr charliste) (cdr buchstabe))))))])
(innere chars abc)))

(define (häufigkeiten4 chars)
  (map cons abc (map (lambda (a) (length (filter (curry equal? a) chars))) abc)))


;(define (derHäufigste chars)
;  (letrec ([inner (lambda (liste buchstabe max)
;                    (if (empty? list) '()
;                        (if (< max buchstabe