#lang racket

(provide (all-defined-out))

; [second big difference from ML (and Java)] Dynamic Typing!!

; dynamic typing: can use values of any type anywhere
; e.g., a list that holds numbers or other lists -- with either lists
; or numbers nested arbitrarily deeply

(define (sum1 xs)
  (if (null? xs)
      0 
      (if (number? (car xs))
      (+ (car xs) (sum1 (cdr xs)))
      (+ (sum1 (car xs)) (sum1 (cdr xs))))))

(define xs (list 4 5 6))
