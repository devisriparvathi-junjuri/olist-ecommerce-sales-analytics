/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 04_advanced_joins.sql

Purpose:
Practice multi-table JOINs using the Olist dataset.

Business Question:
Which customer states generate the highest revenue?

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/


-- ============================================================================
-- 1. Revenue by Customer State
-- ============================================================================

SELECT
    c.customer_state,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM raw.customers c

JOIN raw.orders o
    ON c.customer_id = o.customer_id

JOIN raw.order_items oi
    ON o.order_id = oi.order_id

GROUP BY c.customer_state
ORDER BY total_revenue DESC;
-- ============================================================================
-- 2. Revenue + Orders + Customers by State
-- ============================================================================

SELECT
    c.customer_state,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT c.customer_unique_id) AS total_customers,

    ROUND(SUM(oi.price), 2) AS total_revenue

FROM raw.customers c

JOIN raw.orders o
    ON c.customer_id = o.customer_id

JOIN raw.order_items oi
    ON o.order_id = oi.order_id

GROUP BY c.customer_state

ORDER BY total_revenue DESC;
-- ============================================================================
-- 3. Revenue by State and Product Category
-- ============================================================================

SELECT
    c.customer_state,

    COALESCE(
        p.product_category_name,
        'Unknown'
    ) AS product_category,

    ROUND(SUM(oi.price), 2) AS total_revenue

FROM raw.customers c

JOIN raw.orders o
    ON c.customer_id = o.customer_id

JOIN raw.order_items oi
    ON o.order_id = oi.order_id

JOIN raw.products p
    ON oi.product_id = p.product_id

GROUP BY
    c.customer_state,
    p.product_category_name

ORDER BY
    c.customer_state,
    total_revenue DESC;
