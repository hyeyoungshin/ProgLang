(* Section 3: Unnecessary Function Wrapping *)

fun n_times (f,n,x) =
    if n=0
    then x
    else f (n_times(f,n-1,x))

fun nth_tail(n,xs) = n_times((fn y => tl y), n,xs) (* unnecessary wrapping *)
fun nth_tail(n,xs) = n_times(tl, n,xs) (* tl does the same job *)



fun rev xs = List.rev xs
val rev = fn xs => List.rev xs
val rev = List.rev (* Best style *)

	      


			    
			    
			    
