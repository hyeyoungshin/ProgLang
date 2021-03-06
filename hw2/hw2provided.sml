(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* 

1. This problem involves using first-name substitutions to come up with alternate names. For example, Fredrick William Smith could also be Fred William Smith or Freddie William Smith. Only part (d) is specifically about this, but the other problems are helpful. 

*)

(* 

a) Write a function all_except_option, which takes a string and a string list. Return NONE if the string is not in the list, else return SOME lst where lst is identical to the argument list except the string is not in it. You may assume the string is in the list at most once. Use same_string, provided to you, to compare strings. Sample solution is around 8 lines. 

*)
	     
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
	   [] => SOME []
	 | x::xs => if length(ss)=length(ans) then NONE else SOME(x::xs)
    end


(* 

b) Write a function get_substitutions1, which takes a string list list (a list of list of string, the substitutions) and a string s and returns a string list. The result has all the strings that are in some list in substitutions that also has s, but s itself should not be in the result. 

Example:

 get_substitutions1(["Fred","Fredrick"], ["Elizabeth", "Betty"], ["Freddie","Fred","F"]], "Fred")

The result: ["Fredrick","Freddie","F"]

Assume each list in substitutions has no repeats. The result will have repeats if s and another string are both in more than one list in substitutions.

Use all_except_option and ML's list-append (@) but no other helper functions. Sample solution is around 6 time. 

*)

fun get_substitutions1 (sub, s) : string list =
     case sub of
	[] => []
      | x::xs => case all_except_option(s, x) of
		     NONE => get_substitutions1(xs, s)
		   | SOME([]) => get_substitutions1(xs, s)
		   | SOME(y::ys) => y::ys @ get_substitutions1(xs, s)


(* 

c) Write a function get_substitutions2, which is like get_substitutions1 except it uses a tail-recursive local helper function. 

*)

fun get_substitutions2 (sub, s) =
    let fun aux(lst, acc) =
	    case lst of
		[] => acc
	      | x::xs => case all_except_option(s, x) of
			     NONE => aux(xs, acc)
			   | SOME([]) => aux(xs, acc)
			   | SOME(y::ys) => aux(xs, acc @ (y::ys)) 
    in aux(sub, [])
    end

(* 

d) Write a function similar_names, which takes a string list list of substitutions (as in parts (b) and (c)) and a full name of type {first:string,middle:string,last:string} and returns a list of full names (type {first:string,middle:string,last:string} list). The result is all the full names you can produce by substituting for the first name (and only the first name) using substitutions and parts (b) or (c). The answer should begin with the original name (then have 0 or more other names). 

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

