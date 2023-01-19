
-----Today Caption:-SCHEMAS MODELING

create table "orders_table" (
"id" numeric,	
"account_id" numeric,
"occurred_at" date,	
"standard_qty" numeric,	
"gloss_qty" numeric,	
"poster_qty" numeric,	
"total" numeric,	
"standard_amt_usd" numeric,	
"gloss_amt_usd" numeric,	
"poster_amt_usd" numeric,	
"total_amt_usd" numeric
);


create table "account_table"(
"id" numeric,	
"name" text,	
"website" varchar,	
"lat" numeric,	
"long" numeric,	
"primary_poc" text,	
"sales_rep_id" numeric
);

create table "region_table"(
"id" numeric,	
"name" text
);


create table "sales_table"(
"id" numeric,	
"name" text,	
"region_id" numeric
);

create table "web_table"( 
"id" numeric,	
"account_id" numeric,	
"occurred_at" date,	
"channel" text

);

select *
from "web_table";

select *
from "sales_table";

select *
from "region_table";


select *
from "account_table";


select *
from "orders_table";  

------joining the 3 table together by their relations
select a.sales_rep_id "sales_id", a.name "company_name", o.total "order total",
s.name "sales_rep_name"
from "account_table" a
join "orders_table" o
on a.id =o.account_id
join "sales_table" s
on a.sales_rep_id = s.id;


------ To know the company name and sales rep that sale highest

select "sales_rep_name", "company_name", sum("order_total") as "sum_total"
from
(select a.sales_rep_id "sales_id", a.name "company_name", o.total "order_total",
s.name "sales_rep_name"
from "account_table" a
join "orders_table" o
on a.id =o.account_id
join "sales_table" s
on a.sales_rep_id = s.id) as "table_one"
group by "sales_rep_name", "company_name"
order by "sum_total" desc
limit 5;

-------The company that made the highest sales and which channel that the used to make the highest sales

select "channel", "name", sum("total") as "sum_total"
from
(select a.name, o.total, w.channel
from "account_table" a
join "orders_table" o
on a.id = o.account_id
join "web_table" w
on a.id = w.account_id) as "table_one"
group by "channel", "name"
order by "sum_total" desc;

------How to extract day of the week

(select "total", extract(DOW from "occurred_at") as "week_day"
from "orders_table")

   
   
select "Day_Of_The_Week", sum("total") as "sum_total"
from
(select "total", 
case when "week_day" = 0 then 'Sunday'
 when "week_day" = 1 then 'Monday'
  when "week_day" = 2 then 'Tuesday'
   when "week_day" = 3 then 'Wednesday'
    when "week_day" = 4 then 'Thursday'
	 when "week_day" = 5 then 'Friday'
	  when "week_day" = 6 then 'Saturday'
else 'saturday' end as "Day_Of_The_Week"
from
(select "total", extract(DOW from "occurred_at") as "week_day"
from "orders_table") as "table_one") as "table_two"

group by "Day_Of_The_Week"
order by "sum_total" desc;

-----Assignment one

1-----extract month and day of the week from occurred_at 
2-----ERD

 --------Answer 1
 
select "Month_Of_The_Year", sum("total") as "sum_total"
from
(select "total", 
case when "Month" = 0 then 'January'
 when "Month" = 1 then 'Febuary'
  when "Month" = 2 then 'March'
   when "Month" = 3 then 'April'
    when "Month" = 4 then 'May'
	 when "Month" = 5 then 'June'
	  when "Month" = 6 then 'July'
 when "Month" = 7 then 'August'
  when "Month" = 8 then 'September'
   when "Month" = 9 then 'October'
    when "Month" = 10 then 'November'
	 when "Month" = 11 then 'December'
 
else 'January' end as "Month_Of_The_Year"
from
(select "total", extract(month from "occurred_at") as "Month"
from "orders_table") as "table_one") as "table_two"

group by "Month_Of_The_Year"
order by "sum_total" desc;






