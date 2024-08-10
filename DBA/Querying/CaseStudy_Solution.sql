use casestudy;	

select * from members limit 5;

select * from menu limit 5;

select * from sales limit 5;

-- 1. What is the total amount each customer spent at the restaurant? (join & grouby)

select s.customer_id, sum(m.price) as "Total Amount" 
from sales s
inner join  menu m 
on s.product_id = m.product_id
group by s.customer_id;

-- 2. How many days has each customer visited the restaurant?

select s.customer_id, count(distinct s.order_date)  as "Total Visits"
from sales s
group by s.customer_id;

-- 3. What is the most purchased item on the menu and -- how many times was it purchased by the customers?

select m.product_name, count(m.product_name) as total_orders
from sales s
inner join menu m
on s.product_id = m.product_id
group by m.product_name
order by total_orders desc
limit 1;

-- 4. What is the total items and amount spent 
-- for each member before they became a member?

select m.customer_id, count(s.product_id) as total_orders, sum(me.price) as total_price
from members m
inner join sales s on m.customer_id = s.customer_id
inner join menu me on me.product_id = s.product_id
where s.order_date < m.join_date
group by m.customer_id
order by  m.customer_id;

SELECT s.customer_id,
count(product_name) AS total_items,
CONCAT('$', SUM(price)) AS amount_spent
FROM menu AS m
INNER JOIN sales AS s ON m.product_id = s.product_id
INNER JOIN members AS mem ON mem.customer_id = s.customer_id
WHERE order_date < join_date
GROUP BY s.customer_id
ORDER BY customer_id;
