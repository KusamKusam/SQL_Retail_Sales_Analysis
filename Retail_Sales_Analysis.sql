CREATE DATABASE PROJECT_ONE;
USE PROJECT_ONE;

-- CREATE RETAIL SALES TABLE
CREATE TABLE retail_sales(
	transactions_id INT,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(15),
	quantity INT,
    price_per_unit FLOAT,
	cogs FLOAT,	
    total_sale FLOAT
    );
    
    ALTER TABLE retail_sales
    ADD PRIMARY KEY (transactions_id);
    
SELECT * FROM retail_sales LIMIT 5;
SELECT COUNT(*)
FROM retail_sales;

DESCRIBE retail_sales;

SELECT * FROM retail_sales
LIMIT 10;

SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
	OR sale_date IS NULL
	OR sale_time IS NULL
	OR customer_id IS NULL
	OR gender IS NULL
	OR age IS NULL
	OR category IS NULL
	OR quantity IS NULL
	OR price_per_unit IS NULL
	OR cogs IS NULL	
	OR total_sale IS NULL;

SELECT COUNT(*) AS null_rows
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
   
-- DATA EXPLOARATION

-- HOW MANY SALES AS WE HAVE?
SELECT COUNT(*) AS total_sales FROM retail_sales;

-- HOW MANY DISTINCT CUSTOMERS WE HAVE?
SELECT COUNT( DISTINCT customer_id) AS total_customers FROM retail_sales;

--  CATEGORY WE HAVE?
SELECT DISTINCT category  FROM retail_sales;

-- RETRIEVE ALL THE COLUMNS FOR SALES MADE ON '2022-11-05'
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-06-14';

-- RETRIEVE ALL THE TRANSACTIONS WHERE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 10 IN THE MONTH OF NOV-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity >= 4
AND MONTH(sale_date) = '11'
AND YEAR(sale_date) = '2022';

-- CALCULATE TOTAL SALES FOR EACH CATEGORY
SELECT category, SUM(total_sale) AS totalSalesByCategory
FROM retail_sales
GROUP BY category
ORDER BY totalSalesByCategory DESC;

-- FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY
SELECT category, ROUND(AVG(age), 0) AS average_age
FROM retail_sales
WHERE category = 'Beauty';

-- FIND ALL THE TRANSACTIONS WHERE TOTAL SALE IS MORE THAN 1000.
SELECT * 
FROM retail_sales
WHERE total_sale > 1000;

-- FIND THE TOTAL NUMBER OF TRANSACTIONS (TRANSACTION_ID) MADE BY EACH GENDER IN EACH CATEGORY
SELECT category, gender, COUNT(transactions_id) AS transaction_count
FROM retail_sales
GROUP BY category, gender
ORDER BY 1;

-- CALCULATE THE AVERAGE SALES OF EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR
SELECT * 
FROM (
	SELECT YEAR(sale_date) AS year, 
	MONTHNAME(sale_date) AS month_name, 
	ROUND(AVG(total_sale), 2) AS average_sale,
	RANK() OVER(
		PARTITION BY YEAR(sale_date)
		ORDER BY ROUND(AVG(total_sale), 2) DESC
	  ) AS monthly_sales_rank
      FROM retail_sales
	  GROUP BY YEAR(sale_date), MONTHNAME(sale_date)
) AS best_sale_months
WHERE monthly_sales_rank = 1;

-- FIND THE TOP FIVE CUSTOMERS BASED ON THE HIGHEST TOTAL_SALES
SELECT customer_id, SUM(total_sale) AS total_sale_amount
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale_amount DESC
LIMIT 5;

-- FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY

SELECT category, COUNT(DISTINCT customer_id) AS total_unique_customers
FROM retail_sales
GROUP BY category
ORDER BY total_unique_customers DESC;

-- CREATE EACH SHIFT AND NUMBER OF ORDERS(EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 & 17, EVENING > 17)
SELECT *,










   

