(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)



(* 1. Takes a string list and returns a string list that has only the strings in the argument that start with an uppercase letter. Assume all strings have at least 1 character. Use List.filter, Char.isUpper, and String.sub to make a 1-2 line solution. *)
fun only_capitals xs =
    List.filter (fn x => Char.isUpper (String.sub (x,0))) xs  



		
(* 2. Takes a string list and returns the longest string in the list. If the list is empty, return " ". In the case of a tie, return the string closest to the beginning of the list. Use foldl, String.size, and no recursion (other than the implementation of foldl *) 
fun longest_string1 xs =
    foldl (fn (x,y) => if String.size x > String.size y then x else y) " " xs
		      




(* 3. is exactly like longest_string1 except in the case of ties returns the string cloestest to the end of the list. The solution should be almost an exact copy of longest_string1. Still use foldl and String.size *) 
fun longest_string2 xs =
    foldl (fn (x,y) => if String.size x >= String.size y then x else y) " " xs
	  




(* 4. write funtions longest_string_helper, longest_string3, and longest_string4 such that:

  - longest_string3 has the same behavior as longest_string1 and longest_string4 has the same behavior as longest_string2

  - longest_string_helper has type (int * int -> bool) -> string list -> string (notice the currying). This function will look a lot like longest_string1 and longest_string2 but is more general because it takes a function as an argument.

  - If longest_string_helper is passed a funtion that behaves like > (so it returns true exactly when its first argument is strictly greater than its second), then the function returned has the same behavior as longest_string1. 

  - longest_string3 and longest_string4 are defined with val-bindings and partial applications of longest_string_helper.

 *)
fun longest_string_helper f xs =
    foldl f " " xs

	  
val longest_string3 = longest_string_helper (fn (x,y) => if String.size x > String.size y
							 then x
							 else y)

val longest_string4 = longest_string_helper (fn (x,y) => if String.size x >= String.size y
							 then x
							 else y)






(* 5. takes a string list and returns the longest string in the list that begins with an uppercase letter, or " " if there are no such strings. Assume all strings have at least 1 character. Use a val-binding and the ML library's o operator for composing functions. Resolve ties like in problem 2. *)
val longest_capitalized = longest_string1 o only_capitals 







(* 6. takes a string and returns the string that is the same characters in reverse order. Use ML's o operator, the library function rev for reversing lists, and two library functions in the String module. (Browse the module documentation to find the most useful functions. *)
val rev_string  = implode o rev o explode
						


