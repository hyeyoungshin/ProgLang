fun older_max(xs: int list) =
    if null xs
    then 0
    else let val tl_ans = older_max(tl xs)
	 in if hd xs > tl_ans
	    then hd xs
	    else tl_ans
	 end
	     
