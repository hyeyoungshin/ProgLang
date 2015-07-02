(* Section 2: Recursion *)

(* Should now be comfortable with recursion:
  - No harder than using a loop (whatever that is)
  - Often much easier than a loop
   - When processing a tree (e.g., evaluate an arithmetic expression)
   - Examples like appending lists
   - Avoids mutation even for local variables

  - Now:
   - How to reason about efficiency of recursion
   - The importance of tail recursion
   - Using an accumulator to achieve tail recursion
   - [No new language features here]
 *)
















(* Call-stacks:
While a program runs, there is a call stack of function calls that have started but not yet returned
 - Calling a function f pushes an instance of f on the stack
 - When a call to f finishes, it is popped from the stack

These stack-frames store information like the value of local variables and "what is left to do" in the function

Due to recursion, multiple stack-frames may be calls to the same function
 *)






















(* Example Revised:

                                      fun fact n =
                                          let fun auz(n,acc) =
                                                 if n=0
                                                 then acc
                                                 else aux(n-1, acc*n)
                                          in 
                                              aux(n,1)
                                          end

val x = fact 3

- Still recursive, more complicated, but the result of recursive call is the result for the caller (no remaining multiplicatio
 *)






















(* Which of th following calls to aux is equivalent to fact 5? In other words, which of th following calls results in the same value as fact 5? 

                                fun fact n = 
                                  let fun aux(n, acc) =
                                       if n = 0
                                       then acc
                                       else aux(n-1, acc * n)
                                  in aux(n, 1)
                                  end
 *)




















(* An optimization:
- It is unnecessary to keep around a stack-fram just so it can get a callee's result and return it without ant further evaluation

- ML recognizes these tail calls in the compiler and treats them differently:
 - Pop the caller before the call, allowing callee to reuse the same stack space
 - (Along with other optimizations,) as efficient as a loop

- Reasonable to assume all functional-language implementations do tail-call optimization
 *)
