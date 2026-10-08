create database sql_project_p1;
use sql_project_p1;

create table retail_sales
             (
			    transactions_id INT primary key,
                sale_date DATE,	
                sale_time TIME,
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),
                quantiy  INT,
                price_per_unit  FLOAT,
                cogs   FLOAT,	
                total_sale  FLOAT
	         );


SELECT * FROM retail_sales;

SELECT COUNT(*) FROM retail_sales;

SELECT * 
FROM retail_sales
LIMIT 10;


SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time  IS NULL;

SELECT * FROM retail_sales
WHERE  customer_id IS NULL;

SELECT * FROM retail_sales
WHERE  customer_id IS NULL;

SELECT * FROM retail_sales
WHERE  customer_id IS NULL;


SELECT * FROM retail_sales
WHERE  customer_id IS NULL;

SELECT * FROM retail_sales
WHERE  gender IS NULL;

SELECT * FROM retail_sales
WHERE  age IS NULL;

SELECT * FROM retail_sales
WHERE  category IS NULL;

SELECT * FROM retail_sales
WHERE quantiy  IS NULL;

SELECT * FROM retail_sales
WHERE  price_per_unit IS NULL;

SELECT * FROM retail_sales
WHERE  cogs IS NULL;

SELECT * FROM retail_sales
WHERE total_sale IS NULL;

# data cleaning
SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

SELECT * FROM retail_sales;

# data exploration
# How many saler we have?

SELECT COUNT(*) as total_sale FROM retail_sales;

# how many customer we have?

SELECT COUNT(customer_id) as total_sale FROM retail_sales;

# how many unique customer we have?

SELECT COUNT(distinct customer_id) as total_sale FROM retail_sales;

SELECT distinct category FROM retail_sales;

# data analysis & Business key problems & answers

#My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT
	category,
    sum(quantiy)
FROM retail_sales
WHERE category = 'clothing'
group by 1;

SELECT * FROM retail_sales
WHERE category = 'clothing' AND  date_format( sale_date,'yyyy-mm') = '2022-11'  and quantiy >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    year,
    month,
    avg_sale
FROM 
(
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS 'rank'
    FROM retail_sales
    GROUP BY 1, 2
) AS t1
WHERE 'rank' = 1;

-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

-- Q.11 Total Sales, Total COGS and Total Profit

SELECT
    SUM(total_sale) AS total_sales,
    SUM(cogs) AS total_cogs,
    SUM(total_sale - cogs) AS total_profit
FROM retail_sales;

-- Q.12 Calculate Profit Margin

SELECT
    SUM(total_sale) AS total_sales,
    SUM(cogs) AS total_cogs,
    SUM(total_sale - cogs) AS total_profit,
    ROUND(
        (SUM(total_sale - cogs) / SUM(total_sale)) * 100,
        2
    ) AS profit_margin_percentage
FROM retail_sales;

-- Q.13 Category-wise Sales, COGS and Profit

SELECT
    category,
    SUM(total_sale) AS total_sales,
    SUM(cogs) AS total_cogs,
    SUM(total_sale - cogs) AS total_profit
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC;

-- Q.14 Category-wise Profit Margin

SELECT
    category,
    SUM(total_sale) AS total_sales,
    SUM(total_sale - cogs) AS total_profit,
    ROUND(
        (SUM(total_sale - cogs) / SUM(total_sale)) * 100,
        2
    ) AS profit_margin_percentage
FROM retail_sales
GROUP BY category
ORDER BY profit_margin_percentage DESC;

-- Q.15 Monthly Sales Trend

SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY
    YEAR(sale_date),
    MONTH(sale_date)
ORDER BY
    year,
    month;

-- Q.16 Monthly Sales and Profit Analysis

SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    SUM(total_sale) AS total_sales,
    SUM(total_sale - cogs) AS total_profit
FROM retail_sales
GROUP BY
    YEAR(sale_date),
    MONTH(sale_date)
