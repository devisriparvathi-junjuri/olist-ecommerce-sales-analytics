/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 09_executive_kpi_view.sql

Purpose:
Create a reusable executive KPI view for dashboard reporting.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

CREATE OR REPLACE VIEW analytics.vw_executive_kpi AS

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT c.customer_unique_id) AS total_customers,

    COUNT(DISTINCT oi.product_id) AS total_products,

    COUNT(DISTINCT oi.seller_id) AS total_sellers,

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

JOIN raw.order_items oi
    ON o.order_id = oi.order_id;
    