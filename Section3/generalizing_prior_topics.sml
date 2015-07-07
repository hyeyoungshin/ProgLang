(* Generalizing:

 Our examples of first-class functions so far have all:
  - Taken one function as an argument to another function
  - Processed a number or a list

 But first-class functions are useful anywhere for any kind of data
  - Can pass several functions as arguments
  - Can put functions in data structures (tuples, lists, etc.)
  - Can return functions as results
  - Can write higher-order functions that traverse your own data structures

 Useful whenever you want to abstract over "what to compute with"
  - No new language features
 *)

(* Returning a function *)
fun double_or_triple f = (* (int -> bool) -> (int -> int) *)
    if f 7
    then fn x => 2*x
    else fn x => 3*x

val double = double_or_triple (fn x => x - 3 = 4)
val nine = (double_or_triple (fn x => x = 42)) 3

(* Returning functions

 Remember: Functions are first-class values
  - For example, can return them from functions

 Silly example: 

     fun double_or_triple f =
         if f 7
         then fn x => 2*x
         else fn x => 3*x

 Has type (int -> bool) -> (int -> int)

 But the REPL prints (int -> bool) -> int -> int
 because it never prints unnecessary parentheses and
 t1 -> t2 -> t3 -> t4 means t1 -> (t2 -> (t3 -> t4))

 *)





















(* Other data structures

- Higher-order functions are not just for numbers and lists
- They work great for common recursive traversals over your own data structures (datatype bindings) too
- Examples of a higher-order predicate:
 - Are all constants in an arithmetic expression even numbers?
 - Use a more general function of type
    (int -> bool) * exp -> bool
 - And call it with (fn x => x mod 2 = 0)

 *)


(* Higher-order functions over our own datatype bindings *)

datatype exp = Constant of int
	     | Negate of exp
	     | Add of exp * exp
	     | Multiply of exp * exp



(* given an exp, is every constant in it an even number? *)
				     
fun true_of_all_constants (f,e) =
    case e of
	Constant i => f i
      | Negate e1 => true_of_all_constants(f,e1)
      | Add(e1,e2)=> true_of_all_constants(f,e2) andalso true_of_all_constants(F,e2)
      | Multiple(e1,e2)=> true_of_all_constants (f,e2) andalso true_of_all_constants(F,e2)
					   
fun all_even e = true_of_all_constants((fn x => x mod 2 = 0), e)

				      
