```sql
CREATE DATABASE IF NOT EXISTS WalmartSales;
```
CREATE TABLE IF NOT EXISTS sales(
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- Import data to the created table 
SELECT * FROM sales;

-- ----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------- Feature Engineering ----------------------------------------------------

-- Add time_of_day column

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
SET sql_safe_updates = 0;
UPDATE sales
SET time_of_day = CASE
					WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
                    WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
                    ELSE "Evening"
				 END;
	
-- Add day_name column

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales
SET day_name = dayname(date);

-- Add month_name column

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name = monthname(date);

-- ----------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------ Generic -------------------------------------------------------

-- How many unique cities does the data have?

SELECT 
	COUNT(DISTINCT city) AS cnt
FROM sales;
-- There are 3 unique cities

-- In which city is each branch?

SELECT 
	DISTINCT city,
    branch
FROM sales;

-- ----------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------ Product -------------------------------------------------------

-- Q1. How many unique product lines does the data have?

SELECT 
	COUNT(DISTINCT product_line) AS cnt_pdtline 
FROM sales;
-- There are 6 unique product lines

-- Q2. What is the most common payment method?

SELECT 
	payment_method,
    COUNT(payment_method) AS cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt DESC
LIMIT 1;
-- Cash is the most common payment method

-- Q3. What is the most selling product line

SELECT 
	product_line,
    COUNT(product_line) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt DESC
LIMIT 1;
--  Fashion accessories is the most selling product line

-- Q4. What is the total revenue by month

SELECT 
    month_name AS Month,
    SUM(total) AS Total_Revenue
FROM sales
GROUP BY month_name, MONTH(date)
ORDER BY MONTH(date);

-- Q5. Which month had the largest COGS?

SELECT 
    month_name AS Month,
    SUM(cogs) AS Total_COGS
FROM sales
GROUP BY Month
ORDER BY Total_COGS DESC
LIMIT 1;
-- January had the largest COGS

-- Q6. What product line had the largest revenue?

SELECT 
    product_line,
    SUM(total) AS Total_Revenue
FROM sales
GROUP BY product_line
ORDER BY Total_Revenue DESC
LIMIT 1;
-- Food and beverages had the largest revenue

-- Q7. What is the city with the largest revenue?

SELECT 
    city,
    SUM(total) AS Total_Revenue
FROM sales
GROUP BY city
ORDER BY Total_Revenue DESC
LIMIT 1;
-- Naypyitaw is the city with the largest revenue

-- Q8. What product line had the largest VAT?

SELECT 
    product_line,
    MAX(vat) AS Max_VAT
FROM sales
GROUP BY product_line
ORDER BY Max_VAT DESC
LIMIT 1;
-- Fashion accessories had the largest VAT

-- Q9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

SELECT 
    product_line,
    AVG(total) AS Avg_sales,
    CASE 
        WHEN AVG(total) > (SELECT AVG(total) FROM sales) THEN 'Good'
        ELSE 'Bad'
    END AS Remarks
FROM sales
GROUP BY product_line;

-- 	Q10. Which branch sold more products than average product sold?

SELECT 
    branch, 
    AVG(quantity) AS Avg_qntysold
FROM sales
GROUP BY branch
HAVING Avg_qntysold > (SELECT AVG(quantity) FROM sales);
-- c branch sold more products than average product sold

-- Q11. What is the most common product line by gender?

WITH cte AS (
SELECT 
    gender,
    product_line,
    COUNT(product_line) AS cnt,
    RANK() OVER (PARTITION BY gender ORDER BY COUNT(product_line) DESC) AS rnk
FROM sales
GROUP BY gender, product_line)
SELECT gender,product_line,cnt
FROM cte
WHERE rnk =1;
-- Fashion accessories is the most common product line by female
-- Health and beauty is the most common product line by male

-- Q12. What is the average rating of each product line

SELECT 
    product_line,
    ROUND(AVG(rating),2) AS Avg_rating
FROM sales
GROUP BY product_line
ORDER BY Avg_rating DESC;

-- ----------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------ Sales ---------------------------------------------------------

-- Q1. Number of sales made in each time of the day per weekday

SELECT 
    day_name,
    time_of_day,
    COUNT(invoice_id) AS Sales_cnt
FROM sales
GROUP BY day_name,time_of_day
ORDER BY day_name,time_of_day;

-- Q2. Which of the customer types brings the most revenue?

SELECT 
    customer_type,
    SUM(total) AS Total_Revenue
FROM sales
GROUP BY customer_type
ORDER BY Total_Revenue DESC
LIMIT 1;
-- Member customer type brings the most revenue

-- Q3. Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT 
    city,
    MAX(vat) AS Max_vat
FROM sales
GROUP BY city
ORDER BY Max_vat DESC
LIMIT 1;
-- Naypyitaw has the largest VAT

-- Q4. Which customer type pays the most in VAT?

SELECT 
    customer_type,
    SUM(vat) AS Total_Vat
FROM sales
GROUP BY customer_type
ORDER BY Total_vat DESC
LIMIT 1;
-- Member customer type pays the most in VAT

-- --------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------ Customers ---------------------------------------------------------

-- Q1. How many unique customer types does the data have?

SELECT 
	COUNT(DISTINCT customer_type) AS cnt
FROM sales;
-- There are 2 unique customer types

-- Q2. How many unique payment methods does the data have?

SELECT 
	COUNT(DISTINCT payment_method) AS cnt
FROM sales;
-- There are 3 unique payment methods

-- Q3. What is the most common customer type?

SELECT
     customer_type, 
     COUNT(customer_type) AS cnt
FROM sales
GROUP BY customer_type
ORDER BY cnt DESC
LIMIT 1;
-- Member is the most common customer type

-- Q4. What is the gender of most of the customers?

SELECT 
	gender,
	COUNT(gender) AS cnt
FROM sales
GROUP BY gender
ORDER BY cnt DESC
LIMIT 1;
-- Most of the customers are male.

-- Q5. What is the gender distribution per branch?

SELECT 
	branch,
	gender,
	COUNT(gender) AS cnt
FROM sales
GROUP BY branch,gender
ORDER BY branch,gender;

-- Q6. Which time of the day do customers give most ratings?

SELECT
	time_of_day,
	COUNT(rating) AS rating_count
FROM sales
GROUP BY time_of_day
ORDER BY rating_count DESC
LIMIT 1;
-- Customers give most rating on evening time

-- Q7. Which time of the day do customers give most ratings per branch?

WITH cte AS (
    SELECT
        branch,
        time_of_day,
        COUNT(rating) AS rating_count,
        ROW_NUMBER() OVER (PARTITION BY branch ORDER BY COUNT(rating) DESC) AS rnk
    FROM sales
    GROUP BY branch, time_of_day
)
SELECT
    branch,
    time_of_day,
    rating_count
FROM cte
WHERE rnk = 1;
-- All the branches get maximum ratings on evening time

-- Q8. Which day of the week has the best avg ratings?

SELECT
	day_name,
	AVG(rating) AS Avg_rating
FROM sales
GROUP BY day_name
ORDER BY Avg_rating DESC
LIMIT 1;
-- Monday has the best average rating

-- Q9. Which day of the week has the best average ratings per branch?

WITH cte AS (
    SELECT
        branch,
        day_name,
        AVG(rating) AS Avg_rating,
        ROW_NUMBER() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rnk
    FROM sales
    GROUP BY branch, day_name
)
SELECT
    branch,
    day_name,
    Avg_rating
FROM cte
WHERE rnk = 1;
-- A got best ratings on friday,
-- B got best ratings on monday,
-- c got best ratings on saturday,