ORDER BY
    year,
    month;
    
    -- Q.17 Top 5 Customers by Number of Transactions

SELECT
    customer_id,
    COUNT(transaction_id) AS total_transactions,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_transactions DESC
LIMIT 5;

-- Q.17 Top 5 Customers by Number of Transactions

SELECT
    customer_id,
    COUNT(*) AS total_transactions,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_transactions DESC
LIMIT 5;

-- Q.18 Calculate Average Order Value

SELECT
    ROUND(AVG(total_sale), 2) AS average_order_value
FROM retail_sales;

-- Q.19 Customer-wise Average Spending

SELECT
    customer_id,
    COUNT(*) AS total_transactions,
    SUM(total_sale) AS total_sales,
    ROUND(AVG(total_sale), 2) AS average_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY average_spending DESC
LIMIT 5;

-- Q.20 Gender-wise Sales and Transactions

SELECT
    gender,
    COUNT(*) AS total_transactions,
    SUM(total_sale) AS total_sales,
    ROUND(AVG(total_sale), 2) AS average_sale
FROM retail_sales
GROUP BY gender
ORDER BY total_sales DESC;

-- Q.21 Running Total of Sales

SELECT
    sale_date,
    total_sale,
    SUM(total_sale) OVER (
        ORDER BY sale_date
    ) AS running_total_sales
FROM retail_sales
ORDER BY sale_date;

-- Q.22 Find the Highest-Selling Category

SELECT
    category,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC
LIMIT 1;

-- Q.23 Category-wise Sales Contribution %

SELECT
    category,
    SUM(total_sale) AS category_sales,
    ROUND(
        (SUM(total_sale) / (SELECT SUM(total_sale) FROM retail_sales)) * 100,
        2
    ) AS sales_contribution_percentage
FROM retail_sales
GROUP BY category
ORDER BY sales_contribution_percentage DESC;

-- Q.24 Top 10 Highest-Value Transactions

SELECT
    transactions_id,
    customer_id,
    category,
    quantiy,
    total_sale
FROM retail_sales
ORDER BY total_sale DESC
LIMIT 10;

-- Q.25 Category-wise Average Quantity

SELECT
    category,
    ROUND(AVG(quantiy), 2) AS average_quantity,
    SUM(quantiy) AS total_quantity
FROM retail_sales
GROUP BY category
ORDER BY average_quantity DESC;

-- Q26. Find customers who made more than 5 transactions
SELECT customer_id,
       COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY customer_id
HAVING COUNT(transactions_id) > 5
ORDER BY total_transactions DESC;


-- Q27. Find total sales by age group
SELECT 
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    ROUND(SUM(total_sale), 2) AS total_sales
FROM retail_sales
GROUP BY age_group
ORDER BY total_sales DESC;


-- Q28. Find the number of customers in each age group
SELECT 
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales
GROUP BY age_group
ORDER BY total_customers DESC;


-- Q29. Find daily sales
SELECT sale_date,
       ROUND(SUM(total_sale), 2) AS daily_sales
FROM retail_sales
GROUP BY sale_date
ORDER BY sale_date;


-- Q30. Find daily profit
SELECT sale_date,
       ROUND(SUM(total_sale - cogs), 2) AS daily_profit
FROM retail_sales
GROUP BY sale_date
ORDER BY sale_date;


-- Q31. Find yearly sales
SELECT YEAR(sale_date) AS sales_year,
       ROUND(SUM(total_sale), 2) AS total_sales
FROM retail_sales
GROUP BY YEAR(sale_date)
ORDER BY sales_year;


-- Q32. Find yearly profit
SELECT YEAR(sale_date) AS sales_year,
       ROUND(SUM(total_sale - cogs), 2) AS total_profit
FROM retail_sales
GROUP BY YEAR(sale_date)
ORDER BY sales_year;


