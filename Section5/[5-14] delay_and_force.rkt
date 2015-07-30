; Section 5: Avoiding Unnecessary Computations

; Avoiding expensive computations

;  Thunks let you skip expensive computations if they are not needed 

;  Great if you take the tru-branch:
;                     (define (f th)
;                       (if (...) 0 (... (th) ...)))

;  But worse if you end up using the thunk more than once:
;                     (define (f th)
;                       (... (if (...) 0 (... (th) ...))
;                       (if (...) 0 (... (th) ...))
;                       ...
;                       (if (...) 0 (... (th) ...))))
;
;  In general, might not know how many times a result is needed

#lang racket
(provide (all-defined-out))

; this is a silly addition function that purposely runs slow for
; demonstration purposes
(define (slow-add x y)
  (letrec ([slow-id (lambda (y z)
                      (if (= 0 z)
                          y
                          (slow-id y (- z 1))))])
    (+ (slow-id x 50000000) y)))

; multiples x and result of y-thunk, calling y-thunk x times
(define (my-mult x y-thunk)
  (cond [(= x 0) 0]
        [(= x 1) (y-thunk)]
        [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))]))


; but if you remember the answer so in the future we didn't have to 
; compute it again
; (my-mult 2 (let ([x (slow-add 3 4)]) (lambda() x)))





; Best of both worlds

;  Assuming some expensive computation has no side effects, ideally
;  we would:
;    - Not compute it until needed
;    - Remember the answer so future uses complete immediately
;    - Called lazy evaluation

;  Languages where most constructs, including function arguments,
;  work this way are lazy languages
;    - Haskell

;  Racket predefines support for promises, but we can make our own
;    - Thunks and mutable pairs are enough
