/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 07_monthly_sales_view.sql

Purpose:
Create a reusable monthly sales performance view for trend analysis.

Author : Devi Sri Parvathi
===============================================================================
*/

CREATE OR REPLACE VIEW analytics.vw_monthly_sales AS

SELECT
    DATE_TRUNC(
        'month',
        o.order_purchase_timestamp
    )::DATE AS order_month,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT c.customer_unique_id) AS total_customers,

    ROUND(
        SUM(op.payment_value),
        2
    ) AS total_revenue,

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
    DATE_TRUNC(
        'month',
        o.order_purchase_timestamp
    )::DATE;