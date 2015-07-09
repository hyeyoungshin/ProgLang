(* Section 3: Fold and More Closures *)

(* Another famous function: Fold

 fold (and synonyms/ close relative reduce, inject, etc.) is another very famous iterator over recursive structures

 Accumulates an answer by repeatedly applying f to answer so far 
  - fold(f,acc,[x1,x2,x3,x4]) computes f(f(f(f(acc,x1),x2),x3),x4)



                                 fun fold (f,acc,xs) =
                                    case xs of
                               	      [] => acc
                                    | x::xs' => fold(f, f(acc,x), xs)

  - This version "folds left"; another version "folds right"
  - Whether the direction matters depends on f (often not)

 val fold = fn: ('a * 'b -> 'a) * 'a * 'b list -> 'a

 *)











(* Why iterators again?:

 - These "iterator-like" functions are not built into the language
  - Just a programming pattern
  - Though many languages have built-in support, which often allows stopping early without resorting to exceptions

 - This pattern separators recursive traversal from data processing
  - Can reuse same traversal for different data processing
  - Can reuse same data processing for different data structures
  - In both cases, using common vocabulary concisely communicates intent

 *)


fun fold (f,acc,xs) =
    case xs of
	[] => acc
      | x::xs' => fold (f, f(acc,x), xs')

(* note this is "fold left" if order matters
   can also do "fold right" *)

(* examples not using private data *)

fun f1 xs = fold ((fn (x,y) => x+y), 0, xs) (* sum list *)


(* are all list elements non-negative *)

fun f2 xs = fold ((fn (x,y) => x andalso y >=0), true, xs)


		 
(* examples using private data *)


(* counting the number of elements between lo and hi, inclusive *)

fun f3 (xs, lo, hi) =
    fold ((fn(x,y) => x + (if y >= lo andalso y <= hi then 1 else 0), 0, xs)


fun f4 (xs, s) =
    let val i = String.size s
    in
	fold((fn(x,y) => x andalso String.size y < i), true, xs)
    end
		  
fun f5 (g, xs) = fold((fn(x,y) => x andalso g y), true, xs)

fun f4again (xs,s) =
    let val i = String.size s
    in f5(fn y => String.size y < i, xs)
    end








(* Iterators made better:

 - Functions like map, filter, and fold are much more powerful thanks to closures and lexical scope

 - Function passed in can use any "private" data in its environment

 - Iterator "doesn't even know the data is there" or what type it has

 *)

	

		 
		       
		       

