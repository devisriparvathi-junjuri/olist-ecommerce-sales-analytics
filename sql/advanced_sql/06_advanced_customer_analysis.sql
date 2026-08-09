/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 06_advanced_customer_analysis.sql

Purpose:
Analyze customer revenue using CTEs and Window Functions.

Business Questions:
1. How much revenue did each customer generate?
2. What is each customer's revenue rank?
3. What percentage of total revenue comes from each customer?
4. Which customers are in the top 10% by revenue?

Author : Devi Sri Parvathi
===============================================================================
*/


-- ============================================================================
-- 1. Customer Revenue
-- ============================================================================

WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(op.payment_value) AS total_revenue
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    JOIN raw.order_payments op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    customer_unique_id,
    ROUND(total_revenue, 2) AS total_revenue
FROM customer_revenue
ORDER BY total_revenue DESC;


-- ============================================================================
-- 2. Rank Customers by Revenue
-- ============================================================================

WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(op.payment_value) AS total_revenue
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    JOIN raw.order_payments op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
),

ranked_customers AS (
    SELECT
        customer_unique_id,
        total_revenue,

        RANK() OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_rank

    FROM customer_revenue
)

SELECT
    customer_unique_id,
    ROUND(total_revenue, 2) AS total_revenue,
    revenue_rank
FROM ranked_customers
ORDER BY revenue_rank;


-- ============================================================================
-- 3. Top 10 Customers by Revenue
-- ============================================================================

WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(op.payment_value) AS total_revenue
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    JOIN raw.order_payments op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
),

ranked_customers AS (
    SELECT
        customer_unique_id,
        total_revenue,

        RANK() OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_rank

    FROM customer_revenue
)

SELECT
    customer_unique_id,
    ROUND(total_revenue, 2) AS total_revenue,
    revenue_rank
FROM ranked_customers
WHERE revenue_rank <= 10
ORDER BY revenue_rank;


-- ============================================================================
-- 4. Customer Revenue Contribution
-- ============================================================================

WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(op.payment_value) AS total_revenue
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    JOIN raw.order_payments op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    customer_unique_id,
    ROUND(total_revenue, 2) AS total_revenue,

    ROUND(
        total_revenue * 100.0 /
        SUM(total_revenue) OVER (),
        2
    ) AS revenue_percentage

FROM customer_revenue
ORDER BY total_revenue DESC;


-- ============================================================================
-- 5. Customer Revenue Percentile
-- ============================================================================

WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(op.payment_value) AS total_revenue
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    JOIN raw.order_payments op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
),

customer_percentiles AS (
    SELECT
        customer_unique_id,
        total_revenue,

        NTILE(10) OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_decile

    FROM customer_revenue
)

SELECT
    customer_unique_id,
    ROUND(total_revenue, 2) AS total_revenue,
    revenue_decile
FROM customer_percentiles
WHERE revenue_decile = 1
ORDER BY total_revenue DESC;

