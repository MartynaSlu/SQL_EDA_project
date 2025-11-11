-- Explore all objects in the database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore all columns in the database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'

-- Explore all countries our customers come from
SELECT DISTINCT country FROM gold.dim_customers

-- Explore all categories "the major divisions"
SELECT DISTINCT category,subcategory,product_name FROM gold.dim_products
order by 1,2,3

-- find the date of the first and last order
-- how many years of sales are available

SELECT 
MIN(order_date) first_order_date,
MAX(order_date) last_order_date,
DATEDIFF(year,MIN(order_date),MAX(order_date)) AS order_range_years,
DATEDIFF(month,MIN(order_date),MAX(order_date)) AS order_range_months
from gold.fact_sales

-- find the youngest and the oldest customer

SELECT
MIN(birthdate) AS oldest_birthdate,
DATEDIFF(year,MIN(birthdate),GETDATE()) AS oldest_age,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(year,MAX(birthdate),GETDATE()) AS youngest_age
FROM
gold.dim_customers

-- find the total sales
SELECT SUM(sales_amount) as total_sales from gold.fact_sales
-- find how many items are sold
SELECT SUM(quantity) as total_quantity from gold.fact_sales

-- find the average selling price
SELECT AVG(price) as avg_price from gold.fact_sales
-- find the total number of orders
SELECT COUNT(order_number) as total_orders from gold.fact_sales
SELECT COUNT(DISTINCT order_number) as total_orders from gold.fact_sales
SELECT * from gold.fact_sales

-- find the total number of products
SELECT COUNT(product_key) AS total_products FROM gold.dim_products
SELECT COUNT(DISTINCT product_key) AS total_products FROM gold.dim_products

-- find the total number of customers
SELECT COUNT(customer_key) as total_customers FROM gold.dim_customers

-- find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) as total_customers FROM gold.fact_sales


-- Generate a report that shows all key metrics of the business
SELECT 'Total Sales' as measure_name, SUM(sales_amount) as measure_value from gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) from gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) from gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders', COUNT(DISTINCT order_number) from gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products', COUNT(product_name) from gold.dim_products
UNION ALL
SELECT 'Total Nr. Customers', COUNT(customer_key) from gold.dim_customers


