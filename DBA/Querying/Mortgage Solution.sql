use mortgage_details;

-- Total number of customers
SELECT COUNT(*) AS 'Total Customers'
FROM customer;

-- Number of customers by age
SELECT Age, COUNT(*) AS 'Customer Count by Age'
FROM customer
GROUP BY Age
ORDER BY Age;



-- Number of customers by gender
SELECT Gender, COUNT(*) AS 'Customer Count by Gender'
FROM customer
GROUP BY Gender;



-- Number of customers by occupation
SELECT Occupation, COUNT(*) AS 'Customer Count by Occupation'
FROM customer
GROUP BY Occupation;


-- Number of customers by salary
SELECT Salary, COUNT(*) AS 'Customer Count by Salary'
FROM customer
GROUP BY Salary;



-- Analysing Applied Loan Amounts
-- Applied loan amounts by age
SELECT Age, 
SUM(Applied_Loan_Amount_in_Lacs) AS 'Total Applied Loan Amount in Lacs'
FROM customer
GROUP BY Age
ORDER BY Age;

-- Applied loan amounts by gender
SELECT Gender, SUM(Applied_Loan_Amount_in_Lacs) AS 'Total Applied Loan Amount in Lacs'
FROM customer
GROUP BY Gender;


-- Applied loan amounts by occupation
SELECT Occupation, SUM(Applied_Loan_Amount_in_Lacs) AS 'Total Applied Loan Amount in Lacs'
FROM customer
GROUP BY Occupation;

-- Applied loan amounts by salary
SELECT Salary, SUM(Applied_Loan_Amount_in_Lacs) AS 'Total Applied Loan Amount in Lacs'
FROM customer
GROUP BY Salary
ORDER BY CAST(Salary as UNSIGNED), Salary;

-- ------------------------------------------------------------------

-- Analysing Sanctioned Loan Amounts : Use customer & saction_data
-- Sanctioned loan amounts by age
SELECT Age, SUM(Sanction_Amt_in_Lacs) AS 'Total Sanctioned Loan Amount in Lacs'
FROM customer c
INNER JOIN sanction_data s
ON c.Customer_Number = s.Customer_Number
GROUP BY Age
ORDER BY Age;




-- Sanctioned loan amounts by gender
SELECT Gender, SUM(Sanction_Amt_in_Lacs) AS 'Total Sanctioned Loan Amount in Lacs'
FROM customer c
INNER JOIN sanction_data s
ON c.Customer_Number = s.Customer_Number
GROUP BY Gender;




-- Sanctioned loan amounts by occupation
SELECT Occupation, SUM(Sanction_Amt_in_Lacs) AS 'Total Sanctioned Loan Amount in Lacs'
FROM customer c
INNER JOIN sanction_data s
ON c.Customer_Number = s.Customer_Number
GROUP BY Occupation;



-- Sanctioned loan amounts by salary
SELECT Salary, SUM(Sanction_Amt_in_Lacs) AS 'Total Sanctioned Loan Amount in Lacs'
FROM customer c
INNER JOIN sanction_data s
ON c.Customer_Number = s.Customer_Number
GROUP BY Salary



-- TASK : Analysing Customers of 26-32 Age Group

-- Customers by channel
SELECT Channels, COUNT(*) AS 'Customer Count'
FROM customer cu
INNER JOIN channel ch
ON cu.Channel_Id = ch.Channel_Id
WHERE Age = '26-32'
GROUP BY Channels;




-- Customers by product
SELECT Products, COUNT(*) AS 'Customer Count'
FROM customer c
INNER JOIN product p
ON c.Product_Id = p.Product_Id
WHERE Age = '26-32'
GROUP BY Products;




