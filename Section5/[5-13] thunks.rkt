; Section 5: Delayed evaluation

; Delayed evaluation

;  For each language construct, the semantics specifies when
;  sub expressions get evaluated. In ML, Racekt, Java, C:
;    - Function arguments are eager (call-by-value)
;        - Evaluated once before calling the function
;    - Conditional branches are not eager

;  In means: calling factorial-bad never terminates:
#lang racket
(provide (all-defined-out))

(define (factorial-normal x)
  (if (= x 0)
      1
      (* x (factorial-normal (- x 1)))))

(define (my-if-bad x y z)
  (if x y z))

(define (factorial-bad n) ; calling with any number never terminates
  (my-if-bad (= n 0)
             1
             (* n (factorial-bad (- n 1)))))

; y and z should be zero-argument functions (delays evaluation)
(define (my-if-strange-but-works x y z)
  (if x (y) (z))) ; (e): zero argument function

(define (factorial-okay x)
  (my-if-strange-but-works
   (= x 0)
   (lambda() 1)
   (lambda() (* x (factorial-okay (- x 1))))))





; Thunks delay

;  We know how to delay evaluation: put expression in a function!
;    - Thanks to closures, can use all the same variables later

;  A zero-argument function used to delay evaluation is called a thunk
;    - As a verb: thunk the expression

;  This works (but is silly to wrap if like this):
(define (my-if x y z)
  (if x (y) (z)))

(define (fact n)
  (my-if (= n 0)
         (lambda() 1)
         (lambda() (* n (fact (- n 1))))))





; The key point

;  Evaluate an expression e to get a result"
;                      e

;  A function that when called, evaluates e and returns result
;    - Zero-argument function for "thunking"
;                (lambda () e)

;  Evaluate e to some thunk and then call the thunk
;                      (e)

;  Next: Powerful idioms related to delaying evaluation and/or
;  avoided prepeated or unnecessary computations

