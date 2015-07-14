(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer


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



		
(* 2. Takes a string list and returns the longest string in the list. If the list is empty, return "". In the case of a tie, return the string closest to the beginning of the list. Use foldl, String.size, and no recursion (other than the implementation of foldl *) 
fun longest_string1 xs =
    foldl (fn (x,y) => if String.size x > String.size y then x else y) "" xs
		      




(* 3. is exactly like longest_string1 except in the case of ties returns the string cloestest to the end of the list. The solution should be almost an exact copy of longest_string1. Still use foldl and String.size *) 
fun longest_string2 xs =
    foldl (fn (x,y) => if String.size x >= String.size y then x else y) "" xs
	  




(* 4. write funtions longest_string_helper, longest_string3, and longest_string4 such that:

  - longest_string3 has the same behavior as longest_string1 and longest_string4 has the same behavior as longest_string2

  - longest_string_helper has type (int * int -> bool) -> string list -> string (notice the currying). This function will look a lot like longest_string1 and longest_string2 but is more general because it takes a function as an argument.

  - If longest_string_helper is passed a funtion that behaves like > (so it returns true exactly when its first argument is strictly greater than its second), then the function returned has the same behavior as longest_string1. 

  - longest_string3 and longest_string4 are defined with val-bindings and partial applications of longest_string_helper.

 *)
fun longest_string_helper f xs =
    foldl f "" xs

	  
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
						





(* 7. Write a function first_answer of type ('a -> 'b option) -> 'a list -> 'b (notice the 2 arguments are curried.) The first argument should be applied to elements of the second argument in order until the first time it returns SOME v for some v and then v is the result of the call to first_answer. If the first argument returns NONE for all list elements, then first_answer should raise the exception NoAnswer. Hint: Sample solution is 5 lines and does nothing fancy. *)
fun first_answer f xs =
    let
	val mapped = List.map f xs
	val only_some = List.filter (fn x => isSome x) mapped 
    in 
	if null only_some
	then raise NoAnswer
	else valOf(hd only_some) 
    end
	
	
	  




(* 8. Write a function all_answers of type ('a -> 'b list option) -> 'a list -> 'b list option 
      (notice the 2 arguments are curried.) If it returns NONE for any element, then the result 
      for all_answers is NONE. Else the calls to the first argument will have produced 
      SOME lst1, SOME lst2, ... SOME lstn and the result of all_answers is SOME lst where lst 
      is lst1, lst2, ..., lstn appended together (order doesn't matter). 
      Hint: The sample solution is in 8 lines. It uses a helper function with an accumulator 
      and uses @. Note all_answers f [] should evaluate to SOME []. *) 
fun all_answers f xs =
    if null xs
    then SOME []
    else
	let
	    fun all_answers_aux (f: 'a -> 'b list option, xs: 'a list, acc: 'b list) : 'b list =
		case xs of
		    [] => acc
		  | x::xs' => case f x of
				  NONE => []
				| SOME y => all_answers_aux(f, xs', y @ acc)
        in
	    let val ans = all_answers_aux(f, xs, []) 
	    in	if null ans
		then NONE
		else SOME ans
	    end
	end





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

(* Given valu v and pattern p, either p matches v or not. If it does, the match produces 
   a list of string * valu pairs; order in the list does not matter. The rules for matching 
   should be unsurprising:

   - Wildcard matches everything and produces the empty list of bindings.
 
   - Variable s matches any value v and produces the one-element list holding (s,v)
  
   - UnitP matches only Unit and produces the empty list of bindings.

   - ConstP 17 matches only Const 17 and produces the empty list of bindings (and similarly
     for other integers).

   - TupleP ps matches a value of the form Tuple vs if ps and vs have the same length and
     and for all i, the ith element of ps matches the ith element of vs. The list of bindings
     produced is all the lists from the nested pattern matches appended together.

   - ConstructorP(s1,p) matches Constructor(s2,v) if s1 and s2 are the same string (you can
     compare them with =) and p matches v. The list of bindings produced is the list from 
     the nested pattern match. We call the string s1 and s2 the constructor name.

   - Nothing else matches.


  



  9. (This problem uses the pattern datatype but is not really about pattern-matching.)
    
   (a) Use g to define a function count_wildcards that takes a pattern and returns how 
       many Wildcard patterns it contains. *)
 fun count_wildcards p =
     g (fn x => 1) (fn y => 0) p


(* (b) Use g to define a function count_wild_and_variable_lengths that takes a pattern 
       and returns the number of Wildcard patterns it contains plus the sum of the string 
       legnths of all the variables in the variable patterns it contains. (Use String.size.
       We care only about variable names; the constructor names are not relevant.) *)

 fun count_wild_and_variable_lengths p =
     (count_wildcards p) + (g (fn x => 0) (fn y => String.size y) p)

	
			  
(* (c) Use g to define a function count_some_var that takes a string and a pattern (as
       a pair) and returns the number of times the string appears as a variable in the 
       pattern. We care only about variable names; the constructor names are not relevant. *)
 fun count_some_var (s,p) = 
     g (fn x => 0) (fn y => if y = s then 1 else 0) p








(* 10. takes a pattern and returns true if and only if all the variables appearing in
       the pattern are distinct from each other (i.e., use different strings). The 
       constructor names are not relevant. Hints: The sample solution uses two helper 
       functions. The first takes a pattern and returns a list of all the strings it 
       uses for variables. Using foldl with a function that uses append is useful in 
       one case. The second takes a list of strings and decides if it has repeats.
       List.exists may be useful. Sample solution is 15 lines.                     *)
 fun check_pat p : bool =
     let
	 fun get_string p : string list =
	     case p of
	        Variable s => [s]
	      | TupleP x::xs => foldl (fn (x,acc) => case x of
						      Variable r => [r] @ acc
						    | TupleP q::qs => (get_string q) @ acc) [] ps
	      | _ => []

	 val repeats = List.exists (fn (i,j) => i = j)
     in
	 repeats o (get_string p)
     end
	 






 val p = TupleP[TupleP[Variable "x",ConstructorP ("wild",Wildcard)],Variable "x"]
			    

	 
			 
				
       
				
	
	     		      
