; Section 5: Mutation with set!

;  Set!

;   Unlike ML, Racket really has assignment statements
;       - But used only-when-really-appropriate!

;                  (set! x e)

;   For the x in the current environment, subsequent lookups of x 
;   get the result of evaluating expression e
;        - Any code using this x will be affected
;        - Like x = e in Java, C, Python, etc.

;   Once you have side-effects, sequences are useful:
;                  (begin e1 e2 ... en)

#lang racket

(provide (all-defined-out))





; Example

;  Example uses set! at top-level; mutating local variables is similar
(define b 3)
(define f (lambda (x) (* 1 (+ x b))))
(define c (+ b 4)) ; 7
(set! b 5)
(define z (f 4)) ; 9
(define w 3) ; 7

;  Not much new here:
;    - Environment for closure determined when function is defined, 
;      but body is evaluated when function is called
;    - Once an expression produces a value, it is irrelevant how the
;      value was produced





; Top-level

;  Mutating top-level definitions is particularly problematic
;    - What if any code could do set! on anything?
;    - How could we defend against this?

;  A general principle: If something you need not to change might
;  change, make a local copy of it. Example:
(define b 3)
(define f
  (let [b b])
  (lambda (x) (* 1 (+ x b))))

;  Could use a different name for local copy but do not need to





; But wait...

;  Simple elegant language design:
;    - Primitives like + and * are just predefined variables bound to
;      functions
;    - But maybe that means they are mutable
;    - Example continued:
(define f
  (let ([b b]
        [+ +]
        [* *])
    (lambda (x) (* 1 (+ x b)))))

;    - Even that won't work if f uses other functions that use things
;      that might get mutated - all functions would need to copy
;      everything mutable they used





; No such madness

;  In Racket, you do not have to program like this
;    - Each file is a module
;    - If a module does not use set! on a top-level variable, then
;      Racket makes it constant and forbids set! outside the module
;    - Primitives like +, *, and cons are in a module that does not
;      mutate them

;  Showed you this for the concept of copying to defend against mutation
;    - Easier defense: Do not allow mutation
;    - Mutable top-level bindings a highly dubious idea