#lang racket
(define (fib n)
  (if (< n 3) 1 (+ (fib(- n 1)) (fib(- n 2)))))

(define (fak n)
  (if (= n 0) 1 (* n (fak(- n 1)))))

(define (potenzR r n)
  (cond
    [(= n 1) (display 1)]
    [(odd? n) (* r (potenzR r (- n 1)))]
    [(even? n) (expt (expt r (/ n 2)) 2) ]
    ))


(define miau 'plueschi)
(define katze miau)
(define tiger 'miau)

(define (welcherNameGiltWo PersonA PersonB)
  (let ((PersonA 'Sam) (PersonC PersonA))
    PersonC))

(define xs1 '(0 2 3 miau katze))
(define xs2 (list miau katze))
(define xs3 (cons katze miau))

(define (euler e)
  (if (>= e 0) (+ (/ 1 (fak e)) (euler (- e 1))) 0))

(define (type-of list)
  (cond
    [(boolean? list) 'boolean]
    [(pair? list) 'pair]
    [(list? list) 'list]
    [(symbol? list) 'symbol]
    [(number? list) 'number]
    [(char? list) 'char]
    [(string? list) 'string]
    [(vector? list) 'vector]
    [(procedure? list) 'procedure]))



