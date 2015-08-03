#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; Problems:

;  1. Write a function 'sequence' that takes 3 arguments low, high, and stride,
;     all assumed to be numbers.Further assume stride in positive. sequence
;     produces a list of numbers from low to high (including low and possibly 
;     high) separated by stride and in sorted order. Sample solution: 4 lines.

;     Examples: > (sequence 3 11 2) => '(3 5 7 9 11)
;               > (sequence 3 8 3) => '(3 6)
;               > (sequence 3 2 1) => ()
(define (sequence low high stride)
   (if (and (> (+ low stride) high) (> low high))
               null
               (cons low (sequence (+ low stride) high stride))))


;  2. Write a function 'string-append-map' that takes a list of strings xs and
;     a string suffix and returns a list of strings. Each element of the output
;     should be the corresponding element of the input appended with suffix 
;     (with no extra space between the element and suffic). You must use 
;     Raket-library functions map and string-append. Sample solution: 2 lines.
(define (string-append-map xs suf)
  (map (lambda (st) (string-append st suf)) xs))


;  3. Write a function 'list-nth-mod' tht takes a list xs and a number n. If
;     the number is negative, terminate the computation with (error "list-nth-
;     mod: negative number"). Else if the list is empty, terminate the 
;     computation with (error "list-nth-mod: empty list"). Else return the ith
;     element of the list where we count from zero and i is the remainder
;     produced when dividing n by the list's length. Library functions length,
;     remainder, car and list-tail are all useful - see the Racket documentation.
;     Sample solution is 6 lines.
(define (list-nth-mod xs n)
  (letrec ([ith (lambda (list i) 
               (car (list-tail list i)))])
  (cond  [(< n 0) (error "list-nth-mod: negative number")]
         [(empty? xs) (error "list-nth-mod: empty list")]
         [#t (ith xs (remainder n (length xs)))])))


;  4. Write a function stream-for-n-steps that takes a stream s and a number n.
;     It returns a list holding the first n values produced by s in order. 
;     Assume n is non-negative. Sample solution: 5 lines. Note: You can test
;     your streams with this function instead of the graphics code. 
(define (stream-for-n-steps s n)
  (letrec ([f (lambda (stream acc)
              (if (= acc n)
                 null   
                 (cons (car (stream)) (f (cdr (stream)) (+ acc 1)))))])
  (f s 0)))


;  5. Write a stream 'funny-number-stream' that is like the stream of natural
;     numbers (i.e., 1, 2, 3, ...) except numbers divisible by 5 are negated
;     (i.e., 1, 2, 3, 4, -5, 6, 7, 8, 9, -10, 11 ...). Remember a stream is 
;     a thunk that when called produces a pair. Here the car of the pair will
;     be a number and the cdr will be another stream.
(define funny-number-stream 
  (letrec ([f (lambda (x) (if (= (remainder x 5) 0) 
                              (cons (- x) (lambda () f (+ (abs x) 1)))
                              (cons x (lambda () f (+ x 1)))))])
    (lambda () (f 1))))






























