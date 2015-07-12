(* Section 3: Optional: Closure Idioms Without Closures *)



(* Higher-order programming:

 - Higher-order programming, e.g., with map and filter, is great

 - Language support for closures makes it very pleasant

 - Without closures, we can still do it more manually / clumsily
    - In OOP (e.g., Java) with one-method interfaces
    - In procedural (e.g., C) with explicit environment arguments

 - Working through this:
    - Shows connections between languages and features
    - Can help you understand closures and objects

 *)




(* re-implementation of a list library with map, filter, length *)

datatype 'a mylist = Cons of 'a * ('a mylist)
       | Empty


fun map f xs =
    case xs of
	Empty => Empty
      | Cons (x,xs) => Cons(f x, map f xs)

fun filter f xs =
    case xs of
	Empty => Empty
      | Cons (x,xs) => if f x
		       then Cons(x, filter f xs)
		       else filter f xs

(* One fine way to double all numbers in a list *)
val doubleAll = map (fn x => x * 2)

(* One way to count Ns in a list *)
fun countNs (xs, n: int) = length (filter (fn x => x=n) xs)





















(* Java:

 - Java 8 scheduled to have closures (like C#, Scala, Ruby, ... )
    - Write like xs.map( (x) => x.age)
                 xs.filter( (x) => x > 21)
                 xs.length()
    - Make parallelism and collections much easier
    - Encourage less mutation

 - But how could we program in an ML style without help
    - Will not look like the code above
    - Was even more painful before Java had generics

 *)





(* One-method interfaces:

                 interface Func <B,A> { B m (A x); }
                 interface Pred <A> { boolean m (A x); }

 - An interface is a named [polymorphic] type
 - An object with one method can serve as a closure
    - Different instances can have different fields [possibly different types] like different closures can have different environments [possibly different types]
 - So an interface with one method can serve as a function type

 *)






(* List types:

 Creating a generic list class works fine
    - Assuming null for empty list here, a choice we may regret


               class List <T> {
                 T head;
                 List <T> tail;
                 List (T x, List<T> xs) {
                    head = x;
                    tail = xs;
                 }

                 ...
               }

 *)





(* Higher-order functions:

 - Let's use static methods for map, filter, length
 - Use our earlier generic interface for "function arguments"
 - These methods are recursive
    - Less efficient in Java
    - Much simpler than common previous-pointer acrobatics

 
 *)







(*				  
            // * the advantage of a static method is it lets xs be null 
	    //    -- a more OO way would be a subclass for empty lists
	    // * a more efficient way in Java would be a messy while loop where you keep a mut            //   able pointer to the previous element
            //    -- (try it if you do not believe it is messy)						  static <A,B> List<B> map(Func<B,A> f, List<A> xs) {
		if(xs==null) return null;
		return new List<B>(f.m(xs.head), map(f,xs.tail));
	    }
													  static <A> List<A> filter(Pred<A> f, List<A> xs) {
         	if(xs==null) return null;
	        if(f.m(xs.head))
		    return new List<A>(xs.head, filter(f,xs.tail));
		return filter(f,xs.tail);
     	    }

            // * again recursion would be more elegant but less efficient
            // * again an instance method would be more common, but then all clients have to d            //   eal with special case null
            static <A> int length(List<A> xs) {
                int ans = 0;
                while (xs != null) {
                    ++ans;
                    xs = xs.tail;
                }
                return ans;
            }
        }

      *)





(* Higher-order functions:

 A more OO approach would be instance methods:				  


          class List<T> {
            <B> List<B> map (Func<B,T> f) { ... }
            List<T> filter (Pred<T> f) { ... }
            int length() { ... }
          }

 Can work, but interacts poorly with nullfor empty list
    - Cannot call a method on null
    - So leads to extra cases in all clients of these methods if a list might be empty

 An even more OO alternative uses a subclass of List for empty-lists rather null
    - Then instance methods work fine!

 *)







(* Clients:

 - To use map methods to make a List<Bar> from a List<Foo>:
    - Define a class C that implements Func<Bar,Foo>
       - Use fileds to hold any "private data"
    - Make an object of class C, passing private data to constructor
    - Pass the object to map

 - As a convenience, can combine all 3 steps with anonymous inner classes
    - Mostly just syntactic sugar
    - But can directly access enclosing fields and final variables
    - Added to language to better support callbacks
    - Syntax an acquired taste?

 *)




(*
 
 class ExampleClients {
     static List<Integer> doubleAll(List<Integer> xs) {
         return List.map((new Func<Integer,Integer>() { 
                            public Integer m(Integer x) { 
                                return x*2;} }, xs);
     }
     static int countNs(List<Integer> xs, final int n) {
         return List.length(List.filter ((new Pred<Integer>() { 
                                            public boolean m(Integer x) { 
                                                return x==n;} }), xs));
        }
 }


*)
