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
	    

	    
