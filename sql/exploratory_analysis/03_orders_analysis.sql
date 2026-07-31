/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 03_orders_analysis.sql

Business Questions:
1. How many total orders are there?
2. What are the different order statuses?
3. Which order status is the most common?
4. How many orders were placed each year?
5. How many orders were placed each month?
6. What is the first and last order date?

Business Importance:
Analyzing order trends helps understand business growth,
customer purchasing behavior, and operational performance.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

-- ============================================================================
-- 1. Total Orders
-- ============================================================================

SELECT COUNT(*) AS total_orders
FROM raw.orders;


-- ============================================================================
-- 2. Order Status Distribution
-- ============================================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM raw.orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- ============================================================================
-- 3. Orders by Year
-- ============================================================================

SELECT
    EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,
    COUNT(*) AS total_orders
FROM raw.orders
GROUP BY order_year
ORDER BY order_year;


-- ============================================================================
-- 4. Orders by Month
-- ============================================================================

SELECT
    TO_CHAR(order_purchase_timestamp,'YYYY-MM') AS order_month,
    COUNT(*) AS total_orders
FROM raw.orders
GROUP BY order_month
ORDER BY order_month;


-- ============================================================================
-- 5. First and Last Order Date
-- ============================================================================

SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM raw.orders;


-- ============================================================================
-- 6. Delivered vs Cancelled Orders
-- ============================================================================

SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),2) AS percentage
FROM raw.orders
GROUP BY order_status
ORDER BY total_orders DESC;