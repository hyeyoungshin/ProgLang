; Section 6: What Your Interpreter Can and Cannot Assume

; What we know

;  - Define (abstract) syntax of language B with Racket structs
;    - B called MUPL in homework
;  - Write B programs directly in Racket via constructors
;  - Implement interpreter for B as a (recursive) Racket function

;  Now, a subtle-but-important distinction:
;    - Interpreter can assume input is a "legal AST for B"
;        - Okay to give wrong answer or inscrutable error otherwise
;    - Interpreter must check that recursive results are the right
;      kind of value
;        - Give a good error message otherwise





; Legal ASTs

;  - "Trees the interpreter must handle" are a subset of all the trees
;     Racket allows as a dynamically types language
;                  --------------------------------------------
;                     (struct const (int) #:transparent)
;                     (struct negate (e) #:transparent)
;                     (struct add (e1 e2) #:transparent)
;                     (struct multiply (e1 e2) #:transparent)
;                  ---------------------------------------------

;  - Can assume "right types" for struct fields
;    - const holds a number
;    - negate holds a legal AST
;    - add and multiply hold 2 legal ASTs

;  - Illegal ASTs can "crash the interpreter" - this is fine
;       --------------------------------------------------------------
;          (multiply (add (const 3) "uh-oh") (const 4)) (negate -7)
;       --------------------------------------------------------------





; Interpreter results

;  - Our interpreters return expressions, but not any expressions
;    - Result should always be a value, a kind of expression that
;      evaluates to itself
;    - If not, the interpreter has a bug

;  - So far, only values are from const, e.g., (const 17)

;  - But a larger langauge has more values than just numbers
;    - Booleans, strings, etc
;    - Pairs of values (definition of value recursive)
;    - Closures
;    - ...





; Example

;  See code for language that adds, booleans, number-comparison, and
;  conditionals:
;               ----------------------------------------------------
;                  (struct bool (b) #:transparent)
;                  (struct eq-num (e1 e2) #:transparent)
;                  (struct if-then-else (e1 e2 e3) #:transparent)
;               ----------------------------------------------------

;  What if the program is a legal AST, but evaluation of it tries to use
;  the wrong kind of value?
;    - For example, "add  a boolean"
;    - You should detect this and give an error message not in 
;      terms of the interpreter implementation
;    - Means checking a recursive result whenever a particular kind of 
;      value is needed
;        - No need to check if any kind of value is okay







#lang racket

(provide (all-defined-out))

; a larger language with two kinds of values, booleans and numbers
; an expression is any of these:
(struct const (int) #:transparent) ; int should hold a number
(struct negate (e1) #:transparent) ; e1 should hold an expression
(struct add (e1 e2) #:transparent) ; e1, e2 should hold expressions
(struct multiply (e1 e2) #:transparent) ; e1, e2 should hold expressions
(struct bool (b) #:transparent) ; b should hold #t or #f
(struct eq-num (e1 e2) #:transparent) ; e1, e2 shold hold expressions
(struct if-then-else (e1 e2 e3) #:transparent) ; e1, e2, e3 should hold 
                                               ; expressions

; a value in this language is a legal const or bool

(define test1 (multiply (negate (add (const 2)
                                     (const 2)))
                        (const 7)))

(define test2 (multiply (negate (add (const 2)
                                     (const 2)))
                        (if-then-else (bool #f)
                                      (const 7)
                                      (bool #t)))) ; multiplying -4 with true

(define non-test (multiply (negate (add (const #t)
                                        (const 2)))
                           (const 7))) ; not a legal AST -> we don't have to 
                                       ; handle it gracefully

(define (eval-exp-wrong e)
  (cond [(const? e) 
         e]
        [(negate? e)
         (const (- (const-int (eval-exp-wrong (negate-e1 e)))))]
        [(add? e)
         (let ([i1 (const-int (eval-exp-wrong (add-e1 e)))]
               [i2 (const-int (eval-exp-wrong (add-e2 e)))])
           (const (+ i1 i2)))]
        [(multiply? e)
         (let ([i1 (const-int (eval-exp-wrong (multiply-e1 e)))]
               [i2 (const-int (eval-exp-wrong (multiply-e2 e)))])
           (const (* i1 i2)))]
        [(bool? e)
         e]
        [(eq-num? e)
         (let ([i1 (const-int (eval-exp-wrong (eq-num-e1 e)))]
               [i2 (const-int (eval-exp-wrong (eq-num-e2 e)))])
           (bool (= i1 i2)))]
        [(if-then-else? e)
         (if (bool-b (eval-exp-wrong (if-then-else-e1 e)))
             (eval-exp-wrong (if-then-else-e2 e))
             (eval-exp-wrong (if-then-else-e3 e)))]
        [#t (error "eval-exp expected an exp")]
        ))

(define (eval-exp e)
  (cond [(const? e)
         e]
        [(negate? e)
         (let ([v (eval-exp (negate-e1 e))])
           (if (const? v)
               (const (- (const-int v)))
               (error "negate applied to non-number")))]
        [(add? e)
         (let ([v1 (eval-exp (add-e1 e))]
               [v2 (eval-exp (add-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (+ (const-int v1) (const-int v2)))
               (error "add applied to non-number")))]
        [(multiply? e)
         (let ([v1 (eval-exp (multiply-e1 e))]
               [v2 (eval-exp (multiply-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (* (const-int v1) (const-int v2)))
               (error "multiply applied to non-number")))]
        [(bool? e)
         e]
        [(eq-num? e)
         (let ([v1 (eval-exp (eq-num-e1 e))]
               [v2 (eval-exp (eq-num-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (= (const-int v1) (const-int v2)))
               (error "eq-num applied to non-number")))]
        [(if-then-else? e)
         (let ([v-test (eval-exp (if-then-else-e1 e))])
           (if (bool? v-test)
               (if (bool-b v-test)
                   (eval-exp (if-then-else-e2 e))
                   (eval-exp (if-then-else-e3 e)))
               (error "if-then-else applied to non-boolean")))]
        [#t (error "eval-exp expected an exp")]
        ))
         


               
                           