-- Q33. Find the top 10 customers based on total spending
SELECT customer_id,
       ROUND(SUM(total_sale), 2) AS total_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 10;


-- Q34. Find the bottom 10 customers based on total spending
SELECT customer_id,
       ROUND(SUM(total_sale), 2) AS total_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending ASC
LIMIT 10;


-- Q35. Find high-value customers who spent more than the average customer spending
SELECT customer_id,
       ROUND(SUM(total_sale), 2) AS total_spending
FROM retail_sales
GROUP BY customer_id
HAVING SUM(total_sale) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT SUM(total_sale) AS customer_total
        FROM retail_sales
        GROUP BY customer_id
    ) AS customer_spending
)
ORDER BY total_spending DESC;


-- Q36. Find average quantity sold by gender
SELECT gender,
       ROUND(AVG(quantiy), 2) AS avg_quantity
FROM retail_sales
GROUP BY gender;


-- Q37. Find total quantity sold by category
SELECT category,
       SUM(quantiy) AS total_quantity
FROM retail_sales
GROUP BY category
ORDER BY total_quantity DESC;


-- Q38. Find transactions with quantity greater than average quantity
SELECT transactions_id,
       customer_id,
       category,
       quantiy,
       total_sale
FROM retail_sales
WHERE quantiy >
(
    SELECT AVG(quantiy)
    FROM retail_sales
)
ORDER BY quantiy DESC;


-- Q39. Find transactions with sales greater than average sales
SELECT transactions_id,
       customer_id,
       category,
       total_sale
FROM retail_sales
WHERE total_sale >
(
    SELECT AVG(total_sale)
    FROM retail_sales
)
ORDER BY total_sale DESC;


-- Q40. Find the most profitable category
SELECT category,
       ROUND(SUM(total_sale - cogs), 2) AS total_profit
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC
LIMIT 1;


-- Q41. Find the least profitable category
SELECT category,
       ROUND(SUM(total_sale - cogs), 2) AS total_profit
FROM retail_sales
GROUP BY category
ORDER BY total_profit ASC
LIMIT 1;


-- Q42. Find sales based on time shift
SELECT
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(transactions_id) AS total_transactions,
    ROUND(SUM(total_sale), 2) AS total_sales
FROM retail_sales
GROUP BY shift
ORDER BY total_sales DESC;


-- Q43. Find sales by hour
SELECT HOUR(sale_time) AS sale_hour,
       COUNT(transactions_id) AS total_transactions,
       ROUND(SUM(total_sale), 2) AS total_sales
FROM retail_sales
GROUP BY HOUR(sale_time)
ORDER BY sale_hour;


-- Q44. Find categories having total sales greater than 50000
SELECT category,
       ROUND(SUM(total_sale), 2) AS total_sales
FROM retail_sales
GROUP BY category
HAVING SUM(total_sale) > 50000
ORDER BY total_sales DESC;


-- Q45. Use CTE to find customer total spending
WITH customer_sales AS
(
    SELECT customer_id,
           SUM(total_sale) AS total_spending
    FROM retail_sales
    GROUP BY customer_id
)
SELECT customer_id,
       ROUND(total_spending, 2) AS total_spending
FROM customer_sales
ORDER BY total_spending DESC;


-- Q46. Rank customers based on total spending
WITH customer_sales AS
(
    SELECT customer_id,
           SUM(total_sale) AS total_spending
    FROM retail_sales
    GROUP BY customer_id
)
SELECT customer_id,
       ROUND(total_spending, 2) AS total_spending,
       RANK() OVER (ORDER BY total_spending DESC) AS customer_rank
FROM customer_sales;


-- Q47. Rank categories based on total sales
SELECT category,
       ROUND(SUM(total_sale), 2) AS total_sales,
       RANK() OVER (ORDER BY SUM(total_sale) DESC) AS sales_rank
FROM retail_sales
GROUP BY category;


