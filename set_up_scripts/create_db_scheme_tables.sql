-- This sql script is used to create the database, schemas and the tables.

create database if not exists tbd_sales;

use database tbd_sales;
create schema if not exists raw;
create schema if not exists curated;

use schema tbd_sales.raw;

create table if not exists employees (
  EmployeeID int PRIMARY KEY,
  FirstName varchar,
  MiddleInitial varchar,
  LastName varchar,
  Region varchar
);

create table if not exists customers (
  CustomerID int PRIMARY KEY,
  FirstName varchar,
  MiddleInitial varchar,
  LastName varchar
);

create table if not exists products (
  ProductID int PRIMARY KEY,
  Name varchar,
  Price number(20,5)  
);

create table if not exists sales (
  OrderID int PRIMARY KEY,
  SalesPersonID int FOREIGN KEY REFERENCES employees(EmployeeID),
  CustomerID int FOREIGN KEY REFERENCES customers(CustomerID),
  ProductID int FOREIGN KEY REFERENCES products(ProductID),
  Quantity int,
  Date_of_sale timestamp
);