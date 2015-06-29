(* some types are more general than other types *)

(* An example:
 - "Write a funtion that appends two string lists"
 *)

fun append (xs, ys) =
    case xs of
	[] => ys
      | x::xs' => x::append(xs',ys)

(* 
- You expect string list * string list -> string list
- Implementation says 'a list * 'a list -> 'a list
- This is okay: why?
*)

val ok1 = append(["hi", "bye"], ["programming", "languages"])

val ok2 = append([1,2], [4,5])

(* val not_ok = append([1,2], ["programming", "languages"]) *)











(* More general
    The type 
                     'a list * 'a list -> 'a list
    
    is more general than the type
                      
                     string list * string list -> string list

- it "can be used" as any less general type, such as
                      
                     int list * int list -> int list

- But it is not more general than the type
                      
                     int list * string list -> int list
 *)


















(* The "more general" rule

   Easy rule you and the type-checker can apply without thinking:

   A type t1 is more general than the type t2 if you can take t1, replace its type variables consistently, and get t2

- Example: Replace each 'a with int * int
	   Replace each 'a with bool and each 'b with bool
           Replace each 'a with bool and each b with int
           Replace each 'b with 'a and each 'a with 'a
 *)














(* Other rules

- Can combine the "more general" rule with rules for equivalence 
 - Use of type synosnyms does not matter
 - Order of field names does not matter

Example, given

                              type foo = int * int
the type		
                        {quux: 'b, bar: int * 'a, baz: 'b}

is more general than
                        {quux: string, bar: foo, baz: string}

which is equivalent to
                        {bar: int*int, baz: string, quuz: string}
		
 *)












(* Is the type 'a * 'b -> int more or less general than the type 'a * 'a -> 'a? 

Answer: Neither
Explanation: Neither is the answer because there is no consistent way of substituting each polymorphic type in the first type to get the second or vice versa.

For instance, we can substitute the 'a and 'b in the first type for 'a and 'a. respectively, to almost get the second type, but we can't substitute int for 'a. This means that the first type is not more general than the second.

Likewise, we can replace 'a in the second type for either 'a, 'b, or int to partially match the first type, but we can't substitute each occurence of 'a for a different type. This is especially apprent if we replace the 'a with int to get int*int -> int. We can no longer replace any polymorphic tyles to introduce the 'a and 'b of the first type. This means that the second type is not more general than the first.
 *)



















(* Equality types
- You might also see type variables with a second "quote"
 - Example: ''a list * ''a -> bool

- These are "equality types" that arise from using the = operator
 - The = operator works on lots of types: int, string, tuples containing all equality types, ...
 - But not all types: function types, real, ...

- The rules for more general are exactly the same except you have to replace an equality-type variable with a type that can be used with =
 - A "strange" feature of ML because = is special
 *)







(* ''a * ''a -> string *)
fun same_thing(x, y) =
    if x=y then "yes" else "no"

(* int -> string *)
fun is_three x =
    if x=3 then "yes" also "no"
