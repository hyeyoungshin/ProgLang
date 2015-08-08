; Section 6: Datatype-Programming in Racket Without Structs

; Life without datatypes

;  Racket has nothing like a datatype binding for one-of types

;  No need in dynamically typed language:
;    - Can just mix values of different types and use primitives like
;      number?, string?, pair?, etc. to "see what you have"
;    - Can use cons cells to build up any kind of data

;  This segment: Coding up datatypes with what we already know

;  Next segment: Better apporach for the same thing with structs
;    - Contrast helps explain advantages of structs





; Mixed collections

;  In ML, cannot have a list of "ints or strings," so use a datatype:

;              datatype int_or_string = I of int | S of string
;
;              fun funny_sum xs = (* int_or_string list -> int *)
;                 case xs of
;                      [] => 0
;                    | (I i)::xs' => i + funny_sum xs'
;                    | (S s)::xs' => String.size s + funny_sum xs'

;  In Racket, dynamic typing makes this natural without explicit tags
;    - Instead, every value has a tag with primitives to check it
;    - So just check car of list with number? or string?

#lang racket
(provide (all-defined-out))

; Note: arguably bad style to not have else clause
(define (funny-sum xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (funny-sum (cdr xs)))]
        [(string? (car xs)) (+ (string-length (car xs)) (funny-sum (cdr xs)))]))


