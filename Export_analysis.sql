### Analysing export data of India(2022-2023) 

	The dataset of export is officially downloaded from the 'https://data.gov.in/', a Open Government Data (OGD) Platform of India under National Data Sharing and Accessibility Policy (NDSAP).
It consist of two different tables 'export22' and 'export23' with the common columns items and country and including other columns quantity, amt_millions and total_amt.
The dataset is messy and need to perform data cleansing before proceeding with manipulation.

## The objective of this project includes,

1) Calculate the percentage growth of total amount for each item and country from 2022 to 2023.
 Identify the top 5 items and countries with the highest growth rates and the bottom 5 with the lowest growth rates.

2)Compare the total amount of exports for each country in 2022 and 2023.
 Determine which countries experienced the highest and lowest growth rates in export value over the two years.

3)Analyze the diversity of exported items for each country in 2022 and 2023.
 Identify countries with diversified export portfolios and assess their competitive advantage.

4)Explore the relationship between total amount and quantity of items exported for each country in 2022 and 2023.
 Calculate price indices to compare changes in unit prices over the two years.

5) Categorize countries into high-value, medium-value, and low-value segments based on their average total amount in 2022 and 2023.
 Analyze trends in export values within each segment and identify opportunities for targeting different customer segments.

 Let me start by performing basic wrangling.But before that make sure that the dataset is duplicated.
 
# DATA CLEANSING:
1)Removing unwanted columns and displaying the table:

select *
from [master].[dbo].[export22]

order by country asc
offset 0 rows
fetch first 10 rows only;

alter table [master].[dbo].[export22]
drop column UNIT;

2) getting distinct items and removing unwanted rows and null values:

select distinct items
from [master].[dbo].[export22]
order by items desc;

delete from [master].[dbo].[export22]
where items = 'TOTAL';

delete from [master].[dbo].[export22]
where items is null;

3) updating values in a table:

begin transaction;
update [master].[dbo].[export22]
set quantity_23 = 1
where quantity_23 = 'NA';

Before making changes to the original dataset, it is good to call transactions:

4) change the datatype of a column:

begin transaction;
alter table [master].[dbo].[export22]
alter column value_in_millions decimal(18,2);

commit transaction;

rollback transaction;

5)going to form a new column:

begin transaction;
create table #temptable(
			  sno int primary key identity,
			  na varchar(50),
			  value varchar(50));
insert into #temptable(na,value)
select PARSENAME(replace(amt_millions, ',','.'),2) as na, 
PARSENAME(replace(amt_millions, ',','.'),1) as value
from [master].[dbo].[export22];

select *
from [master].[dbo].[export22]

alter table [master].[dbo].[export22]
add sno int primary key identity;

commit transaction;

begin transaction;
alter table [master].[dbo].[export22]
add na varchar(50), value varchar(50);
update [master].[dbo].[export22]
set na = tt.na, value = tt.value
from [master].[dbo].[export22] mt
join #temptable tt
on tt.sno = mt.sno;

commit transaction;

drop table #temptable

6)joining two columns and changing datatype:

begin transaction;
alter table [master].[dbo].[export22]
add t_amt decimal(18,2);
update [master].[dbo].[export22]
set t_amt = CONCAT(na,'.',value);

commit transaction;
rollback transaction;

7) drop unwanted columns and trim extra spaces:

alter table [master].[dbo].[export22]
drop column na,value;

update [master].[dbo].[export22]
set items = trim(items),
country = trim(country);

select *
from [master].[dbo].[export22]

8) nearly 5000 rows of data has no value in item column. This is because of the error in data entry. The elements for items filled in country and country column filled with '"'(quotation mark) mark instead entering real data in it.
As we donot have any subject-matter-expertise to discuss the issue. Let me remove those rows.

begin transaction;
delete from [master].[dbo].[export22]
where items = ' ';
commit transaction;

I had given the code for cleaning export22 dataset. Similar need to be performed with the export23 dataset.

DATA MANIPULATION:

1) percent_growth of items in countries:

begin transaction;
alter table [master].[dbo].[export22]
add amt_23 decimal(18,2);
update t1
set amt_23 = t2.t_amt
from [master].[dbo].[export22] t1
join [master].[dbo].[export23] t2 
on t1.items=t2.items and t1.country=t2.country;

commit transaction;

with cts(items,country,percent_change) as
(
select items,country,
case
	when sum(amt_22) = 0 then 100.000000
	else((sum(amt_23)-sum(amt_22))/sum(amt_22))*100
	end as percent_change
from [master].[dbo].[export22]
group by items,country
)
select *,
ROW_NUMBER() over(order by percent_change DESC) as increasing_trade,
ROW_NUMBER() over(order by percent_change ASC) as decreasing_trade
from cts
order by percent_change desc;

Findings:

The top 5 items that the country exports from India as of 2022 and 2023 data that I have. The percentage differnce that out numbers other countries are,
PETROLEUM PRODUCTS to ALBANIA, TELECOM INSTRUMENTS to AUSTRIA and SUGAR to CAMEROON, JORDAN and TOGO.

And also we have down 5 items and countries. They are OTHER WOOD AND WOOD PRODUCTS to HONG KONG, RMG MANMADE FIBRES to ERITREA, TOBACCO MANUFACTURED to EGYPT A RP, AYUSH AND HERBAL PRODUCTS to CUBA and LEATHER GARMENTS to UKRAINE.

2)country-wise total exports for the year 2022 and 2023:

select country,sum(amt_22) as total_trade_2022,sum(amt_23) as total_trade_2023,
case
when sum(amt_22) = 0 then 100.0000
else ((sum(amt_23)-sum(amt_22))/sum(amt_22))*100 
end as percent_change_country
from [master].[dbo].[export22]
group by country
order by percent_change_country desc;

