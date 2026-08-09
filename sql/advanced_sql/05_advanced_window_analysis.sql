/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 05_advanced_window_analysis.sql

Purpose:
Analyze monthly revenue trends and month-over-month revenue growth.

Business Question:
How does monthly revenue change compared with the previous month?

Author : Devi Sri Parvathi
===============================================================================
*/


-- ============================================================================
-- 1. Monthly Revenue
-- ============================================================================

WITH monthly_revenue AS (
    SELECT
        TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS order_month,
        SUM(op.payment_value) AS total_revenue
    FROM raw.orders o
    JOIN raw.order_payments op
        ON o.order_id = op.order_id
    GROUP BY order_month
)

SELECT
    order_month,
    ROUND(total_revenue, 2) AS total_revenue
FROM monthly_revenue
ORDER BY order_month;
-- ============================================================================
-- 2. Previous Month Revenue
-- ============================================================================

WITH monthly_revenue AS (
    SELECT
        TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS order_month,
        SUM(op.payment_value) AS total_revenue
    FROM raw.orders o
    JOIN raw.order_payments op
        ON o.order_id = op.order_id
    GROUP BY order_month
),

revenue_comparison AS (
    SELECT
        order_month,
        total_revenue,

        LAG(total_revenue) OVER (
            ORDER BY order_month
        ) AS previous_month_revenue

    FROM monthly_revenue
)

SELECT
    order_month,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue
FROM revenue_comparison
ORDER BY order_month;
-- ============================================================================
-- 3. Month-over-Month Revenue Change
-- ============================================================================

WITH monthly_revenue AS (
    SELECT
        TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS order_month,
        SUM(op.payment_value) AS total_revenue
    FROM raw.orders o
    JOIN raw.order_payments op
        ON o.order_id = op.order_id
    GROUP BY order_month
),

revenue_comparison AS (
    SELECT
        order_month,
        total_revenue,

        LAG(total_revenue) OVER (
            ORDER BY order_month
        ) AS previous_month_revenue

    FROM monthly_revenue
)

SELECT
    order_month,

    ROUND(total_revenue, 2) AS total_revenue,

    ROUND(previous_month_revenue, 2) AS previous_month_revenue,

    ROUND(
        total_revenue - previous_month_revenue,
        2
    ) AS revenue_change

FROM revenue_comparison
ORDER BY order_month;
-- ============================================================================
-- 4. Month-over-Month Revenue Growth %
-- ============================================================================

WITH monthly_revenue AS (
    SELECT
        TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS order_month,
        SUM(op.payment_value) AS total_revenue
    FROM raw.orders o
    JOIN raw.order_payments op
        ON o.order_id = op.order_id
    GROUP BY order_month
),

revenue_comparison AS (
    SELECT
        order_month,
        total_revenue,

        LAG(total_revenue) OVER (
            ORDER BY order_month
        ) AS previous_month_revenue

    FROM monthly_revenue
)

SELECT
    order_month,

    ROUND(total_revenue, 2) AS total_revenue,

    ROUND(previous_month_revenue, 2) AS previous_month_revenue,

    ROUND(
        (
            (total_revenue - previous_month_revenue)
            / NULLIF(previous_month_revenue, 0)
        ) * 100,
        2
    ) AS revenue_growth_percentage

FROM revenue_comparison
ORDER BY order_month;