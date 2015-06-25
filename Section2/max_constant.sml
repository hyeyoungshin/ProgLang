(* Section 2: Another Expression Example *)

datatype exp = Constant of int
	     | Negate of exp
	     | Add of exp * exp
	     | Multiply of exp * exp

(* Note: assumes there is no library funtion for max of two ints. There is: Int.max *)

(* Bad style: Deep recursion, Duplicate code *)				     
fun max_constant1 e =
    case e of
	Constant i => i
      | Negate e2  => max_constant1 e2
      | Add(e1,e2) => if max_constant1 e1 > max_constant1 e2
		      then max_constant1 e1
		      else max_constant1 e2
      | Multiply(e1,e2) => if max_constant1 e1 > max_constant1 e2
			   then max_constant1 e1
			   else max_constant1 e2			

(* No more deep recursion *)
fun max_constant2 e =
    case e of
	Constant i => i
      | Negate e2  => max_constant2 e2
      | Add(e1,e2) =>
	let val m1 = max_constant2 e1
	    val m2 = max_constant2 e2
	in if m1 > m2 then m1 else m2 end
      | Multiply(e1,e2) =>
	let val m1 = max_constant2 e1
	    val m2 = max_constant2 e2
	in if m1 > m2 then m1 else m2 end

(* No duplicate code *)
fun max_constant3 e =
    let fun max_of_two(e1,e2) =
	    let val m1 = max_constant3 e1
		val m2 = max_constant3 e2
	    in if m1 > m2 then m1 else m2 end
    in
    case e of
	Constant i => i
      | Negate e2  => max_constant3 e2
      | Add(e1,e2) => max_of_two(e1, e2)
      | Multiply(e1,e2) => max_of_two(e1, e2)
    end

(* Using SML library *)
fun max_constant4 e =
    let fun max_of_two(e1,e2) =
	    let val m1 = max_constant4 e1
		val m2 = max_constant4 e2
	    in Int.max(m1,m2) end
    in
    case e of
	Constant i => i
      | Negate e2  => max_constant4 e2
      | Add(e1,e2) => max_of_two(e1, e2)
      | Multiply(e1,e2) => max_of_two(e1, e2)
    end

(* Make simpler *)
fun max_constant5 e =
    let fun max_of_two(e1,e2) =
	    Int.max(max_constant5 e1, max_constant5 e2)
    in
    case e of
	Constant i => i
      | Negate e2  => max_constant5 e2
      | Add(e1,e2) => max_of_two(e1, e2)
      | Multiply(e1,e2) => max_of_two(e1, e2)
    end

(* Make even more simpler *)
fun max_constant6 e =
    case e of
	Constant i => i
      | Negate e2  => max_constant6 e2
      | Add(e1,e2) => Int.max(max_constant6 e1, max_constant6 e2)
      | Multiply(e1,e2) => Int.max(max_constant6 e1, max_constant6 e2)
					     
val test_exp = Add (Constant 19, Negate (Constant 4))
val nineteen = max_constant6 test_exp
    
