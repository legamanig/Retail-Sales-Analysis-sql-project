# 🛍️ Retail Sales SQL Data Analysis Project

## 📌 Project Overview

This project focuses on analyzing **retail sales data using MySQL** to extract meaningful business insights from transactional data.

The project covers the complete SQL analysis workflow, including:

* Database and table creation
* Data exploration
* Data quality checking
* Data cleaning
* Sales analysis
* Customer analysis
* Category-wise analysis
* Gender-wise analysis
* Profit and COGS analysis
* Monthly and yearly sales analysis
* Time-based sales analysis
* Advanced SQL queries
* Subqueries
* CTEs
* CASE statements
* Window functions
* Ranking
* Business-oriented analysis

The main objective of this project is to understand sales performance, customer behavior, product category performance, and profitability using SQL.

---

## 🎯 Project Objectives

The major objectives of this project are:

1. Understand the structure of retail sales data.
2. Check and identify missing values.
3. Explore sales and customer information.
4. Analyze sales performance by category.
5. Analyze customer purchasing behavior.
6. Compare sales based on gender.
7. Analyze sales trends over time.
8. Calculate total sales, COGS, and profit.
9. Identify high-value customers.
10. Analyze sales based on different time periods.
11. Apply advanced SQL concepts to solve business problems.
12. Generate useful insights that can support business decisions.

---

## 🗃️ Database Information

### Database Name

```sql
sql_project_p1
```

### Main Table

```sql
retail_sales
```

The project uses a single retail transaction table containing sales, customer, product category, quantity, pricing, cost, and transaction information.

---

## 📊 Dataset Structure

The `retail_sales` table contains the following columns:

| Column            | Data Type | Description           |
| ----------------- | --------- | --------------------- |
| `transactions_id` | INT       | Unique transaction ID |
| `sale_date`       | DATE      | Date of the sale      |
| `sale_time`       | TIME      | Time of the sale      |
| `customer_id`     | INT       | Unique customer ID    |
| `gender`          | VARCHAR   | Customer gender       |
| `age`             | INT       | Customer age          |
| `category`        | VARCHAR   | Product category      |
| `quantiy`         | INT       | Quantity sold         |
| `price_per_unit`  | FLOAT     | Price of one unit     |
| `cogs`            | FLOAT     | Cost of goods sold    |
| `total_sale`      | FLOAT     | Total sales amount    |

> **Note:** The column is named `quantiy` in the original database schema and is used with the same spelling throughout the SQL project.

---

## 🔧 SQL Workflow

The project follows this general workflow:

```text
Database Creation
       ↓
Table Creation
       ↓
Data Exploration
       ↓
Data Quality Check
       ↓
Data Cleaning
       ↓
Basic Analysis
       ↓
Business Analysis
       ↓
Advanced SQL Analysis
       ↓
Business Insights
```

---

# 1️⃣ Database & Table Creation

The project begins by creating the database and the `retail_sales` table.

```sql
CREATE DATABASE sql_project_p1;

USE sql_project_p1;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

# 2️⃣ Data Exploration

Initial exploration is performed to understand the dataset.

Some of the basic exploration queries include:

* Viewing all records
* Counting total records
* Viewing the first 10 records
* Counting customers
* Counting unique customers
* Finding distinct product categories

Example:

```sql
SELECT * 
FROM retail_sales;

SELECT COUNT(*) 
FROM retail_sales;

SELECT *
FROM retail_sales
LIMIT 10;
```

---

# 3️⃣ Data Quality & Cleaning

Before performing analysis, the dataset is checked for missing or NULL values.

The project checks important columns such as:

* Transaction ID
* Sale date
* Sale time
* Customer ID
* Gender
* Age
* Category
* Quantity
* Price per unit
* COGS
* Total sale

Example:

```sql
SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

This helps ensure that the data is suitable for further analysis.

---

# 4️⃣ Business Analysis

The project contains multiple business questions and SQL queries to analyze the retail dataset.

## 🔹 Basic Business Questions

The initial analysis includes questions such as:

### Q1. Sales on a Specific Date

Retrieve all sales made on a particular date.

### Q2. Category and Quantity Analysis

Identify clothing transactions based on quantity and date conditions.

### Q3. Category-wise Sales

Calculate total sales for each product category.

### Q4. Customer Age Analysis

Find the average age of customers purchasing products from the Beauty category.

### Q5. High-Value Transactions

Find transactions where total sales are greater than a specified amount.

### Q6. Gender and Category Analysis

Calculate the number of transactions made by each gender across categories.

### Q7. Monthly Sales Analysis

Calculate average monthly sales and identify high-performing months.

### Q8. Top Customers

Identify the top customers based on total sales.

### Q9. Unique Customers by Category

Calculate the number of unique customers purchasing from each category.

### Q10. Shift-wise Sales

