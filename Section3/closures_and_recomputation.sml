(* Section 3: Closures and Recomputation *)


(* When Things Evaluate:

Things we know:

 - A function body is not evaluated until the function is called
 - A function body is evaluated every time the function is called
 - A variable binding evaluates its expression when the binding is evalued, not every time the vaiable is used

With closures, this means we can avoid repeating computations that do not depend on function arguments
 - Not so worried about performance, but good example to emphasize the semantics of functions

 *)

fun filter (f,xs) =
    case xs of
	[] => []
      | x::xs' => if f x then x::(filter(f,xs')) else filter(f,xs')

fun allshorterThan1 (xs, s) = (* string list * string -> string list *)
    filter (fn x => String.size x < (print "!" ; String.size s), xs)

(* e1 ; e2 -> Does e1, throws away the result, and does e2 *)

fun allshorterThan2 (xs, s) =
    let val i = (print "!"; string.size s)
    in filter (fn x => String.size x < i, xs)
    end
	

