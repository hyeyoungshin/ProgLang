(* Section 2: Another Expression Example *)

datatype exp = Constant of int
	     | Negate of exp
	     | Add of exp * exp
	     | Multiply of exp * exp

(* Note: assumes there is no library funtion for max of two ints. There is: Int.max *)
				     
fun max_constant e =
    case e of
	Constant i => i
      | Negate e2  => max_constant e2
      | Add(e1,e2) => if max_constant e1 > max_constant e2
		      then max_constant e2
		      else max_constant e2
      | Multiply(e1,e2) => if max_constant e1 > max_constant e2
			   then max_constant e1
			   else max_constant e2
					     
val test_exp = Add (Constant 19, Negate (Constant 4))
		   val nineteen = max_constant test_exp
    
