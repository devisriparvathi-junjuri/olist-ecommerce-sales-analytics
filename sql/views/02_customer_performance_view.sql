/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 02_customer_performance_view.sql

Purpose:
Create a reusable customer performance view for dashboard reporting.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

CREATE OR REPLACE VIEW analytics.vw_customer_performance AS

SELECT
    c.customer_unique_id,

    MAX(c.customer_state) AS customer_state,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(
        SUM(op.payment_value),
        2
    ) AS total_revenue,

    ROUND(
        SUM(op.payment_value)
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS average_order_value

FROM raw.customers c

JOIN raw.orders o
    ON c.customer_id = o.customer_id

JOIN raw.order_payments op
    ON o.order_id = op.order_id

GROUP BY
    c.customer_unique_id;