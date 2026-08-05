/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 01_sales_performance.sql

Business Questions:
1. What is the total revenue generated?
2. How many orders generated revenue?
3. What is the average order value?
4. What is the highest order value?
5. What is the monthly revenue trend?

Business Importance:
These KPIs help management understand business growth,
sales performance, and revenue trends.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

-- ============================================================================
-- 1. Total Revenue
-- ============================================================================

SELECT
    ROUND(SUM(payment_value),2) AS total_revenue
FROM raw.order_payments;


-- ============================================================================
-- 2. Total Revenue Generating Orders
-- ============================================================================

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM raw.order_payments;


-- ============================================================================
-- 3. Average Order Value
-- ============================================================================

SELECT
    ROUND(AVG(payment_value),2) AS average_order_value
FROM raw.order_payments;


-- ============================================================================
-- 4. Highest Order Value
-- ============================================================================

SELECT
    ROUND(MAX(payment_value),2) AS highest_order_value
FROM raw.order_payments;


-- ============================================================================
-- 5. Monthly Revenue Trend
-- ============================================================================

SELECT
    TO_CHAR(o.order_purchase_timestamp,'YYYY-MM') AS order_month,
    ROUND(SUM(op.payment_value),2) AS total_revenue
FROM raw.orders o
JOIN raw.order_payments op
ON o.order_id = op.order_id
GROUP BY order_month
ORDER BY order_month;