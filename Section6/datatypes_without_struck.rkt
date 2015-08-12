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
;            -----------------------------------------------------
;              datatype int_or_string = I of int | S of string
;
;              fun funny_sum xs = (* int_or_string list -> int *)
;                 case xs of
;                      [] => 0
;                    | (I i)::xs' => i + funny_sum xs'
;                    | (S s)::xs' => String.size s + funny_sum xs'
;            ------------------------------------------------------

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





; Recursive strctures

;  More interesting datatype-programming we know:
;               ------------------------------------------
;                  datatype exp = Const of int
;                               | Negate of exp
;                               | Add of exp * exp
;                               | Multiply of exp * exp
;               ------------------------------------------

;  exp -> int
;               --------------------------------------------------------------
;                  fun eval_exp e = 
;                     case e of
;                          Constant i => i
;                        | Negate e2 => ~ (eval_exp e2)
;                        | Add(e1,e2) => (eval_exp e1) + (eval_exp e2)
;                        | Multiply(e1,e2) => (eval_exp e1) * (eval_exp e2)
;               --------------------------------------------------------------


;  exp -> exp
;  this way is more painful here, but makes much more sense for
;  larger languages where recursive calls can return different 
;  kinds of things (e.g., numbers or pairs or functions or ... )

; exception Error of string

; fun eval_exp_new e =
;     let
;         fun get_int e = 
;             case e of
;                 Const i => i
;               | _ => raise (Error "expected Const result")
;     in          
;         case e of
;             Const _ => e
;           | Negate e2 => Const (~ (get_int (eval_exp_new e2)))
;           | Add(e1,e2) => Const ((get_int (eval_exp_new e1))
;                                   + (get_int (eval_exp_new e2)))
;           | Multiply(e1,e3) => Const ((get_int (eval_exp_new e1))
;                                       * (get_int (eval_exp_new e2)))
;     end





; Change how we do this

;    - Previous version of eval_exp has type exp -> int

;    - From now on will write such functions with type exp -> exp

;    - Why? because wil be interpreting languages with multiple
;      kinds of results (ints, pairs, functions, ...)
;        - Even though much more complicated for example so far

;    - How? 
;        - Base case returns entire expression, e.g., (Const 17)
;        - Recursive cases:
;            - Check variant (e.g., make sure a Const)
;            - Extract data (e.g., the number under the Const)
;            - Also return an exp (e.g., create a new Const)





; New way in Racket

;  See the Racket code file for coding up the same new kind of
;  "exp -> exp" interpreter
;    - Using lists where car of list ncodes "what kid of exp"

;  Key points:
;    - Define our own constructor, test-variant, extract-data functions
;        - Just better style than hard-to-read uses of car, cdr
;    - Same recursive structure without pattern-matching
;    - With no type system, no notion of "what is an exp" except in 
;      documentations
;        - But if we use the helper functions correctly, then okay
;        - Could add more explicit error-checking if desired




; now implement same idea as 
; datatype exp = Const of int | Negate of exp 
;              | Add of exp * exp | Multiply of exp * exp

; just helper functions that make lists where first element
; is a symbol
(define (Const i) (list 'Const i))
(define (Negate e) (list 'Negate e))
(define (Add e1 e2) (list 'Add e1 e2))
(define (Multiply e1 e2) (list 'Multiply e1 e2))

; just helper functions that test what "kind of exp"
; note: more robust could raise better errors for non-exp values
(define (Const? x) (eq? (car x) 'Conts))
(define (Negate? x) (eq? (car x) 'Negate))
(define (Add? x) (eq? (car x) 'Add))
(define (Multiply? x) (eq? (car x) 'Multiply))

; just helper functions that extracts the underlying value for 
; "one kind of exp"
; note: more robust could check "what kind of exp"
(define (Const-int e) (car (cdr e)))
(define (Negate-e e) (car (cdr e)))
(define (Add-e1 e) (car (cdr e)))
(define (Add-e2 e) (car (cdr (cdr e))))
(define (Multiply-e1 e) (car (cdr e)))
(define (Multiply-e2 e) (car (cdr (cdr e))))

; fyi: there are built-in functions for getting 2nd, 3rd list elements
;(define Const-int cadr)
;(define Negate-e cadr)
;(define Add-e1 cadr)
;(define Add-e2 caddr)
;(define Multiply-e1 cadr)
;(define Multiply-e2 caddr)

; same recursive structure as we have in ML, just without pattern-matching
; one change from what we did before: returning an exp, in particular
; a Constant, rather than an int
(define (eval-exp e)
  (cond [(Const? e) e]
        [(Negate? e) (Const (- 










