 -- This sql script is used to create stages. It sets the source from where we import data.

use database tbd_sales;
use schema tbd_sales.raw;

create stage if not exists s3_stage_customers
url = 's3://seng5709/customers/'
file_format = (type = CSV FIELD_DELIMITER = '|' SKIP_HEADER = 1);

create stage if not exists s3_stage_employees
url = 's3://seng5709/employees/'
file_format = (type = CSV FIELD_DELIMITER = ',' SKIP_HEADER = 1);

create stage if not exists s3_stage_products
url = 's3://seng5709/products/'
file_format = (type = CSV FIELD_DELIMITER = '|' SKIP_HEADER = 1);

create stage if not exists s3_stage_sales
url = 's3://seng5709/sales/'
file_format = (type = CSV FIELD_DELIMITER = '|' SKIP_HEADER = 1);
