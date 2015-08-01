; Section 5: Defining Streams

; Streams

;  Coding up a stream in your program is easy
;    - We will do functional streams using pairs and thunks

;  Let a stream be a thunk that when called returns a pair:
;                '(next-answer . next-thunk)

;  Saw how to use them, now how to make them
;    - Admittedly mind-bending, but uses what we know

#lang racket

; 1 1 1 1 1 1 ...
; (define ones (lambda () (cons 1 (lambda() (cons 1 (lambda() (cons 1 ...) 
(define ones (lambda () (cons 1 ones)))

; 1 2 3 4 5 ...
(define (f x) (cons x (lambda () (f (+ x 1)))))
(define nats (lambda () (f 1)))

(define nats-better-style
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

; 2 4 8 16 ...
(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 2))))

; a helper function                                                    
(define (stream-maker fn arg)
  (letrec ([f (lambda (x) (cons x (lambda () (f (fn x arg)))))])
    (lambda () (f arg))))

(define nats2 (stream-maker + 1))

(define powers2 (stream-maker * 2))


