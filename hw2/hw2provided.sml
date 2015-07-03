(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)


(* Write a function all_except_option, which takes a string and a string list. Return NONE if the string is not in the list, else return SOME lst where lst is identical to the argument list except the string is not in it. You may assume the string is in the list at most once. Use same_string, provided to you, to compare strings. Sample solution is around 8 lines. *)
fun all_except_option (s,ss) : string list option =
    let fun aux (x,xs) : string list =
	    case xs of
		[] => []
	      | y::ys => if same_string(x,y) then ys else y::aux(x,ys)

	fun length xs : int =
	    case xs of
		[] => 0
	      | x::xs' => 1 + length xs'
				     
	val ans = aux(s,ss)

    in case ans of
	   [] => NONE
	 | x::xs => if length(ss)=length(ans) then NONE else SOME(x::xs)
    end


(* Write a function get_substitutions1, which takes a string list list (a list of list of string, the substitutions) and a string s and returns a string list. The result has all the strings that are in some list in substitutions that also has s, but s itself should not be in the result. 

Example:

 get_substitutions1(["Fred","Fredrick"], ["Elizabeth", "Betty"], ["Freddie","Fred","F"]], "Fred")

The result: ["Fredrick","Freddie","F"]

Assume each list in substitutions has no repeats. The result will have repeats if s and another string are both in more than one list in substitutions.

Use all_except_option and ML's list-append (@) but no other helper functions. Sample solution is around 6 time. *)
fun get_substitutions1 (sub, s) : string list =
     case sub of
	[] => []
      | x::xs => case all_except_option(s, x) of
	    NONE => [] @ get_substitutions1(xs, s)
	  | SOME(y::ys) => y::ys @ get_substitutions1(xs, s)


(* Write a function get_substitutions2, which is like get_substitutions1 except it uses a tail-recursive local helper function. *)
fun get_substitutions2 (sub, s) =
    let fun aux(lst, acc) =
	    case lst of
		[] => acc
	      | x::xs => case all_except_option(s, x) of
			     NONE => aux(xs, acc)
			   | SOME(y::ys) => aux(xs, acc @ (y::ys)) 
    in aux(sub, [])
    end

(* Write a function similar_names, which takes a string list list of substitutions (as in parts (b) and (c)) and a full name of type {first:string,middle:string,last:string} and returns a list of full names (type {first:string,middle:string,last:string} list). The result is all the full names you can produce by substituting for the first name (and only the first name) using substitutions and parts (b) or (c). The answer should begin with the original name (then have 0 or more other names). 

Example:
 similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"})

Answer: [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
{first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}] 

Do not eliminate duplicates from the answer. Hint: Use a local helper function. Sample solution is around 10 lines. 
*)
fun similar_names (sub, full_name) =
    let val {first=x, middle=y, last=z} = full_name
	fun make_names (first, acc) =
	    case first of
		[] => acc
	      | s::ss => make_names(ss, {first=s, middle=y, last=z}::acc)

	fun rev (lst, acc) =
	    case lst of
		[] => acc
	      | b::bs => rev(bs, b::acc)
				 
    in
	rev(make_names(get_substitutions1(sub, x), [full_name]),[])
    end
	
			     
		
							       
	
    






    

	
		      
			  



		      
		      
	
		      
	
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
