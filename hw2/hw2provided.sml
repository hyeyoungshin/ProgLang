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
	    NONE => [] @ get_substitutions1(xs,s)
	  | SOME(y::ys) => y::ys @ get_substitutions1(xs,s)


(* Write a function get_substitutions2, which is like get_substitutions1 exce[t it uses a tail-recursive local helper function. *)
fun get_substitutions2 (sub, s) : string list =
    let fun aux(lst, acc) =
	    case lst of
		[] => acc
		   | x::xs => aux(xs, all_except_option(s,x)::acc) 
    in aux(sub, [])
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
