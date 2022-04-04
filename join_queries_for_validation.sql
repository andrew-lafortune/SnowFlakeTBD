with uniq_products as (
select distinct PRODUCTID as pid_from_sales from sales
),
p_id as (
select distinct PRODUCTID as pid_from_products from products
)

select pid_from_sales, pid_from_products
from uniq_products
left outer join p_id
on pid_from_sales = pid_from_products
where pid_from_products is null;



with uniq_emp as (
select distinct SALESPERSONID as eid_from_sales from sales
),
e_id as (
select distinct EmployeeID as eid_from_employees from employees
)

select eid_from_sales, eid_from_employees
from uniq_emp
left outer join e_id
on eid_from_sales = eid_from_employees
where eid_from_employees is null;



with uniq_cus as (
select distinct CUSTOMERID as cid_from_sales from sales
),
c_id as (
select distinct CUSTOMERID as cid_from_customers from customers
)

select cid_from_sales, cid_from_customers
from uniq_cus
left outer join c_id
on cid_from_sales = cid_from_customers
where cid_from_customers is null;


with duplicate_customer as (
    select CUSTOMERID, count(*) as number_of_occurances 
    from customers
    group by CUSTOMERID
    having number_of_occurances > 1;
)

select CustomerID, FirstName, MiddleInitial, LastName from (
    select *, row_number() over (partition by CUSTOMERID order by FirstName) as occurance_number
    from customers
)
where occurance_number > 1;

