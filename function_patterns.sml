(* Section 2: Function Patterns *)

datatype exp = Constant of int
	     | Negate of exp
	     | Add of exp * exp
	     | Multiply of exp * exp

fun old_eval e =
    case e of
	Constant i = > i
      | Negate e2 => ~ (old_eval e2)
      | Add(e1,e2) => (old_eval e1) + (old_eval e2)
      | Multiply(e1,e2) => (old_eval e1) * (old_eval e2)

fun eval (Constant i) = i
  | eval (Negate e2) = ~ (eval e2)
  | eval (Add(e1,e2)) = (eval e1) + (eval e2)
  | eval (Multiply(e1,e2) =  (eval e1) * (eval e2)

fun append ([],ys) = ys
  | append (x::xs', ys) = x::append(xs', ys)


(* What would happen if the following code is used? *)
fun f (a::b::c) = 2 + f c
  | f [] = 0;

val x = f[1,2,3];

(* This code will first produce a compile-time warning because f does not have patterns to match every possible input. It will fail on any 1 element list.

A run-time exception will follow because f is recursive. Calling it with [1,2,3] will match the first branch and then call f recursively with [3]. This value cannot be matched so an exception will be thrown.
 *)














(* Nothing more powerful 
- In general

                                    fun f x =
                                      case x of
                                        p1 => e1
                                      | p2 => e2
                                       ... 

- Can be written as 
                                    fun f p1 = e1
                                      | f p2 = e2
                                      ...
                                      | f pn = en
 *)















(* What is the difference between these two functions? 

fun f1 xs =
  case xs of
    [] => []
   | _ => 1::xs;

fun f2 [] => []
  | f2 _ = 1::xs;

  
Explanation: f2 is the naive approach of transforming f1 into the new syntax taht we learned this lecture. However, it fails to take into account that xs is used in the second branch of the case expression. This variable no longer exists in f2 so there will be a compile-time error. 
 *)


