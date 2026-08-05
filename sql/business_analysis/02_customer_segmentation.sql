/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 02_customer_analysis.sql

Business Questions:
1. How many unique customers have placed orders?
2. Which states generate the highest number of customers?
3. Which cities have the highest number of customers?
4. Which customers placed multiple orders?
5. What is the average number of orders per customer?

Business Importance:
Understanding customer behavior helps identify loyal customers,
high-performing regions, and opportunities for customer retention.

Author : Devi Sri Parvathi
===============================================================================
*/

-- ============================================================================
-- 1. Total Unique Customers
-- ============================================================================

SELECT
    COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM raw.customers;


-- ============================================================================
-- 2. Top 10 States by Customer Count
-- ============================================================================

SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM raw.customers
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 10;


-- ============================================================================
-- 3. Top 10 Cities by Customer Count
-- ============================================================================

SELECT
    customer_city,
    COUNT(*) AS total_customers
FROM raw.customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;


-- ============================================================================
-- 4. Customers with Multiple Orders
-- ============================================================================

SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM raw.customers c
JOIN raw.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;


-- ============================================================================
-- 5. Average Orders Per Customer
-- ============================================================================

SELECT
    ROUND(AVG(order_count),2) AS avg_orders_per_customer
FROM
(
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) customer_orders;