-- Q48. Find percentage contribution of each gender to total sales
SELECT gender,
       ROUND(SUM(total_sale), 2) AS gender_sales,
       ROUND(
           SUM(total_sale) * 100.0 /
           SUM(SUM(total_sale)) OVER (),
           2
       ) AS sales_percentage
FROM retail_sales
GROUP BY gender
ORDER BY gender_sales DESC;


-- Q49. Find category contribution percentage based on quantity sold
SELECT category,
       SUM(quantiy) AS total_quantity,
       ROUND(
           SUM(quantiy) * 100.0 /
           SUM(SUM(quantiy)) OVER (),
           2
       ) AS quantity_percentage
FROM retail_sales
GROUP BY category
ORDER BY total_quantity DESC;


-- Q50. Find running total of daily sales
WITH daily_sales AS
(
    SELECT sale_date,
           SUM(total_sale) AS total_sales
    FROM retail_sales
    GROUP BY sale_date
)
SELECT sale_date,
       ROUND(total_sales, 2) AS daily_sales,
       ROUND(
           SUM(total_sales) OVER (ORDER BY sale_date),
           2
       ) AS running_total
FROM daily_sales
ORDER BY sale_date;

DESCRIBE retail_sales;

-- Q51. Find the highest sales transaction for each category
SELECT category,
       MAX(total_sale) AS highest_sale
FROM retail_sales
GROUP BY category
ORDER BY highest_sale DESC;


-- Q52. Find the lowest sales transaction for each category
SELECT category,
       MIN(total_sale) AS lowest_sale
FROM retail_sales
GROUP BY category
ORDER BY lowest_sale ASC;


-- Q53. Find the average sales amount for each category
SELECT category,
       ROUND(AVG(total_sale), 2) AS average_sale
FROM retail_sales
GROUP BY category
ORDER BY average_sale DESC;


-- Q54. Find the average profit per transaction
SELECT ROUND(AVG(total_sale - cogs), 2) AS average_profit
FROM retail_sales;


-- Q55. Find the maximum profit transaction
SELECT transactions_id,
       customer_id,
       category,
       total_sale,
       cogs,
       ROUND(total_sale - cogs, 2) AS profit
FROM retail_sales
ORDER BY profit DESC
LIMIT 1;


-- Q56. Find the minimum profit transaction
SELECT transactions_id,
       customer_id,
       category,
       total_sale,
       cogs,
       ROUND(total_sale - cogs, 2) AS profit
FROM retail_sales
ORDER BY profit ASC
LIMIT 1;


-- Q57. Find customers who purchased from more than one category
SELECT customer_id,
       COUNT(DISTINCT category) AS categories_purchased
FROM retail_sales
GROUP BY customer_id
HAVING COUNT(DISTINCT category) > 1
ORDER BY categories_purchased DESC;


-- Q58. Find customers who purchased only one category
SELECT customer_id,
       COUNT(DISTINCT category) AS categories_purchased
FROM retail_sales
GROUP BY customer_id
HAVING COUNT(DISTINCT category) = 1;


-- Q59. Find the number of transactions for each category
SELECT category,
       COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY category
ORDER BY total_transactions DESC;


-- Q60. Find the average price per unit for each category
SELECT category,
       ROUND(AVG(price_per_unit), 2) AS average_price
FROM retail_sales
GROUP BY category
ORDER BY average_price DESC;


-- Q61. Find the highest price per unit in each category
SELECT category,
       MAX(price_per_unit) AS highest_price
FROM retail_sales
GROUP BY category
ORDER BY highest_price DESC;


-- Q62. Find the total quantity sold by gender
SELECT gender,
       SUM(quantiy) AS total_quantity
FROM retail_sales
GROUP BY gender
ORDER BY total_quantity DESC;


-- Q63. Find the average age of customers in each category
SELECT category,
       ROUND(AVG(age), 2) AS average_age
