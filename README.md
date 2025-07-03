# Case Study 2: Kultra Mega Stores (KMS) SQL Analysis

##  Project Overview
This case study explores customer, sales, and order data for Kultra Mega Stores (KMS). Using SQL Server, I analyzed the dataset to uncover insights about product performance, customer behavior, shipping costs, and returns. My goal was to answer targeted business questions and make recommendations to improve profitability and operations.
This project is part of my learning journey as a beginner in SQL and data analytics. I used it as a hands-on opportunity to build real-world problem-solving skills, document my findings on GitHub, and contribute to my analytics portfolio.

## Tools Used
- SQL Server (for querying and analysis)
- GitHub (for documentation)
- Excel (used in inspection stage)
- ChatGPT (for query structuring and insight generation support)

## Data Source
- Dataset provided as part of the Kultra Mega Stores (KMS) Case Study challenge from the Data Analysis Learning Community
- Format: CSV file shared via community resources

## Setup
- Database created: Kultra Mega Stores
- Primary Tables: kms sql case study, order_status
- Data Cleaning:
  - Converted numeric fields like sales, profit, and discount to DECIMAL(10,2) for precision.

  ```
  ALTER TABLE [kms sql case study]
  ALTER COLUMN sales DECIMAL(10,2)
  --- repeated for: discount, profit, unit_price, shipping_cost, product_base_margin
  ```

## Business Questions & Answers
### Scenario 1: Sales, Revenue, and Shipping
- Q1: What is the total sales per product category?
```
SELECT product_category, SUM(DISTINCT sales) AS Highest_Sales
FROM [kms sql case study]
GROUP BY product_category
ORDER BY Highest_Sales DESC
```
Insight: Technology had the highest sales among all product categories.


- Q2: Top and bottom 3 sales by region
```
-- Top 3
SELECT TOP 3 region, sales
FROM [kms sql case study]
ORDER BY sales DESC

-- Bottom 3
SELECT TOP 3 region, sales
FROM [kms sql case study]
ORDER BY sales ASC
```
Insight: The top 3 regions shows highest sales, indicating strong performance in those areas. Meanwhile, the bottom 3 regions indicate underperformance and may require further investigation or targeted sales strategies.


- Q3: Total sales of appliances in Ontario
```
SELECT SUM(sales) AS Ontario_Sales
FROM [kms sql case study]
WHERE region = 'ontario' AND product_sub_category = 'appliances'
```
Insight: Ontario appliance sales can be tracked specifically for growth.


- Q4: Top 10 customers by revenue, discount, region, and product category (Two Queries)

  Query 1: Top 10 customers based on total revenue
  ```
  SELECT TOP 10 customer_name, product_category, region,
       SUM(DISTINCT sales) AS total_revenue,
       SUM(DISTINCT discount) AS total_discount
  FROM [kms sql case study]
  GROUP BY customer_name, product_category, region
  ORDER BY total_revenue DESC
  ```

  Query 2: Top 10 customers by total discount given
  ```
  SELECT TOP 10 customer_name, region,
  SUM(DISTINCT discount) AS total_discount
  FROM [kms sql case study]
  GROUP BY customer_name, region
  ORDER BY total_discount DESC
  ```
Observation: Top customers often fall under the Technology category and also receive high discounts.


- Q5: Shipping cost by shipping mode
```
SELECT ship_mode, SUM(DISTINCT shipping_cost) AS Most_shipping_cost
FROM [kms sql case study]
GROUP BY ship_mode
ORDER BY Most_shipping_cost DESC
```
Insight: Shipping mode affects cost significantly - faster or premium delivery options tends to cost more. Only 3 distinct modes were used.

#### Scenario 2: Customer Segmentation and Profitability

- Q6: Who are the top 10 customers and what do they typically purchase?
  ```
  WITH TopCustomers AS (
  SELECT TOP 10 k.customer_name
  FROM [kms sql case study] k
  GROUP BY k.customer_name
  ORDER BY SUM(sales) DESC
  )
  SELECT k.customer_name, k.product_category, SUM(k.sales) AS Total_Sales
  FROM [kms sql case study] k
  JOIN TopCustomers t ON k.customer_name = t.customer_name
  GROUP BY k.customer_name, k.product_category
  ORDER BY k.customer_name, Total_Sales
  ```
 Observation: Some customers appear multiple times because they purchase from different product categories. Total rows = 26.


 - Q7: Top customer in the Small Business segment
```
SELECT TOP 1 customer_name, SUM(sales) AS Top_Small_Business_Customer
FROM [kms sql case study]
WHERE Customer_Segment = 'Small Business'
GROUP BY customer_name
ORDER BY Top_Small_Business_Customer DESC
```
Insight: The top-performing small business customer stands out Dennis Kane recorded total sales of 75,967.59. 


- Q8: Corporate customer with the most orders (2009–2012)
```
SELECT TOP 1 customer_name, COUNT(k.order_id) AS order_count
FROM [kms sql case study] k
JOIN order_status o ON k.order_id = o.order_id
WHERE Customer_Segment = 'corporate' AND YEAR(Order_Date) BETWEEN 2009 AND 2012
GROUP BY customer_name
ORDER BY order_count DESC
```
Insight: Erin Creighton made 10 orders.


- Q9: Most profitable consumer customer
```
SELECT TOP 1 customer_name, SUM(profit) AS total_profit
FROM [kms sql case study]
WHERE Customer_Segment = 'consumer'
GROUP BY customer_name
ORDER BY total_profit DESC
```
Insight: Emily Phan recorded a profit of 34,005.44.


- Q10: Customers who returned items (negative profit) and their segment
```
SELECT DISTINCT customer_name, customer_segment
FROM [kms sql case study] k
JOIN order_status o ON k.order_id = o.Order_ID
WHERE k.profit < 0
```
Insight: Returns mostly came from Consumer and Home Office segments.


- Q11: Shipping cost vs Order Priority
```
SELECT order_priority, ship_mode,
       AVG(shipping_cost) AS avg_shipping_cost,
       COUNT(order_id) AS total_orders
FROM [kms sql case study] k
GROUP BY order_priority, ship_mode
```
Insight: Higher order priority aligns with higher shipping costs.















    
