/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 01_cte_analysis.sql

Purpose:
Practice Common Table Expressions (CTEs) using the Olist dataset.

Topics:
- Basic CTE
- CTE with JOIN
- CTE with GROUP BY
- Filtering CTE results
- Multiple CTEs

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/


-- ============================================================================
-- 1. Basic CTE: Orders Per Customer
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
ORDER BY total_orders DESC;
-- ============================================================================
-- 2. Find Repeat Customers
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
WHERE total_orders > 1
ORDER BY total_orders DESC;
-- ============================================================================
-- 3. Total Number of Repeat Customers
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
    COUNT(*) AS repeat_customers
FROM customer_orders
WHERE total_orders > 1;
-- ============================================================================
-- 4. Multiple CTEs: Revenue by Customer State
-- ============================================================================

WITH order_revenue AS (
    SELECT
        order_id,
        SUM(payment_value) AS order_revenue
    FROM raw.order_payments
    GROUP BY order_id
),

state_revenue AS (
    SELECT
        c.customer_state,
        SUM(orv.order_revenue) AS total_revenue
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    JOIN order_revenue orv
        ON o.order_id = orv.order_id
    GROUP BY c.customer_state
)

SELECT
    customer_state,
    ROUND(total_revenue, 2) AS total_revenue
FROM state_revenue
ORDER BY total_revenue DESC;

