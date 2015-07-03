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

(* ERROR: the return type of get_nth should be string (not string option) *)
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

fun number_before_reaching_sum (sum : int, list : int list) =
    if null list
    then 0
    else
	let fun sum_index (my_sum : int, my_list : int list, index : int) =
		if null list
		then 0
		else if (hd my_list) >= my_sum
		then index
		else sum_index(my_sum-(hd my_list), tl my_list, index+1)
	in sum_index(sum, list, 1)
	end


fun what_month (day : int) =
    let val months = [31,28,31,30,31,30,31,31,30,31,30,31]
    in number_before_reaching_sum(day, months)
    end
	
fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else if day1=day2
    then [what_month(day1)]
    else what_month(day1) :: month_range(day1+1, day2)

fun oldest (dates: (int*int*int) list) : (int*int*int) option =
    if null dates
    then NONE
    else if null (tl dates)
    then SOME (hd dates)
    else
	let 
	    fun older (date1: (int*int*int), date2: (int*int*int)) : (int*int*int)  =
		if #1 date1 < #1 date2
		then date1
		else if #1 date1 = #1 date2
		then
		    if #2 date1 < #2 date2
		    then date1
		    else if #2 date1 = #2 date2
		    then
			if #3 date1 < #3 date2
			then date1
		        else date2
		    else date2
		else date2

	in
	    SOME (older(hd dates, valOf (oldest(tl dates))))
	end
					
