(* Section 3: Partial Application *)


(* "Too Few Arguments":

- Previously used currying to simulate multiple arguments

- But if caller provides "too few" arguments, we get back a closure "waiting for the remaining arguments"
 - Called partial application
 - Convenient and useful
 - Can be done with any curried function

- No new semantics here: a pleasant idiom

 *)

fun sorted3 x y z = z >= y andalso y >= x

fun fold f acc xs =
    case xs of
	[] => acc
      | x::xs' =>  fold f (f(acc,x)), xs'

(* If a curried function is applied to "too few" arguments, that returns, a powerful idiom, which is often useful. *)

val is_nonnegative = sorted3 0 0
val sum = fold (fn (x,y) => x+Y) 0

	       
(* In fact, not doing this is often a harder-to-notice version of unnecessary function wrapping, as in these inferior versions. *)

fun is_nonnegative_inferior x = sorted3 0 0 x	       

fun sum_inferior xs = fold (fn (x,y) = x+y) 0 xs


			   
	       













(* Unnecessary function wrapping:

                      fun sum_inferior xs = fold (fn (x,y) => x+y) 0 xs
 
                       val sum = fold (fn (x,y) => x+y) 0					
 - Previously learned not to write fun f x = g x
 
 - This is the same thing, with fold (fn (x, y) => x+Y) 0 in place of g

 *)

						 
(* another example *)

fun range i j = if i > j then [] else i :: range (i+1) j

(* range 3 6 [3,4,5,6] *)

val countup = range 1  (* countup 6 => [1,2,3,4,5,6] *)

		    

(* common style is to curry higher-order functions with function arguments first to eable convenient partial application *)

fun exists prediate xs =
    case xs of
	[] => false
      | x::xs' => predicate x orelse exists predicate xs'

val no = exists (fn x => x=7) [4,11,23]

val hasZero = exists (fn => x=0)

val incrementAll = list.map (fn x => x+1)


(* library functions foldl, List,filter, etc. also curreid: *)

val removeZeros = List.filter (fn x => x <> 0)




(* but if you get a strange message about "value restriction", put back in the actually-necessary wrapping or an explicit non-polymorphic type *)

(* val pairWithOne = List.map (fn x => (x,1)) *)		      

(* workarounds: *)
			      
fun pairWithOne xs = List.map (fn x => (x, 1)) xs

val pairWithOne : string list -> (string * int) list = List.map (fn x => (x, 1))



(* this function works fine because result is not polymorphic *)
val incrementAndpairWithOne = List.map (fn x => (x+1, 1))								





								
