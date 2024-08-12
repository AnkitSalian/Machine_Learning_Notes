SET SQL_SAFE_UPDATES = 0;


-- Module: Database Design and Introduction to SQL
-- Session: Database Creation in MySQL Workbench
-- DDL Statements

-- 1. Create a table shipping_mode_dimen having columns with their respective data types as the following:
--    (i) Ship_Mode VARCHAR(25)
--    (ii) Vehicle_Company VARCHAR(25)
--    (iii) Toll_Required BOOLEAN

create table shipping_mode_dimen (
	Ship_Mode VARCHAR(25),
    Vehicle_Company VARCHAR(25),
    Toll_Required BOOLEAN
);

-- 2. Make 'Ship_Mode' as the primary key in the above table.
alter table shipping_mode_dimen
add constraint primary key (Ship_Mode);
-- -----------------------------------------------------------------------------------------------------------------
-- DML Statements

-- 1. Insert two rows in the table created above having the row-wise values:
--    (i)'DELIVERY TRUCK', 'Ashok Leyland', false
--    (ii)'REGULAR AIR', 'Air India', false

insert into shipping_mode_dimen (Ship_Mode, Vehicle_Company, Toll_Required) 
values ('DELIVERY TRUCK', 'Ashok Leyland', false),
('REGULAR AIR', 'Air India', false);

select * from shipping_mode_dimen;

-- 2. The above entry has an error as land vehicles do require tolls to be paid. Update the ‘Toll_Required’ attribute
-- to ‘Yes’.

update shipping_mode_dimen
set Toll_Required = true
where Ship_Mode = 'DELIVERY TRUCK';

-- 3. Delete the entry for Air India.

delete from shipping_mode_dimen
where Ship_Mode = 'REGULAR AIR';

select * from shipping_mode_dimen;
-- -----------------------------------------------------------------------------------------------------------------
-- Adding and Deleting Columns

-- 1. Add another column named 'Vehicle_Number' and its data type to the created table. 

alter table shipping_mode_dimen
add column Vehicle_Number VARCHAR(20);

-- 2. Update its value to 'MH-05-R1234'.

UPDATE shipping_mode_dimen
set Vehicle_Number = 'MH-05-R1234';

-- 3. Delete the created column.

alter table shipping_mode_dimen
drop column Vehicle_Number;

-- -----------------------------------------------------------------------------------------------------------------
-- Changing Column Names and Data Types

-- 1. Change the column name ‘Toll_Required’ to ‘Toll_Amount’. Also, change its data type to integer.

alter table shipping_mode_dimen
change Toll_Required Toll_Amount int;

-- 2. The company decides that this additional table won’t be useful for data analysis. Remove it from the database.

drop table shipping_mode_dimen;

-- -----------------------------------------------------------------------------------------------------------------
-- Session: Querying in SQL
-- Basic SQL Queries

-- 1. Print the entire data of all the customers.
select * from cust_dimen;

-- 2. List the names of all the customers.

select Customer_Name from cust_dimen;

-- 3. Print the name of all customers along with their city and state.

select Customer_Name, City, State from cust_dimen;

-- 4. Print the total number of customers.
select count(*) as Total_Customers
from cust_dimen;

-- 5. How many customers are from West Bengal?

select count(1) as West_Bengal_Customer
from cust_dimen
where State = "West Bengal";

-- 6. Print the names of all customers who belong to West Bengal.

select Customer_Name as West_Bengal_Customer
from cust_dimen
where State = "West Bengal";

-- -----------------------------------------------------------------------------------------------------------------
-- Operators

-- 1. Print the names of all customers who are either corporate or belong to Mumbai.

select Customer_Name 
from cust_dimen
where City = "Mumbai" or Customer_Segment = "Corporate";

-- 2. Print the names of all corporate customers from Mumbai.

select Customer_Name 
from cust_dimen
where City = "Mumbai" and Customer_Segment = "Corporate";

-- 3. List the details of all the customers from southern India: namely Tamil Nadu, Karnataka, Telangana and Kerala.

select * 
from cust_dimen
where State in ("Tamil Nadu", "Karnataka", "Telangana", "Kerala");

-- 4. Print the details of all non-small-business customers.

