use homework;
 declare @date date=getdate()

;with cte as( ---use recursive function for get the list of dates 
	select datefromparts(year(@date),month(@date),1) as datevalue

	union all

	select dateadd(day,1,datevalue) from cte
	where dateadd(day,1,datevalue)<=eomonth(datefromparts(year(@date),month(@date),1))
)


select ---get the ordered datas for calendar group by weeks
	max(case when datepart(weekday,datevalue)=1 then day(datevalue) else NUll end) as Sunday,
	max(case when datepart(weekday,datevalue)=2 then day(datevalue) else null end) as Monday,
	max(case when datepart(weekday,datevalue)=3 then day(datevalue) else null end) as Tuesday,
	max(case when datepart(weekday,datevalue)=4 then day(datevalue) else null end) as Wednesday,
	max(case when datepart(weekday,datevalue)=5 then day(datevalue) else null  end) as Thursday,
	max(case when datepart(weekday,datevalue)=6 then day(datevalue) else null end) as Friday,
	max(case when datepart(weekday,datevalue)=7 then day(datevalue) else null end) as Saturday
	
from(
	select*,
		(row_number() over(order by datevalue)-1)/7 as weeknum ---to order weeks
		from cte 
) as calendar
group by weeknum
order by weeknum;


