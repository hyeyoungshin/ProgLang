; Section 5: Top-level bindings

; Top-level

;  The bindings in a file work like local defines, i.e., letrec
;    - Like ML, you can refer to earlier bindings
;    - Unlike ML, you can also refer to later bindings
;    - But refer to later bindings only in function bodies
;        - Because bindings are evaluated in order
;        - An error to use an undefined variable
;    - Unlike ML, cannot define the same variable twice in module
;        - Would make no sense: cannot have both in environment

#lang racket

(provided (all-defined-out))

(define (f x) (+ x b))) ; forward reference okay here
(define b 3)
(define c (+ b 4)) ; backward reference okay
;(define d (+ e 4)) ; not okay (get an error instead of #<undefined>
(define e 5)
;(define f 17) ; not okay: f already defined in this module





; REPL

;  Unfortunate detail:
;    - REPL works slightly differently
;        - Not quite let* or letrec
;    - Best to avoid recursive function definitions or forward
;      references in REPL
;        - Actually okay unless shadowing something (you may noy
;          know about) - then weirdness ensues
;        - And calling recursive fuctions is fine of course





; Optional: Actually...

;  Will study Racekt's module system in next section (optional)
;    - Each file is implicitly a module
;        - Not really "top-level"
;    - A module can shadow bindings from other modules it uses
;        - Including Racket standard library
;    - So we could redefine + or any other function
;        - But poor style
;        - Only shadows in our module (else messes up rest of
;          standard library)

; (Optional note: Scheme is different)
