; Section 5: mcons For Mutable Pairs

; cons cells are immutable

;  What if you wanted to mutate the contents of a con cell?
;    - In Racekt you cannot (major change from Scheme)
;    - This is good
;        - List-aliasing irrelevant
;        - Implementation can make list? fast since listeness is 
;          determined when cons cell is created





; mcons cells are mutable

;  Since mutable pairs are sometimes useful (will use them soon),
;  Racket provides them too:
;    - mcons
;    - mcar
;    - mcdr
;    - mpair?
;    - set-mcar!
;    - set-mcdr!

;  Run-time error to use mcar on a cons cell or car on an mcons cell

#lang racket

