; Section 5: Memoization

; Memoization

;  If a function has no side effects and does not read mutable
;  memory, no point in computing it twice for the same arguments
;    - Can keep a cache of previous results
;    - Net win if (1) maintaining cache is cheaper than recomputing
;      and (2) cached results are reused

;  Similar to promises, but if the function takes arguments, then
;  there are multiple "previous results"

;  For recursive functions, this memoization can lead to 
;  exponentially faster programs
;    - Realted to algorithmic technique of dynamic programming


#lang racket

(provide (all-defined-out))

(define (fibonacci1 x)               ; fibonacci # methematically :
  (if (or (= x 1) (= x 2))           ; if (x = 1) or (x = 2)
      1                              ; then 1
      (+ (fibonacci1 (- x 1))        ; otherwise, the sum of fibonacci of (x - 1) 
         (fibonacci1 (- x 2)))))     ; and (x - 2)

(define (fibonacci2 x)
  (letrec ([f (lambda (acc1 acc2 y)  
                (if (= y x)
                    (+ acc1 acc2)
                    (f (+ acc1 acc2) acc1 (+ y 1))))])
    (if (or (= x 1) (= x 2))
        1
        (f 1 1 3))))


; library function "assoc"
; > (define xs (list (cons 1 2) (cons 3 4) (cons 5 6)))
; > xs
; '((1 . 2) (3 . 4) (5 . 6))
; > (assoc 3 xs)
; '(3 . 4)
; > (assoc 1 xs)
; '(1 . 2)
; > (assoc 6 xs)
; #f

; keeping around all the previous result in a table
; instead of making two expensive recursive calls
; we make one recursive call, and then for the next recusive call
; everything is already in the table
; twice as faster at every level
; 2 ^ x => x
(define fibonacci3                    
  (letrec ([memo null]                                          ; memo = list of pairs (arg . result)
           [f (lambda (x) 
                (let ([ans (assoc x memo)])
                  (if ans                                       ; if we find our answer in the table
                      (cdr ans)                                 ; return the cdr of the pair
                      (let ([new-ans (if (or (= x 1) (= x 2))   ; otherwise,  compute it
                                         1
                                         (+ (f (- x 1))
                                            (f (- x 2))))])
                        (begin                                     ; change via set! memo to hold a bigger list: 
                          (set! memo (cons (cons x new-ans) memo)) ; take the old list memo, cons on to it the pair of our new argument result pair
                           new-ans)))))])                          ; then return the result of the computation
    
    f))

; Memoization:

;  Create a table
;  always check it first, if found it, do mothing else
;  otherwise, compute answer, before return, we add it to our table for the future