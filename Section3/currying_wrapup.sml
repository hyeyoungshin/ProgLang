(* Section 3: Currying Wrapup *)

(* More combining functions

 - What if you want to curry a tupled function or vice-versa?
 - What if a function's arguments are in the wrong order for the partial application you want?

 Naturally, it is easy to write higher-order wrapper functions
  - And their types are neat logial formulas

                 fun other_curry1 f = fn x => fn y => f y x
                 fun other-curry2 f x y = f y x
                 fun curry f x y = f (x,y)
                 fun uncurry f (x,y) =  f x y

 *)




fun curry f x y => f (x,y) 

fun uncurry f (x,y) = f x y
			
(* val curry = fn : ('a * 'b -> 'c) -> 'a -> 'b -> 'c
   val uncurry = fn : ('a -> 'b -> 'c) -> 'a * 'b -> 'c *)
	




fun other_curry f = fn x => fn y => f y x
(* syntactic sugar => fun other_curry f x y => f y x *)




(* example *)

(* tupled but we wish it were curried *)
fun range (i,j) = if i > j then [] else i :: range(i+1, j)

val countup = (curry range) 1 (* does not work (yet) *)

val xs = countup 7 (* [1,2,3,4,5,6,7] *)





















(* Efficiency:
 
 So which is faster: tupling or currying multiple-arguments?

 - They are both constant-time operations, so it doesn't matter in most of your code = "plenty fast"
   - Don't program against an implementation until it matters!


 - For the small (zero?) part where efficiency matters:
  - It turns out SML/NJ complies tuples more efficiently
  - But many other functional-language implementations do better with currying (OCaml, F#, Haskell)
   - So currying is the "normal thing" and programmers read t1 -> t2 -> t3 -> t4 as a 3-argument function that also allows partial application

 *)

		 
		 