FROM retail_sales
GROUP BY category
ORDER BY average_age DESC;


-- Q64. Find the number of transactions by day of the week
SELECT DAYNAME(sale_date) AS day_name,
       COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY DAYNAME(sale_date)
ORDER BY total_transactions DESC;


-- Q65. Find total sales by day of the week
SELECT DAYNAME(sale_date) AS day_name,
       ROUND(SUM(total_sale), 2) AS total_sales
FROM retail_sales
GROUP BY DAYNAME(sale_date)
ORDER BY total_sales DESC;


-- Q66. Find sales during weekends
SELECT 
    CASE
        WHEN DAYOFWEEK(sale_date) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(transactions_id) AS total_transactions,
    ROUND(SUM(total_sale), 2) AS total_sales
FROM retail_sales
GROUP BY day_type;


-- Q67. Find the month with the highest sales
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
       ROUND(SUM(total_sale), 2) AS total_sales
FROM retail_sales
GROUP BY sales_month
ORDER BY total_sales DESC
LIMIT 1;


-- Q68. Find the month with the highest profit
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
       ROUND(SUM(total_sale - cogs), 2) AS total_profit
FROM retail_sales
GROUP BY sales_month
ORDER BY total_profit DESC
LIMIT 1;


-- Q69. Find customers with more than 10 transactions
SELECT customer_id,
       COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY customer_id
HAVING COUNT(transactions_id) > 10
ORDER BY total_transactions DESC;


-- Q70. Find customers whose average transaction value is greater than 100
SELECT customer_id,
       ROUND(AVG(total_sale), 2) AS average_transaction_value
FROM retail_sales
GROUP BY customer_id
HAVING AVG(total_sale) > 100
ORDER BY average_transaction_value DESC;


-- Q71. Find transactions where profit is greater than 50
SELECT transactions_id,
       customer_id,
       category,
       total_sale,
       cogs,
       ROUND(total_sale - cogs, 2) AS profit
FROM retail_sales
WHERE (total_sale - cogs) > 50
ORDER BY profit DESC;


-- Q72. Classify transactions based on sales amount
SELECT transactions_id,
       customer_id,
       total_sale,
       CASE
           WHEN total_sale < 50 THEN 'Low Sale'
           WHEN total_sale BETWEEN 50 AND 200 THEN 'Medium Sale'
           ELSE 'High Sale'
       END AS sales_level
FROM retail_sales
ORDER BY total_sale DESC;


-- Q73. Classify customers based on total spending
WITH customer_spending AS
(
    SELECT customer_id,
           SUM(total_sale) AS total_spending
    FROM retail_sales
    GROUP BY customer_id
)
SELECT customer_id,
       ROUND(total_spending, 2) AS total_spending,
       CASE
           WHEN total_spending < 500 THEN 'Low Value'
           WHEN total_spending BETWEEN 500 AND 1500 THEN 'Medium Value'
           ELSE 'High Value'
       END AS customer_type
FROM customer_spending
ORDER BY total_spending DESC;


-- Q74. Find the second highest sales transaction
SELECT transactions_id,
       customer_id,
       category,
       total_sale
FROM retail_sales
WHERE total_sale =
(
    SELECT MAX(total_sale)
    FROM retail_sales
    WHERE total_sale <
    (
        SELECT MAX(total_sale)
        FROM retail_sales
    )
);


-- Q75. Find the top 3 sales transactions in each category
WITH ranked_sales AS
(
    SELECT transactions_id,
           customer_id,
           category,
           total_sale,
           ROW_NUMBER() OVER
           (
               PARTITION BY category
               ORDER BY total_sale DESC
           ) AS sales_rank
    FROM retail_sales
)
SELECT transactions_id,
       customer_id,
       category,
       total_sale,
       sales_rank
FROM ranked_sales
WHERE sales_rank <= 3
ORDER BY category, sales_rank;

                         -- End of project









