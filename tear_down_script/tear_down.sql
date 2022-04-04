-- This is a cleanup script and is used to delete everything that was setup.

use database tbd_sales;

use schema tbd_sales.raw;

drop table if exists raw.sales;
drop table if exists raw.employees;
drop table if exists raw.customers;
drop table if exists raw.products;

drop stage if exists raw.s3_stage_customers;
drop stage if exists raw.s3_stage_employees;
drop stage if exists raw.s3_stage_products;
drop stage if exists raw.s3_stage_sales;

drop schema if exists raw;

use schema tbd_sales.curated;

drop view if exists curated.customer_monthly_sales_2019_view;
drop view if exists curated.top_ten_customers_amount_view;
drop view if exists curated.product_sales_view;

drop table if exists curated.sales;
drop table if exists curated.employees;
drop table if exists curated.customers;
drop table if exists curated.products;

drop function if exists get_month(timestamp);

drop schema if exists curated;


drop database if exists tbd_sales;