FINDINGS:

Almost 2/3rd of the countries remained positive in trade with India. But nearly 95 countries slipped to the negative trade. External Affairs ministry or Foreign trade ministry has to step into the issue with these countries and rectify them ASAP.
By the way, we can export more to other countries from 10% to 25%. Trade deficit of India will remains positive. So, we can add extra foreign reserves to our treasury.

3) to find the diversity of exported items for each country in 2022 and 2023:

update [master].[dbo].[export22]
set items = ''
where items like '"%';
select *
from [master].[dbo].[export23]

select distinct(items)
from [master].[dbo].[export22]

with cte as(
select country,count(distinct(items))as product_count, sum(amt_22) as product_value_22, sum(amt_23) as product_value_23
from [master].[dbo].[export22]
group by country)
select *
from cte
where product_count != 1
order by product_count desc;

FINDINGS:

These are the countries with diversified portfolio with India. Includes UNITED ARAB EMTS, U S A, NEPAL, GERMANY, BHUTAN, SINGAPORE, TURKEY, U K, ITALY and CANADA.
UAE remains top importer of Indian goods.

4) to find the relationship between the total amt and the quantity over year

Convertion of datatypes need to be performed before the manipulation starts. I thought that it is not necessary, but it needed.

begin transaction;
update [master].[dbo].[export23]
set quantity = case
					when TRY_CONVERT(numeric(18,2),quantity) is not null then quantity
					else 'NA'
					end;

select *
from [master].[dbo].[export22]

begin transaction;
alter table [master].[dbo].[export22]
add quantity_23 varchar(50);
update [master].[dbo].[export22]
set quantity_23 = t2.quantity
from [master].[dbo].[export23] t2
join [master].[dbo].[export22] t1
on t1.items=t2.items and t1.country=t2.country;

commit transaction;
 
update [master].[dbo].[export22]
set quantity_23 = 0
where quantity_23 = 'NA';
alter table [master].[dbo].[export22]
alter column quantity_22 numeric(38,0);
$$$
begin transaction;
alter table [master].[dbo].[export22]
add unit_22 numeric(18,2),
	unit_23 numeric(18,2),
	quantity_diff numeric(18,2)
update [master].[dbo].[export22]
set unit_22 = case
				when quantity_22 = 0 then 0
				else((amt_22*100000)/quantity_22) 
				end,
	unit_23 = case
				when quantity_23 = 0 then 0
				else((amt_23*100000)/quantity_23) 
				end,
	quantity_diff = (quantity_23 - quantity_22)

commit transaction;

begin transaction;
alter table [master].[dbo].[export22]
add unit_percent decimal(18,2)
update [master].[dbo].[export22]
set unit_percent = case
					when unit_23 = 0 then 0
					else ((unit_23 - unit_22)/unit_23)*100
					end
commit transaction;

select  *
from [master].[dbo].[export22];

FINDINGS:

Created a new column that contains the percentage change of each item in a country over the years.
For example: AGRO CHEMICALS for ARMENIA decreased in price by 12.82%

5) to find the above_average and below_average segments of countries based on their avg.total exports in 2022 and 2023:

begin transaction;
create table #t1(
	country_Above varchar(50) primary key,
	Export_in_millions decimal(18,2))
insert into #t1(country_Above,Export_in_millions)
select country ,sum(amt_23+amt_22) as Export_in_millions
from [master].[dbo].[export22]
where amt_23 >18.647868 or amt_22> 16.895115
group by country
order by Export_in_millions DESC;
commit transaction;
select *
from #t1;

begin transaction;
create table #t2(
	country_Below varchar(50) primary key,
	Export_in_millions_B decimal(18,2))
insert into #t2(country_Below,Export_in_millions_B)
select country ,sum(amt_23+amt_22) as Export_in_millions_B
from [master].[dbo].[export22]
where amt_23 <18.647868 or amt_22< 16.895115
group by country
order by Export_in_millions_B DESC;
commit transaction;

begin transaction;
create table #t3(
	country_above varchar(50) primary key,
	total_export decimal(18,2))
insert into #t3(country_above, total_export)
select country_Above,sum(Export_in_millions + Export_in_millions_B) as total_export
from #t1 A
join #t2 B
on B.country_Below = A.country_Above
group by country_Above
order by total_export DESC;
commit transaction;

select *
from [master].[dbo].[export22]

begin transaction;
create table below_table(
	country_below varchar(50) primary key,
	total_export decimal(18,2))
update [master].[dbo].[below_table]
set country,total_export =

select country,sum(amt_22+amt_23) as total_export
from [master].[dbo].[export22]
where country != (select country
					from [master].[dbo].[export22]
					where amt_23 >18.647868 or amt_22> 16.895115
					group by country)
group by country;

got the countries that had below_average_export performance:

SELECT country
FROM [master].[dbo].[export22]
group by country
EXCEPT
select country
from [master].[dbo].[export22]
where amt_23 >18.647868 or amt_22> 16.895115
group by country;

FINDINGS:

Out of 265 countries, 98 countries were performing below_average_export with India.

CONCLUSION:

	Trade is an essential exchange that every country performing to feed people and takecare of their nation. It is happy to see that India is exporting huge products of diversity to almost all the countries in the world.
It is what we need at this time, not the war, sanctions or trade halt. All the products that 'our mother earth' produces is common for all. It is possible through trade.

	India is growing in all aspects from the view of the rest of the world and I am going to prove it. The overall export trade volume of India in 2022 is 322578.44 millions and in 2023 is 356043.75 millions.
It is 9.40% increase than the last year.
