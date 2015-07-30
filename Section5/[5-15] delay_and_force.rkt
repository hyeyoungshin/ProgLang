; Section 5: Delay and Force

; Delay and Force
#lang racket
(provide (all-defined-out))





;  An ADT represented by a mutable pair
;    - #f in car means cdr is unevaluated thunk
;        - Really a one-of type: thunk or result-of-thunk
;    - Ideally hide representation in a module

; (from previous section)
(define (slow-add x y)
  (letrec ([slow-id (lambda (y z)
                      (if (= 0 z)
                          y
                          (slow-id y (- z 1))))])
    (+ (slow-id x 50000000) y)))

(define (my-mult x y-thunk)
  (cond [(= x 0) 0]
        [(= x 1) (y-thunk)]
        [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))]))


(define (my-delay th)
  (mcons #f th))

(define (my-force p)
  (if (mcar p)
      (mcdr p)
      (begin (set-mcar! p #t)
             (set-mcdr! p ((mcdr p)))
             (mcdr p))))

; Using promises
;
;           (define (f p)
;             (... (if (...) 0 (... (my-force p) ...))
;                  (if (...) 0 (... (my-force p) ...))
;                  ...
;                  (if (...) 0 (... (my-force p) ...))))

;           (f (my-delay (lambda () e)))

;  Example:
;           (my-mult x (let ([p (my-delay (lambda() (slow-add 3 4)))])
;              (lambda() (my-force p))))





; Lessons From Example

;  See code file for example that does multiplication using a very slow
;  addition helper function

;    - With thunking second argument:
;        - Great if first argument 0
;        - Okay if first argument 1
;        - Worse otherwise

;    - With precomputing second argument:
;        - Okay in all cases

;    - With thunk that uses a promise for second argument:
;        - Great if first argument 0
;        - Okay otherwise

