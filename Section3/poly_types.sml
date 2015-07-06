(* Section 3: Polymorphic Types and Functions as Arguments *)

(*

The Key Point

- Higher-order functions are often so "generic" and "reusable" that they have polymorphic types, i.e., types with type variables
- But there are higher-order functions that are not polymorphic
- And there are non-higher-order (first-order) functions that are polymorphic
- Always a good idea to understand the type of a function, especially a higher-order function

*)

(*

Types:

                                  fun n_times (f,n,x) =
                                     if n=0
				     then x
				     else f (n_times(f,n-1,x))

- val n_times : ('a -> 'a) * int * 'a -> 'a
 - Simpler but less useful: (int -> int) * int * int -> int
- Two of our examples instantiated 'a with int
- One of our examples instantiated 'a with int list
- This polymorphism makes n_times more useful
- Type is inferred based on how arguments are used
 - Describes which types must be exactly something (e.g., int) and which can be anything but the same (e.g., 'a)

*)

fun n_times (f,n,x) = (* ('a -> 'a) * int * 'a -> 'a *)
    if n=0
    then x
    else f (n_times(f,n-1,x)

fun increment x = x+1
fun double x = x+x

val x1 = n_times(double,4,7) (* instantiates 'a with int *)
val x2 = n_times(increment,4,7) (* instantiates 'a with int *)
val x3 = n_times(tl,2,[4,8,12,16]) (* instantiates 'a with list *)

(* higher-order functions are often polymorphic based on "whatever type of function is passed" but not always: *)
(* note: a better implementation would be tail-recursive *)
fun times_until_zero (f, x) =
    if x=0 then 0 else 1 + times_until_zero(f, f x)

(* f (f (f ... x))) *)
(* (int -> int) * int -> int *)					   

(* conversely, some polymorphic functions that are not higher-order *)
(* 'a list -> int *)

fun len xs =
    case xs of
	[] => 0
      | _::xs' => 1 + len xs; 
