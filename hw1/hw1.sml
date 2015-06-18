fun is_older (date1 : int*int*int, date2 : int*int*int) =
    if #1 date1 < #1 date2
    then true
    else
	if #2 date1 < #2 date2
	then true
	else
	    if #3 date1 < #3 date2
	    then true
	    else false

fun number_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then 0
    else
	let val mon = #2 (hd dates)
	in
	    if mon=month
	    then 1 + number_in_month(tl dates, month)
	    else number_in_month(tl dates, month)
	end

fun number_in_months (dates : (int*int*int) list, months : int list) =
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates , tl months)

fun dates_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then []
    else
	if #2 (hd dates) = month
	then hd dates :: dates_in_month(tl dates, month)
	else dates_in_month(tl dates, month)

fun dates_in_months (dates : (int*int*int) list, months: int list) =
    if null months
    then []
    else
	let val hd_list = dates_in_month(dates, hd months)
	    val tl_list = dates_in_months(dates, tl months)
	in if null hd_list
	   then tl_list
	   else revAppend (hd_list, tl_list)
	end

fun get_nth (st_list: string list, n : int) =
    if null st_list
    then NONE
    else
	if n=1
	then SOME (hd st_list)
	else get_nth(tl st_list, n-1)

fun date_to_string (date: int*int*int) =
    let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in valOf(get_nth(months, #2 date)) ^ " " ^  Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

fun number_before_reaching_sum (sum : int, list: int list) =
    if null list
    then 0
    else
	let fun sum_list (upto: int) =
		if null list
		then 0
		else if null (tl list) orelse upto=1
		then hd list
		else hd list + sum_list(upto-1)
	    val nth = 1;

	in
	    if sum_list(nth)>sum
	    then 0
	    else nth + sum_list(nth+1)
	end
	    
		
	


	
	

	    
