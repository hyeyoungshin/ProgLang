(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option (s,ss) : string list option =
    let fun aux (x,xs) : string list =
	    case xs of
		[] => []
	      | y::ys => if same_string(x, y) then ys else y::aux(x,ys)

	fun length xs : int =
	    case xs of
		[] => 0
	      | x::xs' => 1 + length xs'
				     
	val ans = aux(s,ss)

    in case ans of
	   [] => NONE
	 | x::xs => if length(ss)=length(ans) then NONE else SOME(x::xs)
   (* in if aux(s,ss)=[] then NONE else SOME(aux(s,ss)) *)
    end

fun get_substitutions1 (sub, s) : string list =
     case sub of
	[] => []
      | x::xs => case all_except_option(s, x) of
	    NONE => [] @ get_substitutions1(xs,s)
	  | SOME(y::ys) => y::ys @ get_substitutions1(xs,s)

						     
    






    

	
		      
			  



		      
		      
	
		      
	
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
