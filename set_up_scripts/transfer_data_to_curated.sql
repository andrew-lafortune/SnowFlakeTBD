-- This script filters the data errors and loads data into the curated schema.

use database tbd_sales;
use schema tbd_sales.curated;

create table if not exists sales as select * from tbd_sales.raw.sales;
create table if not exists employees as select * from tbd_sales.raw.employees;
create table if not exists customers as select * from tbd_sales.raw.customers;
create table if not exists products as select * from tbd_sales.raw.products as p where p.Price>0;