select * from cust_dimen
where not Customer_Segment = 'SMALL BUSINESS';

-- 5. List the order ids of all those orders which caused losses.

select Ord_id, Profit from market_fact_full
where Profit < 0;

-- 6. List the orders with '_5' in their order ids and shipping costs between 10 and 15.

select * from market_fact_full
where Ord_id like "%\_5%" and Shipping_Cost between 10 and 15;

select * from cust_dimen
where City like "K%";
-- -----------------------------------------------------------------------------------------------------------------
-- Aggregate Functions

-- 1. Find the total number of sales made.

select count(Sales) as Toal_number_of_Sales from market_fact_full;
-- 2. What are the total numbers of customers from each city?

select City, count(Customer_Name) as Total_Number_Of_Customer from cust_dimen 
group by City;
-- 3. Find the number of orders which have been sold at a loss.

select count(Ord_id) as "Number of Orders" from market_fact_full
where Profit < 0;

-- 4. Find the total number of customers from Mumbai in each segment.
select Customer_Segment, count(Customer_Name) from cust_dimen
where City = "Mumbai"
group by Customer_Segment;

-- 5. Find the customers who incurred a shipping cost of more than 50.

select * from market_fact_full
where Shipping_Cost > 50;

-- -----------------------------------------------------------------------------------------------------------------
-- Ordering

-- 1. List the customer names in alphabetical order.

select Customer_Name from cust_dimen
order by Customer_Name;

select distinct Customer_Name from cust_dimen
order by Customer_Name;

select Customer_Name, State from cust_dimen
order by State, Customer_Name;

-- 2. Print the three most ordered products.

select Prod_id, sum(Order_Quantity) as Total_Ordered_Products 
from market_fact_full
group by Prod_id
order by Total_Ordered_Products desc
limit 3;

-- 3. Print the three least ordered products.

select Prod_id, sum(Order_Quantity) as Total_Ordered_Products 
from market_fact_full
group by Prod_id
order by Total_Ordered_Products
limit 3;

-- 4. Find the sales made by the five most profitable products.

select Prod_id, sum(Profit) as Total_Profit 
from market_fact_full
group by Prod_id
order by Total_Profit desc
limit 5;

-- 5. Arrange the order ids in the order of their recency.
select Ord_id from market_fact_full
order by Ord_id desc;

-- 6. Arrange all consumers from Coimbatore in alphabetical order.
select Customer_Name from cust_dimen
where City = "Coimbatore"
order by Customer_Name;

-- -----------------------------------------------------------------------------------------------------------------

SELECT CONCAT(
    UPPER(SUBSTRING(name, 1, 1)),  -- Capitalize the first letter of the first name
    LOWER(SUBSTRING(name, 2, LOCATE(' ', name) - 1)), -- Lowercase the rest of the first name
    ' ',  -- Add a space between the first and last names
    UPPER(SUBSTRING(name, LOCATE(' ', name) + 1, 1)),  -- Capitalize the first letter of the last name
    LOWER(SUBSTRING(name, LOCATE(' ', name) + 2)) -- Lowercase the rest of the last name
) AS camel_case_name
FROM (SELECT 'ANKIT SALIAN' AS name) AS temp;

-- String and date-time functions

-- 1. Print the customer names in proper case.

select Customer_Name, concat(
	upper(substring(Customer_Name, 1, 1)),
    lower(substring(Customer_Name, 2, locate(" ", Customer_Name) -1)),
    " ",
    upper(substring(Customer_Name, locate(" ", Customer_Name) + 1, 1)),
    lower(substring(Customer_Name, locate(" ", Customer_Name) + 2))
) as Camel_Cased_Names
from cust_dimen;

-- 2. Print the product names in the following format: Category_Subcategory.

select concat(Product_Category, "_", Product_Sub_Category) as Category_Subcategory
from prod_dimen;

-- 3. In which month were the most orders shipped?

select month(Ship_Date) as Month, count(Ship_id) as Orders_shipped from shipping_dimen
group by Month
order by Orders_shipped desc
limit 1;

-- 4. Which month and year combination saw the most number of critical orders?

select year(Ship_Date) as Year, month(Ship_Date) as Month, count(Ship_id) as Orders_shipped from shipping_dimen
group by Year, Month
order by Orders_shipped desc
limit 1;


