(* Section 2: Exceptions *)

fun hd xs =
    case xs of
	[] => raise List.Empty
      | x:: => x

exception MyUndesirableCondition

exception MyOtherException of int * int
(* e.g., raise MyOtherException (3,4) *)

					
fun mydiv (x,y) =
    if y=0
    then raise MyUndesirableCondition
    else x div y







(* making an exception value vs. raising it *)
(* exn is the exception type *)

fun maxlist (xs,ex) = (* int list * exn -> int *)
    case xs of
	[] => raise ex
      | x::[] => x
      | x::xs' => Int.max(x,maxlist(xs',ex))


val w = maxlist ([3,4,5], MyUndesirableCondtion) (* won't raise the exception *)






		
(* Handling exception:
                                e1 handle ex => e2

- if e1 evaluates normally the rest is irrelevant. if e1 raises the exception, catch the exception and evaluate e2 instead.
*)


val x = maxlist ([3,4,5], MyUndesirableCondition)  (* 5 *)
	handle MyUndesirableCondition => 42

(* val y = maxlist ([], MyUndesirableCondition) *)
	

val z = maxlist([], MyUndesirableCondition) (* 42 *)
	       handle MyUndesirableCondition => 42
					     


(* What is res bound to after running the following code?

val x = List.Empty;
val res = (hd [], 0) handle List.Empty => raise x;

Answer: Nothing, a run-time exception halts the program when binding res(line 2)
 *)








(* Exceptions:
- An exception binding introduces a new kind of exception

                            exception MyFirstException
                            exception MySecondException of int * int

- The raise primitive raises (a.k.a throws) an exception

                            riase MyFirstException
                            riase (MySecondException (7,9))

- An handle expression can handle (a.k.a catch) an exception 
 - If doesn't match, exception continues to propagate

                            e1 handle MyFirstException => e2
                            e1 handle MySecondException (x,y) => e2
*)

						    









(* Actually ...

- Exceptions are a lot like datatype constructors
 - Declaring an exception makes adds a constructor for type exn

 - Can pass values of exn anywhere (e.g., function arguments)
  - Not too common to do this but can be useful

- Handle can have multiple branches with patterns for type exn			

 *)






(* What will x be bound to after running the following code? 

exception MyException of int
fun f n =
    if n = 0
    then raise List.Empty
    else if n = 1
    then raise (MyException 4)
    else n * n

val x = (f 1 handle List.Empty => 42) handle MyException n => f n

Answer: 16
Explanation: Evaluation first calls f with 1, which causes MyException 4 to be raised. The inner handle expression does not handle this exception, but the outer one does, calling f with n, where n is bound to the value carried by the exception, i.e., 4. The call f 4 evaluates to 16 without raising an exception. By the way, a single handle expression can have multiple branches for different exceptions, and that would be slightly better style here.

 *)
						    


						    

		

			 
