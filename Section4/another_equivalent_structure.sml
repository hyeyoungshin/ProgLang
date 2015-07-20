(* Section 4: Another Equivalent Structure *)


(* More interesting example:

 Given a signature with an abstract type, different structures can:
    - Have that signature
    - But implement the abstract type differently

 Such structures might or might not be equivalent

 Example (see code):
    - /type rational = int * int/
    - Does not have signature RATIONAL_A
    - Equivalent to both previous examples under /RATIONAL_B/ or /RATIONAL_C/

 *)



(* this signature hides gdc and reduce.
   that way clients cannot assume they exist or call the, 
   with unexpected inputs. *)
signature RATIONAL_A =
sig
    datatype rational = Frac of int * int | Whole of int
    exception BadFrac
    val make_frac : int * int -> rational
    val add : rational * rational -> rational
    val toString : rational -> string
end
    
				


(* the previous signature lets clients build any value of type rational
   they want by exposing the Frac and Whole constructors.
   This makes it impossible to maintain invariants about rationals, so we
   might have negative denominators, which some functions do not handle,
   and print_rat may print a non-reduced fraction.
   we fix this by making rational abstract. *)
signature RATIONAL_B =
sig
    type rational
    exception BadFrac
    val make_frac : int * int -> rational
    val add : rational * rational -> rational
    val toString : rational -> string
end



(* as a cute trick, it is actually okay to expose
   this whole function since no value breaks
   our invariants, and different implementations
   can still implement whole differently. *)
signature RATIONAL_C =
sig
    type rational
    exception BadFrac
    val Whole : int -> rational
    (* client knows only that whole is a function *)
    val make_frac : int * int -> rational
    val add : rational * rational -> rational
    val toString : rational -> string
end
    
				     




(* this structure uses a different abstract type.
   It does not even have signature RATIONAL_A.
   For RATIONAL_C, we need a function whole. *)
structure Rational3 :> RATIONAL_B (* or C *) =
struct
type rational = int * int
exception BadFrac

fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then (~x, ~y)
    else (x,y)

fun add ((a,b), (c,d)) = ((a*d + c*b), b*d)

fun toString (x,y) =
    if x = 0
    then "0"
    else
	let fun gcd(x,y) =
		if x = y
		then x
		else if x < y
		then gcd (x,y-x)
		else gcd (y,x)
	    val d = gcd (abs x, y)
	    val num = x div d
	    val denom = y div d
	in
	    Int.toString num ^ (if denom = 1 then "" else "/" ^ (Int.toString denom))
	end

fun Whole i = (i,1)       (* 'a -> 'a * int *)
         		  (* int -> int * int *)
	                  (* int -> rational *)	   
end















(* Some interesting details:

 - Internally /make_frac/ has type /int * int -> int * int/, 
   but externally /int * int -> rational/
    - Client cannot tell if we return argument unchanged
    - Could give type /rational -> rational/ in signature, but    
      this is awful: makes entire module unusable -- why?

 - Internally /Whole/ has type /'a -> 'a * int/ but externally 
   /int -> rational/
    - This matches because we can specialize /'a/ to /int/ and then 
      abstract /int * int/ to /rational/
    - /Whole/ cannot have types /'a -> int * int/ or /'a -> rational/ 
      (must specialize all /'a/ uses)
    - Type-checker figures all this out for us

 *)




    






    