-- 5. Find the most commonly used mode of shipment in 2011.

select Ship_Mode, count(Ship_Mode) as Frequency from shipping_dimen
group by Ship_Mode
order by Frequency desc
limit 1;

-- -----------------------------------------------------------------------------------------------------------------
-- Regular Expressions

-- 1. Find the names of all customers having the substring 'car'.

select Customer_Name from cust_dimen
where Customer_Name regexp "car";

-- 2. Print customer names starting with A, B, C or D and ending with 'er'.

select Customer_Name from cust_dimen
where Customer_Name regexp "^[abcd].*er$";

-- -----------------------------------------------------------------------------------------------------------------
-- Nested Queries

-- 1. Print the order number of the most valuable order by sales.
select * from market_fact_full
where Sales = (
	select max(Sales) from market_fact_full
);

-- 2. Return the product categories and subcategories of all the products which don’t have details about the product
-- base margin.
select Prod_id, Product_Category, Product_Sub_Category from prod_dimen
where Prod_id in (select Prod_id from market_fact_full where Product_Base_Margin is null);

-- 3. Print the name of the most frequent customer.

select * from cust_dimen
where Cust_id = (
	select Cust_id from market_fact_full
	group by Cust_id
	order by count(Cust_id) desc
	limit 1
);

-- 4. Print the three most common products.

select * from prod_dimen
where Prod_id in (
	select Prod_id from (
		select Prod_id from market_fact_full
		group by Prod_id
		order by count(Prod_id) desc
		limit 3
	) as Product_Data
);

-- -----------------------------------------------------------------------------------------------------------------
-- CTEs

-- 1. Find the 5 products which resulted in the least losses. Which product had the highest product base
-- margin among these?

with least_losses as (
	select * from market_fact_full
	where Profit < 0
) select * from least_losses
order by Product_Base_Margin desc
limit 5;

-- 2. Find all low-priority orders made in the month of April. Out of them, how many were made in the first half of
-- the month?

with lowest_priorty as (
	select * from orders_dimen
    where Order_Priority = "LOW" and month(Order_Date) = 4
) select * from lowest_priorty
where day(Order_Date) between 1 and 15;

-- -----------------------------------------------------------------------------------------------------------------
use market_star_schema;
-- Views

-- 1. Create a view to display the sales amounts, the number of orders, profits made and the shipping costs of all
-- orders. Query it to return all orders which have a profit of greater than 1000.

create view orderInfo as (
	select * from market_fact_full
);

select * from orderInfo 
where Profit > 1000;

-- 2. Which year generated the highest profit?


-- -----------------------------------------------------------------------------------------------------------------
-- Session: Joins and Set Operations
-- Inner Join

-- 1. Print the product categories and subcategories along with the profits made for each order.

select p.Product_Category, p.Product_Sub_Category, m.Profit
from market_fact_full m
inner join prod_dimen p
on m.Prod_id = p.Prod_id; 

-- 2. Find the shipment date, mode and profit made for every single order.

select s.Ship_Date, s.Ship_Mode, m.Profit
from market_fact_full m
inner join shipping_dimen s
on m.Ship_id = s.Ship_id;

-- 3. Print the shipment mode, profit made and product category for each product.

select s.Ship_Mode, m.Profit, p.Product_Category
from market_fact_full m
inner join shipping_dimen s
on m.Ship_id = s.Ship_id
inner join prod_dimen p
on m.Prod_id = p.Prod_id;

-- 4. Which customer ordered the most number of products?

select c.Customer_Name, sum(m.Order_Quantity) as Total_Orders from cust_dimen c
inner join market_fact_full m
on c.Cust_id = m.Cust_id
group by c.Customer_Name
order by Total_Orders desc
limit 1;

-- 5. Selling office supplies was more profitable in Delhi as compared to Patna. True or false?

select c.City, sum(m.Profit) as Total_Profit from cust_dimen c
right join market_fact_full m
on c.Cust_id = m.Cust_id
inner join prod_dimen p
using (Prod_id)
where c.City in ("Delhi", "Patna") and p.Product_Category = "OFFICE SUPPLIES"
group by c.City
order by Total_Profit desc;

