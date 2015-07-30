; Section 5 [7-12]: The Truth About cons

#lang racket
(provide (all-defined-out))





; The Truth about cons

;  cons just makes a pair
;    - Often called a cons cell
;    - By convention and standard library, lists are nested pairs that 
;      eventually end with null
(define pr (cons 1 (cons #t "hi"))) ; '(1 #t . "hi")
(define lst (cons 1 (cons #t (cons "hi" null))))
(define hi (cdr (cdr pr)))
(define hi-again (car (cdr (cdr lst))))
(define no (list? pr))
(define yes (pair? pr))
(define of-course (and (list? lst) (pair? lst)))

;  Passing an improper list to functions like length is a run-time error






