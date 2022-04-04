-- This script loads the data from stage to created tables.

use database tbd_sales;
use schema tbd_sales.raw;

copy into customers
from @s3_stage_customers
pattern='.*Customers[0-9]*\.csv';

copy into employees
from @s3_stage_employees
pattern='.*Employees[0-9]*\.csv';

copy into products
from @s3_stage_products
pattern='.*Products[0-9]*\.csv';

copy into sales
from @s3_stage_sales
pattern='.*Sales[0-9]*\.csv';