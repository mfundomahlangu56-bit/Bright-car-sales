SELECT
  *
FROM
  "CAR_SALES"."CAR_SALES_DATA"."CAR_SALES_DATA_SET"
LIMIT
  10;

--total revenue
  SELECT
  SUM(SELLINGPRICE) AS 
  REVENUE
  FROM CAR_SALES_DATA_SET
  GROUP BY YEAR,SELLINGPRICE;


--revenue of car
  select make,
  model,sum(sellingprice) as
  revenue
  from car_sales_data_set
  group by all;

--avg number car sold
  select year,
  avg(sellingprice) as 
  avg_price
  from car_sales_data_set
  group by year;

--total number of manufacture
select sum(year)as
total_year_manufacture
from car_sales_data_set;

--counting the total model
select count(model) as
total_model
from car_sales_data_set;

--convert to mileage
select year,
make,
model,
(odometer) as
mileage
from car_sales_data_set;

--convert to get date and time

SELECT SUM(SELLINGPRICE) AS 
  REVENUE,
    TO_VARCHAR(
        TRY_TO_TIMESTAMP(SUBSTR(saledate, 1, 24), 'DY MON DD YYYY HH24:MI:SS'),
        'YYYY-MM-DD HH24:MI:SS'
    ) AS sale_timestamp
FROM car_sales_data_set
group by all;



-- extract date 
select 
to_date(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss')) as date,
from car_sales_data_set;
   

--using to_date and to_char to get day of week
select 
 to_date(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss')) as date,
   to_char(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss'),
   'dy') as day_of_week
   from car_sales_data_set;

select 
 to_date(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss')) as date,
   to_char(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss'),
   'mon dd yyyy') as year_name
   from car_sales_data_set;
   

--using to_char to extract time
select
 to_varchar(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss'),
   'hh24:mi;ss') as time
   from car_sales_data_set;

--preparing for final preparations   
select
year,
 make,
  model,sum(sellingprice) as
  revenue,
  count(model) as
total_model,
  sum(year)as
total_year_manufacture,
 avg(sellingprice) as 
  avg_price,
(odometer) as
mileage,
case
    when mileage <20000 then 
'0-20k'  
when mileage between 20000 and 50000
    then '20k-50k'
when mileage between 50000 and 100000
    then '50k-100k'
        else '100k+'
end as mileage_band,        
   to_varchar(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss'),
   'hh24:mi;ss') as time,
case 
    when extract(hour from try_to_timestamp(substr(
    saledate,1,24),'dy mon dd yyyy hh24:mi:ss'))
    between 6 and 20 then'business hours'
 else 'off hours' 
 end as period,
 to_date(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss')) as date,
   to_char(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss'),
   'mon dd yyyy') as year_name,
case
    when extract(year from try_to_timestamp(
substr(saledate,1,24),'dy mon dd yyyy hh24:mi:ss')) 
< 2015 then 'before 2015'
when extract(year from try_to_timestamp(
substr(saledate,1,24),'dy mon dd yyyy hh24:mi:ss')) 
between 2015 and 2020 then '2015-2020' else 'after 2020'
end as year_group,
   to_date(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss')) as date,
   to_char(
    try_to_timestamp(
    substr(saledate,1,24),
   'dy mon dd yyyy hh24:mi:ss'),
   'dy') as day_of_week,
    case
        when extract(dow from try_to_timestamp(substr(saledate, 1, 24),
        'DY MON DD YYYY HH24:MI:SS')) in (0, 6) then 'Weekend'
    else 'Weekday'
end as day_type
     from car_sales_data_set
   group by all;
   