(* 

2. This Problem involves a solitaire card game invented just for this queston. You will write a program that tracks the progress of a game; writing a game player is a challenge problem. You can do parts (a)-(e) before understanding the game if you wish.

A game is played with a card-list and a goal. The player has a list of held-cards, initially empty. The player makes a move by either drawing, which means removing the first card in the card-list from the card-list and adding it to the held-cards, or discarding, which means choosing one of the held-cards to remove. The game ends either when the player chooses to make no more moves or when the sum of the values of the held-cards is greater than the goal.

The objective is to end the game with a low score (0 is best). Scoring works as follows: Let sum be the sum of the values of the held-cards. If sum is greater than goal, the preliminary score is three times (sum - goal), else the preliminary score is (goal - sum). The score is the preliminary score unless all the held-cards are the same color, in which case the score is the preliminary score divided by 2 (and rounded down as usual with integer division; use ML's div operator).

*)

(*

(a) Write a function card_color, which takes a card and returns its color (spades and clubs are black, diamonds and hearts are red). Note: One case-expression is enough.

*)

fun card_color card : color = 
    case card of
	(Clubs,_) => Black
      | (Diamonds,_) => Red
      | (Hearts,_) => Red
      | (Spades,_) => Black


(*

(b) Write a function card_value, which takes a card and returns its value (numbered cards have their number as the value, aces are 11, everything else is 10). Note: One case-expression is enough.

*)

fun card_value card : int =
    case card of
	(_,Num i) => i
      | (_,Ace) => 11
      | _ => 10

(*

(c) Write a function remove_card, which takes a list of cards cs, a card c, and an exception e. It returns a list that has all the elements of cs except c. If c is in the list more than once, remove only the first one. If c is not in the list, raise the exception e. You can compare cards with =.

*)

fun remove_card (cs: card list, c: card, e: exn) : card list =
    let fun leng lst : int =
	    case lst of
		[] => 0
	      | x::xs => 1 + leng(xs)

    in
	case cs of
	    [] => raise e
	  | x::xs => if x = c
		     then if leng xs = leng cs
			  then raise e
			  else xs
		     else remove_card (xs, c, e)
    end


(*

(d) Write a function all_same_color, which takes a list of cards and returns true if all the cards in the list are the same color. Hint: An elegant solution is very similar to one of the fuctions using nested pattern-matching in the lectures.

*)

fun all_same_color (cardlst: card list) : bool =
    case cardlst of
	[] => true
      | x::[] => true
      | y::ys => (all_same_color ys) andalso case ys of
						 z::zs => card_color y = card_color z
					       | _ => true
							  
	(*
			  let val col1 = card_color y
		          val col2 = card_color z
		      in
			  if col1=col2
		          then case tl of
				   [] => true
				 | x::[] => col1 = card_color x
				 | p::ps => col1 = p andalso all_same_color ps
			  else false
		      end
	*)			  

(*

(e) Wrtie a function sum_cards, which takes a list of cards and returns the sum of their values. Use a locally defined helper function that is tail recursive. (Take "calls use a constant amount of stack space" as a requirement for this problem.)

*)

 fun sum_cards (cardlst: card list) : int =
     let fun sum (lst: card list, acc: int) : int =
	     case lst of
		 [] => acc
	       | x::xs => sum (xs, (card_value x) + acc)
     in sum(cardlst, 0)
     end


(*

(f) Write a function score, which takes a card list (the held-cards) and an int (the goal) and computes the score as described above.

*)

fun score (cardlst: card list, goal: int) : int =
    let val sum = sum_cards cardlst

	fun div_score (scor: int) : int =
	    if all_same_color cardlst
	    then scor div 2
	    else scor
    in
	if sum > goal
        then div_score(3 * (sum - goal))
	else div_score(goal - sum)
    end


(*

Write a function officiate, which “runs a game.” It takes a card list (the card-list) a move list
(what the player “does” at each point), and an int (the goal) and returns the score at the end of the game after processing (some or all of) the moves in the move list in order. Use a locally defined recursive helper function that takes several arguments that together represent the current state of the game. As described above:

• The game starts with the held-cards being the empty list.
• The game ends if there are no more moves. (The player chose to stop since the move list is empty.)
• If the player discards some card c, play continues (i.e., make a recursive call) with the held-cards not having c and the card-list unchanged. If c is not in the held-cards, raise the IllegalMove exception.
• If the player draws and the card-list is (already) empty, the game is over. Else if drawing causes the sum of the held-cards to exceed the goal, the game is over (after drawing). Else play continues with a larger held-cards and a smaller card-list.

Sample solution for (g) is under 20 lines.

*)


fun officiate (cardlst: card list, movelst: move list, goal: int) : int =
    let fun play(heldlst: card list, stack: card list, move: move list, e: exn) : int =
	case move of
	    [] => score (heldlst, goal) (* Game over *)
	  | x::xs => case x of
			 Discard c => play (remove_card (heldlst, c, e), stack, xs, e)
		       | Draw => case stack of
				     [] => score (heldlst, goal) (* Game over *)
				   | y::ys => if sum_cards(y::heldlst) > goal
					      then score (y::heldlst, goal)
					      else play(y::heldlst, ys, xs, e)
    in play([], cardlst, movelst, IllegalMove)
    end

	

			 


	
			
											 
						   
																					     
