(* More of tail recursion:

- Where reasonably elegant, feasible, and important, rewriting functions to be tail-recursive can be much more efficient
 - Tail-recursive: recursive calls are tail-calls

- There is a methodology that can often guide this transformation
 - Create a helper function that takes an accumulator
 - Old base case becomes initial accumulator
 - New base case becomes final accumulator
 *)






















(* Another example:

                                 fun sum xs = 
                                    case xs of
                                        [] => 0
                                       | x::xs' => x + sum xs' 



                                 fun sum xs = 
                                     let fun aux (xs, acc) = 
                                            case xs of 
                                               [] => acc
                                             | x::xs' => aux(xs', x+acc)
                                      in
                                          aux(xs,0)
                                      end
 

 *)
