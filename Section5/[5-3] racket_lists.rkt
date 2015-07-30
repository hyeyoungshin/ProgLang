; Section 5 : Racket Lists

#lang racket

(provide (all-defined-out))

; list processing: null, cons, null?, car, cdr
; we won't use pattern-matching in Racket

; sum all the numbers in a list
(define (sum xs) 
  (if (null? xs) 
  0
  (+ (car xs) (sum (cdr xs)))))

; append
(define (my-append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (my-append (cdr xs) ys))))


(define (my-map f xs)
  (if (null? xs)
      null
      (cons (f (car xs)) (my-map f (cdr xs)))))