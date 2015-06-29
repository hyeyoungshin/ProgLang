(* instead of using built in list, we can define our own list *)
datatype my_int_list = Empty
		     | Cons of int * my_int_list

val x = Cons(4, Cons(23, Cons(2008, Empty)))

fun append_my_list (xs,ys) =
    case xs of
	Empty => ys
     | Cons(x, xs') => Cons(x, append_my_list(xs',ys))  

	
