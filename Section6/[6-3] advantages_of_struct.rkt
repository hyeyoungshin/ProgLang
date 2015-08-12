; Section 6: Advantages of Structs

; Contrasting Approaches

;            -----------------------------------------
;                (struct add (e1 e2) #:transparent)
;            -----------------------------------------

;  versus

;            ----------------------------------------------
;                (define (add e1 e2) (list 'add e1 e2))
;                (define (add? e) (eq? (car e) 'add))
;                (define (add-e1 e) (car (cdr e)))
;                (define (add-e2 e) (car (cdr (cdr e))))
;            ----------------------------------------------

;  This is not a case of syntactic sugar





; The key difference

;  The result of calling (add x y) is not a list
;    - And there is no list for which add? returns #t

;  struct makes a new kind of thing: extending Racket with a new
;  kind of data

;  So calling car, cdr, or mult-e1 on "an add" is a run-time error





; List apporach is error-prone

;                 ---------------------------------------------
;                     (define (add e1 e2) (list 'add e1 e2))
;                     (define (add? e) (eq? (car e) 'add))
;                     (define (add-e1 e) (car (cdr e)))
;                     (define (add-e2 e) (car (cdr (cdr e))))
;                 ----------------------------------------------

;  Can break abstraction by using car, cdr, and list-library
;  functions directly on "add expressions"
;    - Silent likely error:
;        (define xs (list (add (const 1) (const 4)) ..))
;        (car (car xs))

;  Can make data that add? wrongly answers #t to
;        (cons 'add "I am not an add")





; Summary of advantages

;  Struct approach:
;    - Is better style and more concise for defining data types
;    - Is about equally convenient for using data types
;    - But much better at timely errors when misusing data types
;        - Cannot accessor functions on wrong kind of data
;        - Cannot confuse tester functions





; More with abstraction

;  Struct approach is even better combines with other Racket features
;  not discussed here:

;  - The module system lets us hide the constructor function to 
;    enforce invariants
;        - List-apprach cannot hide cons from clients
;        - Dynamically-typed languages can have abstract types by
;          letting modules define new types!

;  - The contract system lets us check invariants even if constructor 
;    is exposed
;        - For example, fields of "an add" must also be "expressions"




; Struct is special

;  Often we end up learning that some convenient feature could be
;  coded up with other features

;  Not so with struct definitions:
;    - A function cannot introduce multiple bindings
;    - Neither functions nor macros can create a new kind of data
;        - Result of constructor function returns #f for every other
;          tester function: number?, pair?, other structs' tester
;          funtions, etc.


#lang racket
