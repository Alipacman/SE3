#lang racket

( require se3-bib/flaggen-module )
(require racket/gui/base)

;1.1

(define tafel '(
                (#\A . "Alpha")
                (#\B . "Bravo")
                (#\C . "Charlie")
                (#\D . "Delta")
                (#\E . "Echo")
                (#\F . "Foxtrot")
                (#\G . "Golf")
                (#\H . "Hotel")
                (#\I . "India")
                (#\J . "Juliet")
                (#\K . "Kilo")
                (#\L . "Lima")
                (#\M . "Mike")
                (#\N . "November")
                (#\O . "Oscar")
                (#\P . "Papa")
                (#\Q . "Quebec")
                (#\R . "Romeo")
                (#\S . "Sierra")
                (#\T . "Tango")
                (#\U . "Uniform")
                (#\V . "Viktor")
                (#\W . "Whisky")
                (#\X . "X-Ray")
                (#\Y . "Yankee")
                (#\Z . "Zulu")
                (#\0 . "Nadazero")
                (#\1 . "Unaone")
                (#\2 . "Duotwo")
                (#\3 . "Terrathree")
                (#\4 . "Carrefour")
                (#\5 . "Pentafive")
                (#\6 . "Soxisix")
                (#\7 . "Setteseven")
                (#\8 . "Oktoeight")
                (#\9 . "Novonine")
                (#\, . "Decimal")
                (#\. . "Stop")
                ))

;1.2

(define (give-char-pair x) (assoc x tafel ))

(define (give-Key x)  (cdr(give-char-pair x)) )

(give-Key #\A)
;1.3



(define (text-to-Key x)
  (
   define (make-list xs) (
                          if (empty? xs) xs
                             (cons (give-Key (car xs))
                                   (make-list (cdr xs))))
    )
  (make-list ( string->list x) 
  ))


(require racket/trace)
(trace text-to-Key)

(text-to-Key "FUCK69")


;2.1






(define flaggenalp '(
                (#\A . A)
                (#\B . B)
                (#\C . C)
                (#\D . D)
                (#\E . E)
                (#\F . F)
                (#\G . G)
                (#\H . H)
                (#\I . I)
                (#\J . J)
                (#\K . K)
                (#\L . L)
                (#\M . M)
                (#\N . N)
                (#\O . O)
                (#\P . P)
                (#\Q . Q)
                (#\R . R)
                (#\S . S)
                (#\T . T)
                (#\U . U)
                (#\V . V)
                (#\W . W)
                (#\X . X)
                (#\Y . Y)
                (#\Z . Z)
                (#\0 . Z0)
                (#\1 . Z1)
                (#\2 . Z2)
                (#\3 . Z3)
                (#\4 . Z4)
                (#\5 . Z5)
                (#\6 . Z6)
                (#\7 . Z7)
                (#\8 . Z8)
                (#\9 . Z9)
                ))


;2.2

(define (give-char-flag x) (assoc x flaggenalp ))

(define (give-flag x)  (cdr(give-char-flag x)) )


;2.3

(define (text-to-flag x)
  (
   define (make-list xs) (
                          if (empty? xs) xs
                             (cons (give-flag (car xs))
                                   (make-list (cdr xs))))
    )
  (make-list ( string->list x) 
  ))


(require racket/trace)
(trace text-to-flag)

(text-to-flag "FUCK69")
(list F S)


;3.1

(define morse-sound '(
                (#\A . (play-sound "Morse-A.wav" #f))
                (#\B . (play-sound "Morse-B.wav" #f))
                (#\C . (play-sound "Morse-C.wav" #f))
                (#\D . (play-sound "Morse-D.wav" #f))
                (#\E . (play-sound "Morse-E.wav" #f))
                (#\F . (play-sound "Morse-F.wav" #f))
                (#\G . (play-sound "Morse-G.wav" #f))
                (#\H . (play-sound "Morse-H.wav" #f))
                (#\I . (play-sound "Morse-I.wav" #f))
                (#\J . (play-sound "Morse-J.wav" #f))
                (#\K . (play-sound "Morse-K.wav" #f))
                (#\L . (play-sound "Morse-L.wav" #f))
                (#\M . (play-sound "Morse-M.wav" #f))
                (#\N . (play-sound "Morse-N.wav" #f))
                (#\O . (play-sound "Morse-O.wav" #f))
                (#\P . (play-sound "Morse-P.wav" #f))
                (#\Q . (play-sound "Morse-Q.wav" #f))
                (#\R . (play-sound "Morse-R.wav" #f))
                (#\S . (play-sound "Morse-S.wav" #f))
                (#\T . (play-sound "Morse-T.wav" #f))
                (#\U . (play-sound "Morse-U.wav" #f))
                (#\V . (play-sound "Morse-V.wav" #f))
                (#\W . (play-sound "Morse-W.wav" #f))
                (#\X . (play-sound "Morse-X.wav" #f))
                (#\Y . (play-sound "Morse-Y.wav" #f))
                (#\Z . (play-sound "Morse-Z.wav" #f))
                ))

;3.2

(define (give-char-sound x) (assoc x morse-sound ))

(define (give-sound x)  (cdr(give-char-sound x)) )

(give-sound #\E)

;3.3

(define (text-to-morse x)
  (
   define (make-list xs) (
                          if (empty? xs) xs
                             (cons (give-sound (car xs))
                                   (make-list (cdr xs))))
    )
  (make-list ( string->list x) 
  ))


(require racket/trace)
(trace text-to-morse)

(text-to-morse "FUCK69")

