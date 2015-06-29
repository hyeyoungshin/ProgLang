(* Examples of using pattern mathing for tuples and records: 
 poor style to have one-branch cases *)

fun sum_triple_bad triple =
    case triple of
	(x, y, z) => x + y + z

fun full_name_bad r =
    case r of
	{first=x, middle=y, last=z} => x ^ " " ^ y " " ^ z

(* Better example *)

fun sum_triple_better triple =
    let val (x, y, z) = triple
    in x + y + z
    end

fun full_name_better r =
    let val {first=x, middle=y, last=z} = r
    in x ^ " " ^ y ^ " " ^ z
    end

(* Great style! *)
fun sum_triple (x, y, z) =
    x + y + z

fun full_name {first=x, middle=y, last=z} =
    x ^ " " ^ y ^ " " ^ z