-- 6. Print the name of the customer with the maximum number of orders.

select c.Customer_Name, count(m.Ord_id) as Total_Orders from cust_dimen c
inner join market_fact_full m
on c.Cust_id = m.Cust_id
group by c.Customer_Name
order by Total_Orders desc
limit 1;

-- 7. Print the three most common products.

select p.Prod_id, count(m.Ord_id) as Total_Orders from prod_dimen p
inner join market_fact_full m
on p.Prod_id = m.Prod_id
group by p.Prod_id
order by Total_Orders desc
limit 3;

-- -----------------------------------------------------------------------------------------------------------------
-- Outer Join

-- 1. Return the order ids which are present in the market facts table.

select Ord_id from market_fact_full;

select * from prod_dimen;
-- Execute the below queries before solving the next question.
create table manu (
	Manu_Id int primary key,
	Manu_Name varchar(30),
	Manu_City varchar(30)
);

insert into manu values
(1, 'Navneet', 'Ahemdabad'),
(2, 'Wipro', 'Hyderabad'),
(3, 'Furlanco', 'Mumbai');

alter table Prod_Dimen
add column Manu_Id int;

update Prod_Dimen
set Manu_Id = 2
where Product_Category = 'technology';

-- 2. Display the products sold by all the manufacturers using both inner and outer joins.

select m.Manu_Name, p.Product_Category from manu m
inner join prod_dimen p
using (Manu_Id);

select m.Manu_Name, p.Product_Category from manu m
left join prod_dimen p
using (Manu_Id);

-- 3. Display the number of products sold by each manufacturer.

select m.Manu_Name, count(p.Prod_id) as Product_Sold from manu m
left join prod_dimen p
using (Manu_Id)
group by m.Manu_Name
order by Product_Sold desc;

-- 4. Create a view to display the customer names, segments, sales, product categories and
-- subcategories of all orders. Use it to print the names and segments of those customers who ordered more than 20
-- pens and art supplies products.


-- -----------------------------------------------------------------------------------------------------------------
-- Union, Union all, Intersect and Minus

-- 1. Combine the order numbers for orders and order ids for all shipments in a single column.

-- 2. Return non-duplicate order numbers from the orders and shipping tables in a single column.

-- 3. Find the shipment details of products with no information on the product base margin.

-- 4. What are the two most and the two least profitable products?


-- -----------------------------------------------------------------------------------------------------------------
-- Module: Advanced SQL
-- Session: Window Functions	
-- Window Functions in Detail

-- 1. Rank the orders made by Aaron Smayling in the decreasing order of the resulting sales.

select 
	c.Customer_Name,
    m.Ord_id,
    round(m.Sales) as rounded_sales,
    rank() over(order by sales desc) as sales_rank
from market_fact_full m
inner join cust_dimen c
using (Cust_id)
where Customer_Name = "Aaron Smayling";

-- top 10 sales by Aaron Smayling

with sales_ranking as (
	select 
		c.Customer_Name,
		m.Ord_id,
		round(m.Sales) as rounded_sales,
		rank() over(order by sales desc) as sales_rank
	from market_fact_full m
	inner join cust_dimen c
	using (Cust_id)
	where Customer_Name = "Aaron Smayling"
) 
select * from sales_ranking
where sales_rank <= 10;

-- 2. For the above customer, rank the orders in the increasing order of the discounts provided. Also display the
-- dense ranks.

select 
	c.Customer_Name,
    m.Ord_id,
    m.Discount,
    rank() over(order by m.Discount desc) as discount_rank,
    dense_rank() over(order by m.Discount desc) as discount_dense_rank
from market_fact_full m
inner join cust_dimen c
using (Cust_id)
where Customer_Name = "Aaron Smayling";

-- 3. Rank the customers in the decreasing order of the number of orders placed.

select 
	c.Customer_Name,
    count(distinct Ord_id) as Total_Orders,
    rank() over (order by count(distinct Ord_id) desc) as rank_orders,
    dense_rank() over (order by count(distinct Ord_id) desc) as dense_rank_orders,
    row_number() over (order by count(distinct Ord_id) desc) as row_number_orders
from market_fact_full m
inner join cust_dimen c
using (Cust_id)
group by c.Customer_Name;

