(* Section 4: Signatures and Hiding Things *)


(* Signatures:

 - A signature is a type for a module
    - What bindings does it have and what are their types

 - Can define a signature and ascribe it to mudles -- example: *)

signature MATHLIB =
sig
    val fact : int -> int
    val half_pi : real
    val doubler : int -> int
end


structure MyMathLib :> MATHLIB =
struct
fun fact x =
    if x = 0
    then 1
    else x * fact (x - 1)
val half_pi = Math.pi / 2.0
fun doubler x = x * 2
end














(* In general: 

 - Signatures
                       signature SIGNAME = 
                       sign types-for-bindings end

    - Can include variables, types, datatypes, and exceptions defined in module

 - Ascribing a signature to a mudle

                       signature MyModule :> SIGNAME = 
                       struct bindings end

    - Module will not type-check unless it matches the signature, meaning it has all the bindings 
      at the right types

    - Note: SML has other forms of ascription; we will stick with these [opaque signatures]

 *)


signature MATHLIB =
sig
    val fact : int -> int
    val half_pi : real
    val doubler: int -> int (* can hide bindings from clients *)
end


structure MyMathLib :> MATHLIB =
		       struct
		       fun fact x =
			   if x = 0
			   then 1
			   else x * fact (x - 1)

		       val half_pi = Math.pi / 2.0
		       fun doubler y = y + y
		       end

val pi = MyMathLib.half_pi + MyMathLib.half_pi

val twenty_eight = MyMathLib.doubler 14

				     
		       
    











(* Hiding things:

 Real value of signatures is to hide bindings and type definitions
    - So far, just documenting and checking the types

 Hiding implementation details is the most important strategy for writing correct,
 robust, reusable software

 So first remind ourselbes that functions already do well for some forms of hiding...

 *)





















(* Hiding with functions:

 These three functions are totally equivalent: no client can tell which we are using
 (so we can change our choice later):

                               fun double x = x * 2
                               fun double x = X + x
                               val y = 2
                               fun double x = x * y

 Defining helper functions locally is also powerful
    - Can change/remove functions later and know it affects no other code

 Would be convenient to have "private" top-level functions too
    - So two functions could easily share a helper function
    - ML does this via signatures that omit bindings...

 *)



















(* Example: 

 Outside the module, /MyMathLib.doubler/ is simply unbound
    - So cannot be used [directly]
    - Fairly powerful, very simple idea

*)


signature MATHLIB =
sig
    val fact : int -> int
    val half_pi : int
end

structure MyMayhLib :> MATHLIB =
struct
     fun fact x = ...
     val half_pi = Math.pi / 2.0
     fun doubler x = x * 2
end
			   