Analyze orders based on:

* Morning
* Afternoon
* Evening

---

# 5️⃣ Sales & Profit Analysis

The project goes beyond basic sales analysis and calculates important financial metrics.

### Total Sales

```sql
SUM(total_sale)
```

### Total COGS

```sql
SUM(cogs)
```

### Total Profit

```sql
SUM(total_sale - cogs)
```

### Profit Margin

The project also calculates profit margin as a percentage of total sales.

This helps understand the overall profitability of the business.

---

# 6️⃣ Category Performance Analysis

Product categories are analyzed based on:

* Total sales
* Total COGS
* Total profit
* Profit margin
* Quantity sold
* Number of transactions
* Average sales
* Average price

This allows us to identify high-performing and low-performing categories.

---

# 7️⃣ Customer Analysis

Customer-level analysis includes:

* Total spending by customer
* Number of transactions
* Average transaction value
* Top customers
* Lowest-spending customers
* High-value customers
* Customers purchasing multiple categories
* Customer classification

Customers can also be grouped into categories such as:

```text
Low Value
Medium Value
High Value
```

This provides a better understanding of customer purchasing behavior.

---

# 8️⃣ Age Group Analysis

Customers are grouped into different age groups using SQL `CASE`.

Example:

```text
18-25
26-35
36-45
46-60
60+
```

This helps analyze which age groups contribute more to sales.

---

# 9️⃣ Gender-wise Analysis

The project analyzes sales and transaction behavior based on gender.

Metrics include:

* Total sales
* Number of transactions
* Quantity sold
* Sales contribution percentage

This helps compare purchasing behavior between customer groups.

---

# 🔟 Time-based Analysis

The project performs several time-based analyses.

### Daily Analysis

* Daily sales
* Daily profit

### Monthly Analysis

* Monthly sales
* Monthly profit
* Average monthly sales
* Highest-performing month

### Yearly Analysis

* Yearly sales
* Yearly profit

### Hourly Analysis

Sales are also analyzed based on the hour of the transaction.

---

# ⏰ Shift-wise Analysis

Sales transactions are classified into different shifts:

```text
Morning
Afternoon
Evening
```

This helps identify which time period receives the highest number of orders and sales.

---

# 🧮 Advanced SQL Concepts Used

This project demonstrates several important SQL concepts.

### Basic SQL

* `SELECT`
* `WHERE`
* `ORDER BY`
* `LIMIT`
* `DISTINCT`

### Aggregation

* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`

### Grouping

* `GROUP BY`
* `HAVING`

### Date & Time Functions

* `YEAR()`
* `MONTH()`
* `DAYNAME()`
* `DAYOFWEEK()`
* `HOUR()`
* `DATE_FORMAT()`

### Conditional Logic

* `CASE`

### Advanced SQL

* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* `RANK()`
* `ROW_NUMBER()`
* `PARTITION BY`
* Running totals

---

# 📈 Window Function Analysis

Window functions are used for advanced business analysis.

For example, customers can be ranked according to their total spending.

```sql
RANK() OVER (
    ORDER BY total_spending DESC
)
```

The project also uses window functions for:

* Customer ranking
* Category ranking
* Running totals
* Top transactions within categories
* Sales contribution percentages

---

# 🔍 Subquery Analysis

Subqueries are used to compare individual records against overall averages and other calculated values.

Examples include:

* Customers spending more than the average customer
* Transactions above average sales
* Transactions above average quantity
* Finding the second-highest transaction

---

# 🔄 CTE Analysis

Common Table Expressions are used to make complex queries easier to understand and maintain.

Example:

```sql
WITH customer_sales AS
(
    SELECT customer_id,
           SUM(total_sale) AS total_spending
    FROM retail_sales
    GROUP BY customer_id
)
SELECT *
FROM customer_sales;
```

CTEs are used for customer analysis, ranking, classification, and other advanced calculations.

---

# 💡 Key Business Insights

The SQL analysis can be used to identify:

* Which product categories generate the highest sales
* Which categories generate the highest profit
* Which customers contribute the most revenue
* Which age groups contribute more to sales
* Which gender contributes more to total sales
* Which months have stronger sales performance
* Which days or time periods have higher transaction volumes
* Which transactions generate high revenue
* Which customers are high-value customers
* Which categories have stronger quantity demand

These insights can help businesses make better decisions related to:

* Customer targeting
* Product strategy
* Sales planning
* Inventory planning
* Marketing
* Customer retention
* Revenue optimization

---

# 🛠️ Tools & Technologies

| Tool                      | Purpose                               |
| ------------------------- | ------------------------------------- |
| MySQL                     | Database and SQL analysis             |
| SQL                       | Data querying and analysis            |
| GitHub                    | Project version control and portfolio |
| VS Code / MySQL Workbench | SQL                                   |