-- 4. Create a ranking of the number of orders for each mode of shipment based on the months in which they were
-- shipped. 

with shipping_summary as (
	select
		Ship_Mode,
		month(Ship_Date) as Month,
		count(1) as Total_shipments
	from shipping_dimen
	group by Ship_Mode, month(Ship_Date)
)
select 
	*,
    rank() over(partition by Ship_Mode order by Total_shipments desc) as shipping_rank,
    dense_rank() over(partition by Ship_Mode order by Total_shipments desc) as shipping_dense_rank,
    row_number() over(partition by Ship_Mode order by Total_shipments desc) as shipping_row_number
from shipping_summary;

-- -----------------------------------------------------------------------------------------------------------------
-- Named Windows

-- 1. Rank the orders in the increasing order of the shipping costs for all orders placed by Aaron Smayling. Also
-- display the row number for each order.

select 
	m.Ord_id, 
    m.Shipping_Cost,
    rank() over w as shipping_rank,
    dense_rank() over w as shipping_dense_rank,
    row_number() over w as shipping_row_number
from market_fact_full m
inner join cust_dimen c
using (Cust_id)
where c.Customer_Name = "Aaron Smayling"
window w as (order by m.Shipping_Cost desc);

-- -----------------------------------------------------------------------------------------------------------------
-- Frames

-- 1. Calculate the month-wise moving average shipping costs of all orders shipped in the year 2011.
WITH shipping_details AS (
SELECT 
	MONTH(s.Ship_Date) as Months, 
    SUM(m.Shipping_Cost) as Daily_Cost
FROM market_fact_full m
INNER JOIN shipping_dimen s
USING (Ship_id)
where YEAR(s.Ship_Date) = 2011
GROUP BY Months
ORDER BY Months
)
SELECT
	*,
    SUM(Daily_Cost) OVER w1 AS running_total,
    AVG(Daily_Cost) OVER w2 AS running_avg
FROM shipping_details
WINDOW w1 as (ORDER BY Months ASC ROWS unbounded preceding),
	   w2 as (ORDER BY Months ASC ROWS 3 preceding);

-- -----------------------------------------------------------------------------------------------------------------
-- Session: Programming Constructs in Stored Functions and Procedures
-- IF Statements

-- 1. Classify an order as 'Profitable' or 'Not Profitable'.


-- -----------------------------------------------------------------------------------------------------------------
-- CASE Statements

-- 1. Classify each market fact in the following ways:
--    Profits less than -500: Huge loss
--    Profits between -500 and 0: Bearable loss 
--    Profits between 0 and 500: Decent profit
--    Profits greater than 500: Great profit

-- 2. Classify the customers on the following criteria (TODO)
--    Top 20% of customers: Gold
--    Next 35% of customers: Silver
--    Next 45% of customers: Bronze


-- -----------------------------------------------------------------------------------------------------------------
-- Stored Functions

-- 1. Create and use a stored function to classify each market fact in the following ways:
--    Profits less than -500: Huge loss
--    Profits between -500 and 0: Bearable loss 
--    Profits between 0 and 500: Decent profit
--    Profits greater than 500: Great profit


-- -----------------------------------------------------------------------------------------------------------------
-- Stored Procedures

-- 1. Classify each market fact in the following ways:
--    Profits less than -500: Huge loss
--    Profits between -500 and 0: Bearable loss 
--    Profits between 0 and 500: Decent profit
--    Profits greater than 500: Great profit

-- The market facts with ids '1234', '5678' and '90' belong to which categories of profits?


-- -----------------------------------------------------------------------------------------------------------------
-- Outer Join

-- 1. Return the order ids which are present in the market facts table


-- Execute the below queries before solving the next question.
create table manu(
    Manu_Id int primary key,
    Manu_name varchar(30),
    Manu_city varchar(30),
);

insert into manu values
(1,'Navneet','Ahemdabad'),
(2,'Wipro','Hyderabad'),
(3,'Furlanco','Mumbai');

alter table Prod_Dimen
add column Manu_Id int;

update Prod_dimen
set Manu_Id = 2
where Product_Category = 'technology';

-- 2. Display the products sold by all the manufacturers using both inner and outer joins


-- 3. Display the number of products sold by each manufacturer