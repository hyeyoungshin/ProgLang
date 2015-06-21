(* Enumerations, including carrying other data *)
datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int

(* Alternate ways of identifying real-world things/people *)
datatype id = StudentNum of int
	    | Name of string*(string option)*string

(* Bad style: each-of types are used where one-of types are the right tool *)

(* use the student_num and ignore other fields unless the student_num is ~1 *)
{ student_num : int,
  first       : string,						   
  middle      : string option,
  last        : stirng }
