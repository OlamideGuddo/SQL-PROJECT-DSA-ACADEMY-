create database [Kultra Mega Stores]

select * from order_status
select * from [kms sql case study]


---- I intentionally did not pick from order status table because, some questions 

alter table [kms sql case study]
alter column sales decimal (10,2)

alter table [kms sql case study]
alter column discount decimal (10,2)

alter table [kms sql case study]
alter column profit decimal (10,2)

alter table [kms sql case study]
alter column unit_price decimal (10,2)

alter table [kms sql case study]
alter column shipping_cost decimal (10,2)

alter table [kms sql case study]
alter column product_base_margin decimal (10,2)

---- CASE SCENARIO 1 
---- QUES 1
select product_category, sum(distinct sales) as Highest_Sales
from [kms sql case study]
group by product_category
order by Highest_Sales desc

---- QUES 2
--- Top 3 sales by region
select top 3 region, sales 
from [kms sql case study] 
order by sales desc

---- Bottom 3 sales by region
select top 3 region, sales
from [kms sql case study]
order by sales asc

---QUES 3
select sum(sales) as Ontario_Sales
from [kms sql case study]
where region = 'ontario' and product_sub_category = 'appliances'

---- QUES 4
select top 10 customer_name,product_category,region,  sum(distinct sales) as total_revenue, 
   											   sum(distinct discount) as total_discount
from [kms sql case study]
group by customer_name, product_category,region
order by total_revenue asc

----- Total revenue by product category
select product_category,  sum(distinct sales) as total_revenue,                                                      
   						  sum(distinct discount) as total_discount,
						  count(distinct customer_name) as customer_count
from [kms sql case study]
group by  product_category
order by total_revenue desc 

 ---- I counted the number of product category we have
select count (distinct product_category) as total_product_category
from [kms sql case study]




select * from [kms sql case study]




---- QUES 5
---- I first counted the total number of shipping modes we have and the total number is = 3 
select count(distinct ship_mode) as Total_Ship_Mode
from [kms sql case study]
--- 
select ship_mode, sum(distinct shipping_cost) as Most_shipping_cost
from [kms sql case study]
group by ship_mode 
order by Most_shipping_cost desc

--- SCENARIO 2
---	QUES 6

with TopCustomers as (
 select top 10 k.customer_name 
 from  [kms sql case study] k
 group by k.customer_name 
 order by sum(sales) 
 desc )
 select k.customer_name, k.product_category, sum (k.sales) as Total_Sales
 from [kms sql case study] k
 join TopCustomers t on k.customer_name = t.customer_name
 group by k.customer_name, k.product_category
 order by k.customer_name, Total_Sales 

--- QUES 7
select top 1 customer_name, sum(sales) as Top_Small_Business_Customer
                            from [kms sql case study]
							where Customer_Segment = 'Small Business'
							group by Customer_Name
							order by Top_Small_Business_Customer desc

---- QUES 8
select top 1 customer_name, count(k.order_id) as order_count 
from [kms sql case study] k
 join Order_Status o on k.order_id  = o.order_id
where Customer_Segment = 'corporate' and year(Order_Date) between 2009 and 2012
group by customer_name 
order by order_count desc

---- QUES 9
select top 1 customer_name, sum(profit) as total_profit
from [kms sql case study]
where Customer_Segment = 'consumer'
group by customer_name 
order by total_profit desc

----- QUES 10 
select distinct customer_name, customer_segment 
from [kms sql case study] k
join Order_Status o on k.order_id = o.Order_ID
where k.profit <0
                 
---- QUES 11
select order_priority, ship_mode, avg(shipping_cost) as avg_shipping_cost,
                                  count(order_id) as total_orders 
								  from [kms sql case study] k
								  group by order_priority, ship_mode




 
