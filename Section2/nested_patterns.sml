(* Section 2: Nested Patterns *)

(* Nested Patterns 
- We can nest patterns as deep as we want
 - Just like we can nest expressions as deep as we want
 - Often avoids hard-to-read, wordy nested case expressions

- So the full meaning of pattern-matching is to compare a pattern against a value for the "same shape" and bind variables to the "right parts"
 - More precise recursive definition coming after examples
 *)









exception ListLengthMismatch

(* don't do this *)
fun old_zip3 (l1,l2,l3) =
    if null l1 andalso null l2 andalso null l3
    then []
    else if null l1 orelse null l2 orelse null l3
    then raise ListLengthMismatch
    else (hd l1, hd l2, hd l3) :: old_zip3(tl l1, tl l2, tl l3)




(* don't do this *)
fun shallow_zip3 (l1,l2,l3) =
    case l1 of
	[] =>
	(case l2 of
	     [] => (case l3 of
			[] => []
		      | _ => raise ListLengthMismatch)
	   | - => raise ListLengthMismatch)
      | hd1::tl1 =>
	(case l2 of
	     [] => raise ListLengthMismatch
	   | hd2::tl2 => (case l3 of
			      [] => raise ListLengthMismatch
			    | hd3::tl3 =>
			      (hd1,hd2,hd3)::shallow_zip3(tl1,tl2,tl3)))
