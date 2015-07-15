(* Section 4: Type Inference Examples *)



(* Key Idea:

 - Collect all the facts needed for type-checking

 - These facts constrain the type of the function

 - This segment:
    - Two examples without type variables
    - And one example that does not type-check

 *)







(* 
   f : T1 -> T2 [must be a function; all functions take 1 arg]
   x : T1

   y : T3
   z : T4

   T1 = T3 * T4 [else pattern match does not type-check]
   T3 = int [abs has type int -> int]
   T4 = int [because we added z to an int]
   So T1 = int * int
   So (abs y) + z : int, so let-expression : int, so body : iny
   T2 = int
   f : int * int -> int

*)
fun f x =
    let val (y,z) = x in
	(abs y) + z
    end
	








(* 
   sum : T1 -> T2
   xs : T1

   x : T3
   xs' : T3 list [pattern match a T1]

   T1 = T3 list
   T2 = int [because 0 might be returned]
   T3 = int [becasue x:T3 and we add x to something]
   from T1 = T3 list and T3 = int, we know T3 = int list
   from that and T2 = int, we know f : int list -> int
  *)
fun sum xs =
    case xs of
	[] => 0
      | x::xs' => x + (sum xs')
			  
