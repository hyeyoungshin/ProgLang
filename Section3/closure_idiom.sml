(* Section 3: Closure Idiom: Combining Functions *)

(* More idioms:

 - We know the rule for lexical scope and function closures
  - Now what is it good for

 A partial but wide-ranging list:
 - Pass functions with private data to iterators: Done
 - Combine functions (e.g., composition)
 - Currying (multi-arg functions and partial application)
 - Callbacks (e.g., in reactive programming)
 - Implementing an ADT with a record of functions

 *)


















fun compose(f,g) = fn x => f(g x) (* use closure *)

(* ('b -> 'c) * ('a -> 'b) -> ('a -> 'c) *)


(* int -> real *)
fun sqrt_of_abs i = Math.sqrt (Real.fromInt (abs i))

fun sqrt_of_abs i = (Math.sqrt o Real.fromInt o abs) i (* => unnecessary function wrapping *)

val sqrt_of_abs = Math.sqrt o Real.fromInt o abs (* More clear and direct *)



		      















(* Left-to-right or right-to-list:

             val sqrt_of_abs = Math.sqrt o Real.fromInt o abs

 As in math, function composition is "right to left"
  - "take absolute value, convert to real, and take square root"
  - "square root of the conversion to real of absolute value"

 "Pipelines" of functions are common in functional programming and many programmers prefer left-to-right
  - Can define our own infix operator
  - This one is very popular (and predefined) in F#

                infix |>
                fun x |> f = f x

                fun sqrt_of_abs i = 
                   i |> abs |> Real.fromInt |> Math.sqrt   

 *)


(* val backup1 = fn : ('a -> 'b option) * ('a -> 'b) -> 'a -> 'b *)
fun backup1 (f,g) = fn x => case f x of
				NONE => g x
			      | SOME y => y

(* val backup2 = fn : ('a -> 'b) * ('a -> 'b) -> 'a -> 'b *)x
fun backup2 (f,g) = fn x => f x handle _ => g x					      

					      
    
(* |> !>*)
infix !>

fun x !> f = f x

fun sqrt_of_abs i = i !> abs !> Real.fromInt !> Math.sqrt

						 
		
