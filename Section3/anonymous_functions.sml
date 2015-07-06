(* Section 3: Anonymous Functions *)

fun n_times (f,n,x) =
    if n=0
    then x
    else f (n_times(f,n-1,x))


fun triple x = 3 * x
fun triple_n_times (n,x) = n_times(triple,n,x)

fun triple_n_times (n,x) =
    let fun triple x = 3 * x
    in n_times(triple,n,x)
    end

fun triple_n_times (n,x) =
    n_times(let fun triple x = 3*x in triple end,n,x)

(* does not complie: fun triple x = 3*x is not an expression 

fun triple_n_times (n,x) =
    n_times((fun triple x = 3*x), n, x) 

 *)

(*

 anonymous functions: 
 - This is the best way we were building up to
  - An expression form for anonymous functions 
  - Like all expression forms, can appear anywhere
  - Syntax: 
   - fn not fun
   - => not =
   - no function name, just an argument pattern

 *)
fun triple_n_times (n,x) =
    n_times(fn x => 3*x, n, x) 


(*
	   
Using anonymous functions
- Most common use: Argument to higher-order function
 - Don't need a name just to pass a function
- But: Cannot use an anonymous function for a recursive function
 - Because there is no name for making recursive calls
 - If not for recursion, fun bindings would be syntactic sugar for val bindings and anonymous functions

                                  fun triple x = 3 * x
                                  val triple = fn y => 3*y

*)

(* ppor style *)
val triple_n_times = fn (n,x) => n_times((fn y => 3*y),n,x)
					
	   


	   
