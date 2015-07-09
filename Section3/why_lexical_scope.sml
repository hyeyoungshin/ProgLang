(* Section 3: Why Lexical Scope *)

(* 

- Lexical scope: use environment where function is defined
- Dynamic scope: use environment where function is called

Decades ago, both might have been considered reasonable, but now we know lexical scope makes much more sense

Here are three precise, technical reasons.

1. Function meaning does not depend on variable names used

  Example: Can change body of f to use q everywhere instead of x
   - Lexical scope: it cannot matter
   - Dynamic scope: depends how result is used

                                fun f y = 
                                    let val x = y+1
                                    in fn z => x+y+z end


  Example: Can remove unused variables
   - Dynamic scope: but maybe some g uses it (weird)

                                fun f g =
                                    let val x = 3
                                    in g 2 end

*)

fun f1 y =
    let val x = y + 1
    in fn z => x + y + z
    end

fun f2 y =
    let val q = y + 1
    in fn z => q + y + z
    end

val x = 17 (* irrelevant under lexical scope *)

val a1 = (f1 7) 4
val a2 = (f2 7) 4

(* a1 and a2 under Lexical scope are 19 *)
(* a1 under dynamic scope would end up using "x=17"
   a2 under dynamic scope has undefined variable "q"  *)


(*
2. Functions can be type-checked and reasoned about where defined

  Example: Dynamic scope tries to add a string and an unbound variable to 6
*)

val x = 1
fun f y =
    let val x = y+1
    in fn z => x+y+z end
val x = "hi"
val g = f 7
val z = g 4



(*
3. Closures can easily store the data they need
 - Many more examples and idioms to come
*)

fun filter (f,xs) =
    case xs of
	[] => []
      | x::xs => if f x
		 then x::(filter(f,xs))
		 else filter(f,xs)

fun greaterThanX x = fun y => y > x (* int -> (int -> bool) *)

fun noNegatives xs = filter(greaterThanX ~1, xs) 

fun allGreater (xs,n) = filter(fn x => x > n, xs)

(* where are we using lexical scope here?
   => in the creation of this function "noNegatives" we pass the filter
   => returns a closure that captures stores in its envrionment that x is -1 
 *)
			       

(* Does dynamic scope exist?

- Lexical scope for variables is definitely the right default
 - Very common across languages

- Dynamic scope is occasionally convenient in some situations
 - So some languages (e.g., Racket) have special ways to do it
 - But most do not bother

- If you squint some, exception handling is more like dynamic scope:
 - raise e transfers control to the current inntermost handler
 - Does not have to be syntactically inside a handle expression
 (and usually not)
 *)
			      
