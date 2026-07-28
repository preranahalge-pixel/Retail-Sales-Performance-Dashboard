CREATE TABLE retail_sales(
	row_id INT,
	order_id VARCHAR(50),
	order_date TEXT,
	ship_date	TEXT,
	ship_mode VARCHAR(50),
	customer_id VARCHAR(50),
	customer_name VARCHAR(50),	
	segment	VARCHAR(20),
	country	VARCHAR(50),
	city	VARCHAR(50),
	state_name	VARCHAR(50),
	postal_code	INT,
	region	VARCHAR(50),
	product_id	VARCHAR(50),
	category VARCHAR(50),	
	sub_category	VARCHAR(50),
	product_name	VARCHAR(255),
	sales	NUMERIC
);

COPY 
retail_sales(row_id, order_id, order_date, ship_date, ship_mode, customer_id, customer_name, segment, country, city, state_name, postal_code,region, product_id, category, sub_category, product_name, sales)
FROM 'C:\MyFolder\train.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM retail_sales;
DROP TABLE IF EXISTS retail_sales;

-- Sales Overview Dashboard
-- Total sales 

SELECT SUM(sales) AS total_sales
FROM retail_sales;

-- Total Orders

SELECT count(* ) AS total_orders
FROM retail_sales;

-- Total Customers

SELECT COUNT(DISTINCT customer_name) AS Total_Customers
FROM retail_sales;

-- Sales by Region 

SELECT region,
SUM(sales) AS sales_by_region
FROM retail_sales
GROUP BY region
ORDER BY sales_by_region DESC;

-- Sales by Year and Category

SELECT
EXTRACT(YEAR FROM TO_DATE(order_date, 'DD/MM/YYYY')) AS year,
category,
SUM(sales) AS total_sales
FROM retail_sales
GROUP BY year, category
ORDER BY year, total_sales DESC;

-- Sales by Day

SELECT 
EXTRACT(DAY FROM TO_DATE(order_date, 'DD/MM/YYYY')) AS day,
SUM(sales) AS sales_day
FROM retail_sales
GROUP BY DAY
ORDER BY DAY;

-- Top 5 Sales by city

SELECT
city,
SUM(sales) AS top_sales_by_city
FROM retail_sales
GROUP BY city
ORDER BY top_sales_by_city DESC
LIMIT 5;

-- Sales by State

SELECT
state_name,
SUM(sales) AS sales_by_state
FROM retail_sales
GROUP BY state_name
ORDER BY sales_by_state DESC;

-- Product & Category Analysis Dashboard
-- Sales by Category

SELECT
category,
SUM(sales) AS sales_by_category
FROM retail_sales
GROUP BY category
ORDER BY sales_by_category DESC;

-- Sales by Sub-Category

SELECT
sub_category,
SUM(sales) AS sales_by_subcategory
FROM retail_sales
GROUP BY sub_category
ORDER BY sales_by_subcategory DESC;

-- Sales by Category and region 

SELECT
category, region,
SUM(sales) AS sales_by_category
FROM retail_sales
GROUP BY category,region
ORDER BY sales_by_category;

-- Top 10 Sales by product

SELECT
product_name,
SUM(sales) AS top_sales_by_product
FROM retail_sales
GROUP BY product_name
ORDER BY top_sales_by_product DESC
LIMIT 10;

-- Sales by Category and sub_category

SELECT
category, sub_category,
SUM(sales) AS sales_by_category
FROM retail_sales
GROUP BY category, sub_category
ORDER BY sales_by_category DESC;

-- Total Products

SELECT count(*) AS total_products
FROM retail_sales;

-- Customer & Segment Analysis Dashboard
-- Sales by Segment

SELECT
segment,
SUM(sales) AS sales_by_segment
FROM retail_sales
GROUP BY segment
ORDER BY sales_by_segment DESC;

-- Sales by Category and Segment

SELECT
category, segment,
SUM(sales) AS sales_by_category_and_segment
FROM retail_sales
GROUP BY category, segment 
ORDER BY sales_by_category_and_segment DESC;

-- Order by Segment

SELECT
segment,
SUM(sales) AS sales_by_segment
FROM retail_sales
GROUP BY segment
ORDER BY sales_by_segment DESC;

-- Table 
SELECT
customer_name, segment, sales, product_name,
SUM(sales) AS total_sales
FROM retail_sales
GROUP BY customer_name, segment, sales, product_name
Order by product_name DESC ;