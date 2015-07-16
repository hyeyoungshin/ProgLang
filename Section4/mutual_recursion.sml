(* Section 4: Mutual Recursion *)


(* Mutual Recursion:

 - Allow f to call g and g to call f

 - Useful? Yes.
     - Idiom we will show: implementing state machines

 - The problem: ML's bindings-in-order rule for environments
    - Fix #1: Sepcial new language construct
    - Fix #2: Workaround using higher-order functions 

 *)

















(* New language features:

 - Mutually recursive functions (the and keyword)
                
                                  fun f1 p1 = e1
                                  and f2 p2 = e2
                                  and f3 p3 = e3


 - Similarly, mutually recursive datatype bindings
      
                                  datatype t1 = ...
                                  and t2 = ...
                                  and t3 = ...

 - Everything in "mutual recursion bundle" type-checked together and can refer to each other

 *)

















(* State-machine example:

 - Each "state of the computation" is a function
    - "State transition" is "call another function" with "rest of input"
    - Generalizes to any finite-state-machine example

                                    fun state1 input_left = ...
                     
                                    and state2 input_left = ...
                                    
                                    and ...

 *)


(* an example of mutual recursion: a little "state machine" for deciding
   if a list of ints alternates between 1 and 2, not ending with a 1. *)
fun match xs = (* [1,2,1,2,1,2] *)
    let fun s_need_one xs =
	    case xs of
		[] => true
	      | 1::xs' => s_need_two xs'
	      | _ => false
	and s_need_two xs =
	    case xs of
		[] => false
	      | 2::xs' => s_need_one xs'
	      | _ => false
    in
	s_need_one xs
    end







datatype t1 = Foo of int | Bar of t2
     and t2 = Baz of string | Quuz of t1

fun no_zeros_or_empty_strings_t1 x =
    case x of
	Foo i => i <> 0
      | Bar y => no_zeros_or_empty_strings_t1 y
and no_zeros_or_empty_strings_t2 x =
    case x of
	Baz s => size x > 0
      | Quux y => no_zeros_or_empty_strings_t1 y


(* code above works fine. This version works without any new language support. *)
fun no_zeros_or_empty_strings_tl_alt(f,x) =
    case x of
	Foo i => i <> 0
      | Bar y => f y

fun no_zeros_or_empty_strings_t2_alt x =
    case x of
	Baz s => size s > 0
     |  Quux y => no_zeros_or_empty_strings_t1_alt(no_zeros_or_empty_string_t2_alt, y)

















(* Work-around:

 - Suppose we did not have support for mutually recursive functions
    - Or could not put functions next to each other

 - Can have the "later" function pass itself to the "earlier" one
    - Yet another higher-order function idiom

                       fun earlier (f ,x) = ... f y ...
                      
                       ... (* no need to be nearby *)
            
                       fun later x = ... earlier (later, y) ...

 *)
						  

									
					       
     
	
