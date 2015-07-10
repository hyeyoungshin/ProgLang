(* Section 3: Closure Idiom: Currying *)

(* Currying:

 - Recall every ML function takes exactly one argument

 - Previously encoded n arguments via one n-tuple

 - Another way: Take one argument and return a function that takes another argument and ...
  - Called "currying" after famous logician Haskell Curry

 *)














(* old way to get the effect of multiple arguments *)
fun sorted3_tupled (x,y,z) = z >= y andalso y >= x

val t1 = sorted_tuple (7,9,11)

(* new way: currying *)
val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x

(* fun sorted3 x = fn y => fn z => ... *)
val t2 = (sorted3 7) 9) 11



















(* Example:

            val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x

            val tl = ((sorted3 7) 9) 11

		     
 - Calling (sorted3 7) returns a closure with:
  - Code fn y => fn z => z >= y andalso y >= x
  - Environment maps x to 7

 - Calling that closure with 9 returns a closure with:
  - Code fn z => z >= y andalso y >= x
  - Environment maps x to 7, y to 9

 - Calling that closure with 11 returns true

 *)











(* Syntactic sugar, part 1:

             val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x

             val tl = ((sorted3 7) 9) 11		     

 - In general, e1 e2 e3 e4 ...,
   means (... ((e1 e2) e3) e4)

 - So instead of ((sorted3 7) 9 ) 11,
   can just write sorted3 7 9 11

 - Callers can just think "multi-argument function with spaces instead of a tuple expression"
  - Different than tupling; caller and callee must use same technique

 *)















(* Syntactic sugar, part 2:

             val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x

             val t1 = ((sorted3 7) 9) 11
 
 - In general, fun f p1 p2 p3 ... = e,
   means fun f p1 = fn p2 => fn p3 => ... => e

 - So instead of val sorted3 = fn x => fn y => fn z => ...
   or fun sorted3 x = fn y => fn z => ...,
   can just write fun sorted3 x y z = z >= y andalso y >= x
 
 - Callees can just think "multi-argument function with spaces instead of a tuple pattern"
  - Different than tupling; caller and callee must use same technique

 *)



(* 
val wrong1 = sorted3_tupled 7 9 11
val wrong2 = sorted3 (7,9,11)
*)

fun sorted3_nicer x y z = z >= y andalso y >= x



(* a more useful example *)
fun fold f acc xs = (* means fun fold f = fn acc => fn xs => *)
    case xs of
	[] => acc
      | x::xs' => fold f (f(acc,x) xs'

(* a call to curried fold: will improve this call next *)
fun sum xs = fold (fn (x,y) => x+y) 0 xs

		
















(* Final version:

                      fun sorted3 x y z = z >= y andalso y >= x

                      val t1 = sorted3 7 9 11

 As elegant syntactic sugar (even fewer characters than tupling) for:

                   val sorted3 = fn x => fn y => fn x => z >= y andalso y >= z
 
                   val t1 = ((sorted3 7) 9) 11

*)
