/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 06_category_performance_view.sql

Purpose:
Create a reusable product category performance view for dashboard reporting.

Author : Devi Sri Parvathi
===============================================================================
*/

CREATE OR REPLACE VIEW analytics.vw_category_performance AS

SELECT
    COALESCE(
        p.product_category_name,
        'Unknown'
    ) AS product_category,

    COUNT(DISTINCT oi.product_id) AS total_products,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    COUNT(*) AS total_units_sold,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_revenue,

    ROUND(
        AVG(oi.price),
        2
    ) AS average_product_price

FROM raw.order_items oi

JOIN raw.products p
    ON oi.product_id = p.product_id

GROUP BY
    p.product_category_name;