(* Section 2: A Little Type Inference *)

fun sum_triple1 (x, y, z) =
    x + y + z

fun full_name1 {first=x, middle=y, last=z} =
    x ^ " " ^ y ^ " " z

(* these versions will not type-check without type annotations because the type-checker cannot figure out if there might be other field *)

fun sum_triple2 (triple: int*int*int) =
    #1 triple + #2 triple + #3 triple

(* 

fun sum_triple2 triple =
    #1 triple + #2 triple + #3 triple
*)

fun full_name2 (r: {first:string, middle:string, last:string}) =
    #first r ^ " " ^ #middle r ^ " " ^ #last r

(* What is the type of the following function? *)

fun mystery x =
    case x of
	(1,b,c) => #2 x + 10
      | (a,b,c) => a * c

(*
Answer: int*int*int -> int 
Explanation: The #2 does not mean SML can't infer any types. This function must be of type int*int*int -> int because it uses triple patterns on the argument that specify each component to be an int.

The first pattern makes it easy to infer the first component to be an int because it is matched to a value of 1. Also, the second component is used in an addition with an int.

The second pattern ensures the third component must be an int because it multiplies it with the first component.

Finally, the result of the function must be an int because the result of the case expression is either an addition of two ints or an int multiplication. 
*)
			   
					     
					     
