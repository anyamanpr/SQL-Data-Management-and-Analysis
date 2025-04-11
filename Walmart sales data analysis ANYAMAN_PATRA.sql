-- FEATURE ENGINEERING-------------------------------------------------------------
-- --------------------------------------------------------------------------------

-- 1. time_of_day---(helps answer question on which part of the day most sales are made)

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (CASE
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN 'Morning'
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN 'Afternoon'
        ELSE 'Evening'
	END);


-- 2.day_name---(helps answer question on which day of the week each branch is busiest)

ALTER TABLE sales ADD COLUMN day_name VARCHAR(20);

UPDATE sales
SET day_name = DAYNAME(date);


-- 3.month_name---(helps determine which month of the year has the most sales and profit)

ALTER TABLE sales ADD COLUMN month_name VARCHAR(20);

UPDATE sales
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------
-- PROJECT DONE BY ANYAMAN PATRA


-- GENERIC QUESTIONS---------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------

-- 1. How many distict cities does the data have?

SELECT DISTINCT(city) FROM sales;

-- 2. In which city is each branch?

SELECT DISTINCT(branch), city FROM sales;
-- OR--
SELECT DISTINCT(city), branch FROM sales;

-- ---------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------


-- PRODUCT EXPLORATORY ANALYSIS--------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------

-- 1.How many product lines do we have? What are they?

SELECT COUNT(DISTINCT(product_line)) AS Unique_product_lines FROM sales;

SELECT DISTINCT(product_line) AS Unique_product_lines FROM sales;


-- 2.What is the most common payment method ?

SELECT COUNT(payment_method) AS total, payment_method 
FROM sales
GROUP BY payment_method
ORDER BY COUNT(payment_method) DESC;

-- PROJECT DONE BY ANYAMAN PATRA

-- 3.What is the most selling product line?

SELECT COUNT(product_line) AS total, product_line
FROM sales
GROUP BY product_line
ORDER BY COUNT(product_line) DESC;

-- 4.What is the total revenue by month?

SELECT ROUND(SUM(total),2) AS Total_Revenue, month_name
FROM sales
GROUP BY month_name
ORDER BY SUM(total) DESC;

-- 5.What month has the largest COGS?

SELECT ROUND(SUM(cogs),2) AS total_cogs, month_name
FROM sales
GROUP BY month_name
ORDER BY SUM(cogs) DESC;

-- 6.What product line had the largest revenue?

SELECT ROUND(SUM(total),2) AS Total_Revenue, product_line
FROM sales
GROUP BY product_line
ORDER BY SUM(total) DESC;

-- 7.What is the city with the largest revenue?

SELECT ROUND(SUM(total),2) AS Total_Revenue, city, branch
FROM sales
GROUP BY city, branch
ORDER BY SUM(total) DESC;

-- 8.What product line has the largest VAT?

SELECT ROUND(AVG(VAT),2) AS total_VAT, product_line
FROM sales
GROUP BY product_line
ORDER BY AVG(VAT) DESC;

-- PROJECT DONE BY ANYAMAN PATRA

-- 9.Which branch sold more products than average products sold ?

SELECT branch, SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- 10.Which gender has bought the most products?

SELECT gender, COUNT(product_line) as total_cnt
FROM sales
GROUP BY gender
ORDER BY total_cnt DESC;

-- 11. What is the most common product line by gender?

SELECT gender, product_line, COUNT(product_line) as total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- 12. What is the average rating of each product line ?

SELECT product_line, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY AVG(rating) DESC;

-- --------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------

-- SALES EXPLORATORY ANALYSIS------------------------------------------------------------------------------------
-- --------------------------------------------------------------------PROJECT DONE BY ANYAMAN PATRA-------------


-- 1.What is the number of sales made in each time of the day per weekday?

SELECT time_of_day, day_name, COUNT(invoice_id) AS Total_sales
FROM sales
WHERE day_name IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
GROUP BY time_of_day, day_name
ORDER BY day_name ASC;

-- 2.Which type of customer types brings the most revenue?

SELECT customer_type, ROUND(SUM(total),2) AS Total_Revenue
FROM sales
GROUP BY customer_type
ORDER BY Total_Revenue DESC;

-- 3.Which city has the largest tax percent/VAT?

SELECT city, ROUND(AVG(VAT),2) AS Tax_percent
FROM sales
GROUP BY city
ORDER BY Tax_percent DESC;

-- 4.Which customer type pays the most in VAT?

SELECT customer_type, ROUND(AVG(VAT),2) AS VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT DESC;

-- --------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------


-- CUSTOMERS EXPLORATORY ANALYSIS--------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------

-- 1.How many unique customer types does the data have?

SELECT DISTINCT(customer_type)
FROM sales;

-- 2.How many unqiue payment methods does the data have?

SELECT DISTINCT(payment_method)
FROM sales;

-- 3.What is the most common customer type?

SELECT customer_type, COUNT(*) AS cstm_cnt
FROM sales
GROUP BY customer_type
ORDER BY cstm_cnt DESC;

-- 4.What is the gender distribution per branch?

SELECT branch, gender, COUNT(gender) AS Total
FROM sales
GROUP BY branch, gender
ORDER BY branch ASC;
-- -----------------------------------------------PROJECT DONE BY ANYAMAN PATRA------------------------------------
-- 5.Which time of the day do customers give most ratings?

SELECT time_of_day, ROUND(AVG(rating),2) AS Total_ratings
FROM sales
GROUP BY time_of_day
ORDER BY Total_ratings DESC;

-- 6.Which time of the day do customers give most ratings per branch?

SELECT branch, time_of_day, ROUND(AVG(rating),2) AS Total_avg_ratings
FROM sales
GROUP BY time_of_day, branch
ORDER BY Total_avg_ratings DESC;

-- 7.Which day of the week has the best average rating per branch?

SELECT branch, day_name, ROUND(AVG(rating),2) AS Total_avg_ratings
FROM sales
GROUP BY day_name, branch
ORDER BY Total_avg_ratings DESC;

-- -------------------------------------------------------------------------------------------------------------------
-- -------------------------------END OF PROJECT----------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------