#lang racket
(map (curry - 5) '(10 11 12 13))  ; - 5 als erster Parameter

(map (curryr - 5) '(10 11 12 13)) ; -5 als zweiter Parameter
