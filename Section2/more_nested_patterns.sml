(* Section 2: More Nested Patterns *)

fun nondecreasing xs = (* int list -> bool *)
    case xs of
	[] => true
      | _::[] => true
      | head::(neck::rest) => head <= neck andalso nondecreasing (neck::rest)

   
(*
      | x::xs' => case xs' of
		      [] => true
		    | y::ys' => x <= y andalso nondecreasing xs'
*)					     

datatype sgn = P | N | Z

fun multsign (x1,x2) = (* int*int -> sgn *)
    let fun sign x = if x=0 then Z else if x>0 then P else N
    in
	case (sign x1, sign x2) of
	    (Z,_) => Z (* three of nine cases *)
	  | (_,Z) => Z (* two of nine caes *)
	  | (P,P) => P
	  | (N,N) => P
	  | _ => N
		     (*
	  | (N,P) => N
	  | (P,N) => N *)
	end

(* warning: match nonexhastive => not all the cases are handled *)











(* compute length of list *)
	
fun len xs =
    case xs of
	[] => 0
      | _::xs' => 1 + len xs' (* We don't care the value of the head *)







			  
(* Style
- Nested patterns can lead to very elegant, concise code
 - Avoid nested case expressions if nested patterns are simpler and avoid unnecessary branches or let-expressions
  - Examples : unzip3 and nondecreasing
 - A common idiom is matching against a tuple of datatypes to compare them
  - Examples : zip3 and multsign

- Wildcards are good style: use them instead of variables when you do not need the data
 - Examples: len and multsign
*)
