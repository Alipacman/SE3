#lang racket
(require se3-bib/tools-module)
(require racket/trace)


; Aufgabe 2 – Memo-Funktion

(trace-define (harmonisch-einfach n)
              (if (= n 1)
                  1
                  (+ (/ 1 n) (harmonisch-einfach (- n 1)))))

(define (harmonisch-zwei n)
  (if (= n 1)
      1
      (+ (/ 1 n) (harmonisch-zwei (- n 1)))))

(set! harmonisch-zwei (memo harmonisch-zwei))

(trace harmonisch-zwei)

(trace-define harmonisch-drei (memo (lambda (n)
                                       (if (= n 1)
                                           1
                                           (+ (/ 1 n) (harmonisch-drei (- n 1)))))))