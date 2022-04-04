-- This script filters the data errors and loads data into the curated schema.

use database tbd_sales;
use schema tbd_sales.curated;

create table if not exists sales as select * from tbd_sales.raw.sales;
create table if not exists employees as select * from tbd_sales.raw.employees;
-- filters primary key duplication
create table if not exists customers as (
	select CustomerID, FirstName, MiddleInitial, LastName from (
	    select *, row_number() over (partition by CUSTOMERID order by FirstName) as occurance_number
	    from tbd_sales.raw.customers
	)
	where occurance_number = 1
);
create table if not exists products as select * from tbd_sales.raw.products;
