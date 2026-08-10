/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 01_sales_performance_view.sql

Purpose:
Create a reusable sales performance view for dashboard reporting.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

-- ============================================================================
-- Create Sales Performance View
-- ============================================================================

CREATE OR REPLACE VIEW analytics.vw_sales_performance AS

SELECT
    TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS order_month,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT c.customer_unique_id) AS total_customers,

    ROUND(SUM(op.payment_value), 2) AS total_revenue,

    ROUND(
        SUM(op.payment_value)
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS average_order_value

FROM raw.orders o

JOIN raw.customers c
    ON o.customer_id = c.customer_id

JOIN raw.order_payments op
    ON o.order_id = op.order_id

GROUP BY
    TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM');