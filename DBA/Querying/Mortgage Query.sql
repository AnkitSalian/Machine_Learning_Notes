use mortgage_details; 

-- Number of customers by age  => 26-32 are most people

select Age, count(Age) as total_people from customer
group by Age
order by total_people desc;

-- Number of customers by gender 

select Gender, count(Gender) as total 
from customer
group by Gender
order by Total desc;

-- Number of customers by occupation 

select Occupation, count(Occupation) as total from customer
group by Occupation
order by total desc;

-- Number of customers by salary
select Salary, count(Salary) as total from customer
group by Salary
order by total desc;

-- Applied loan amounts by age 

select c.Age, sum(c.Applied_Loan_Amount_in_Lacs) as total_loan_applied from customer c
group by c.Age
order by total_loan_applied desc;

-- Applied loan amounts by gender 

select c.Gender, sum(c.Applied_Loan_Amount_in_Lacs) as total_loan_applied from customer c
group by c.Gender
order by total_loan_applied desc;

-- Applied loan amounts by occupation 

select c.Occupation, sum(c.Applied_Loan_Amount_in_Lacs) as total_loan_applied from customer c
group by c.Occupation
order by total_loan_applied desc;

-- Applied loan amounts by salary

select c.Salary, sum(c.Applied_Loan_Amount_in_Lacs) as total_loan_applied from customer c
group by c.Salary
order by total_loan_applied desc;

-- Sanctioned loan amounts by age 

select c.Age, sum(s.Sanction_Amt_in_Lacs) as sanctioned_amount from sanction_data s 
inner join customer c
on s.Customer_Number = c.Customer_Number
group by c.Age
order by sanctioned_amount desc;

-- Sanctioned loan amounts by gender 

select c.Gender, sum(s.Sanction_Amt_in_Lacs) as sanctioned_amount from sanction_data s 
inner join customer c
on s.Customer_Number = c.Customer_Number
group by c.Gender
order by sanctioned_amount desc;

-- Sanctioned loan amounts by occupation 

select c.Occupation, sum(s.Sanction_Amt_in_Lacs) as sanctioned_amount from sanction_data s 
inner join customer c
on s.Customer_Number = c.Customer_Number
group by c.Occupation
order by sanctioned_amount desc;

-- Sanctioned loan amounts by salary

select c.Salary, sum(s.Sanction_Amt_in_Lacs) as sanctioned_amount from sanction_data s 
inner join customer c
on s.Customer_Number = c.Customer_Number
group by c.Salary
order by sanctioned_amount desc;

-- TASK : Analysing Customers of 26-32 Age Group 
-- Customers by channel 

select cha.Channels, count(cust.Customer_Number) as total_customer from customer cust
inner join channel cha
on cha.Channel_Id = cust.Channel_Id
where cust.Age = "26-32"
group by cha.Channels
order by total_customer desc;

-- Customers by product
select p.Products, count(cust.Customer_Number) as total_customer from customer cust
inner join product p
on p.Product_Id = cust.Product_Id
where cust.Age = "26-32"
group by p.Products
order by total_customer desc;