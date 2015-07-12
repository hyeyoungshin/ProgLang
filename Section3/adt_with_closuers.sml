(* Section 3: Optional: Abstract Data Types with Closuers *)


(* Implementing an ADT:

 As our last idiom, closures can implement abstract data types
    - Can put multiple functions in a record
    - The functions can share the same private data
    - Private data can be mutable or immutable
    - Feels a lot like objects, emphasizing that OOP and functional programming have some deep similarities


 See code for an implementation of immutable integer sets with operations insert, member, and size

 The actual code is advanced/clever/tricky, but has no new features
    - Combines lexical scope, datatypes, records, closures, etc
    - Client use is not so tricky

 *)



(* type set = { insert : int -> set,   (* type synonyms are not recursive *)
	     member : int -> bool,
	     size : unit -> int }
*)

datatype set = S of { insert : int -> set,  (* so that we can use set recursively *)
		      `member : int -> bool,
		      size : unit -> int }

(* we don't know how this set is implemented, but we do know its type 
    => it's record, with fields each of which is a function 
*)


(* the only public value available to us => val empty_set : set *)

			
	
			     






















(* implementation of sets: this is the fancy stuff,
   but clients using this abstraction need not understand it *)
val empty_set =
    let
	fun make_set xs = (* xs is a "private field" in result *)
	    let (* contains a "private method" in result *)
		fun contains i = List.exists (fn j => i=j) xs
	    in
		S { insert = fn i => if contains i               (* int -> set *)
				     then make_set xs
				     else make_set (i::xs),
		    member = contains,                           (* int -> bool *)
		    size = fn () => length xs                    (* unit -> int *)
		  }
	    end
    in
	make_set []
    end
	
							  
			   
(* example client *)
fun use_sets () = (* unit -> int *)
    let val S s1 = empty_set
	val S s2 = (#insert s1) 34  (* s1.insert(34) *)
	val S s3 = (#insert s2) 34  (* would not add it <= sets don't have duplicate *)
	val S s4 = #insert s3 19    (* 19, 34 *)
	(* represented in s4  a record holding 3 functions *)

    in
	if (#member s4) 42    (* if 42 is a member of set s4 *)
	then 99
	else if (#member s4) 19
	then 17 + (#size s3) ()
	else 0
    end
