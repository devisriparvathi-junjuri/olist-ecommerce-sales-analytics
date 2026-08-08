/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 08_customer_retention.sql

Business Questions:
1. How many customers placed only one order?
2. How many customers placed multiple orders?
3. What percentage of customers are repeat customers?
4. How many orders does each customer place?
5. Which customers have the highest order frequency?

Business Importance:
Customer retention analysis helps measure customer loyalty and
identify opportunities to increase repeat purchases.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/


-- ============================================================================
-- 1. Orders Per Customer
-- ============================================================================

SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM raw.customers c
JOIN raw.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC;


-- ============================================================================
-- 2. One-Time vs Repeat Customers
-- ============================================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM customer_orders
GROUP BY customer_type
ORDER BY total_customers DESC;


-- ============================================================================
-- 3. Repeat Customer Percentage
-- ============================================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    ROUND(
        COUNT(*) FILTER (
            WHERE total_orders > 1
        ) * 100.0 / COUNT(*),
        2
    ) AS repeat_customer_percentage
FROM customer_orders;


-- ============================================================================
-- 4. Average Orders Per Customer
-- ============================================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    ROUND(AVG(total_orders), 2) AS average_orders_per_customer
FROM customer_orders;


-- ============================================================================
-- 5. Top 10 Customers by Order Frequency
-- ============================================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    customer_unique_id,
    total_orders
FROM customer_orders
ORDER BY total_orders DESC
LIMIT 10;