create function get_month (a timestamp)
  returns varchar
  as
  $$
    decode(date_part(month, a),
           1, 'January',
           2, 'February',
           3, 'March',
           4, 'April',
           5, 'May',
           6, 'June',
           7, 'July',
           8, 'August',
           9, 'September',
           10, 'October',
           11, 'November',
           12, 'December')
  $$
;

create view customer_monthly_sales_2019_view as (
  with product_enriched_sales as (
    select sales.CustomerID, date_part(year, Date_of_sale) as year_of_sale, get_month(Date_of_sale) as month_of_sale, sales.ProductID, products.Price*Quantity as price
    from sales
    inner join products
    on products.ProductID = sales.ProductID
    where year_of_sale = 2019
  ),
  grouped_sales as (
    select CustomerID as Customer_ID, year_of_sale as year, month_of_sale as month, sum(price) as total_amount
    from product_enriched_sales
    group by Customer_ID, year, month
  )

  select Customer_ID, LastName as Customer_LastName, FirstName as Customer_FirstName, year, month, total_amount
  from grouped_sales
  inner join customers
  on customers.CustomerID = Customer_ID
);


create view top_ten_customers_amount_view as (
  with product_enriched_sales as (
    select sales.CustomerID, products.Price as price
    from sales
    inner join products
    on products.ProductID = sales.ProductID
  ),
  grouped_sales as (
    select CustomerID as Customer_ID, sum(price) as total_amount
    from product_enriched_sales
    group by Customer_ID
  )

  select Customer_ID, LastName as Customer_LastName, FirstName as Customer_FirstName, total_amount as total_lifetime_purchased
  from grouped_sales
  inner join customers
  on customers.CustomerID = Customer_ID
  order by total_lifetime_purchased desc
  limit 10
);

create view product_sales_view as (
  select OrderID, SalesPersonID, CustomerID, sales.ProductID, Name as Product_Name, Price as Product_Price, Quantity, (Price*Quantity) as total_sales_amount, date_part(day, Date_of_sale) as order_date, date_part(year, Date_of_sale) as sales_year, get_month(Date_of_sale) as sales_month
  from sales
  inner join products
  on products.ProductID = sales.ProductID
);



