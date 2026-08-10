/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 03_product_performance_view.sql

Purpose:
Create a reusable product performance view for dashboard reporting.

Author : Devi Sri Parvathi
===============================================================================
*/

CREATE OR REPLACE VIEW analytics.vw_product_performance AS

SELECT
    oi.product_id,

    COALESCE(
        p.product_category_name,
        'Unknown'
    ) AS product_category,

    COUNT(*) AS total_units_sold,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    COUNT(DISTINCT oi.seller_id) AS total_sellers,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_revenue,

    ROUND(
        AVG(oi.price),
        2
    ) AS average_selling_price

FROM raw.order_items oi

JOIN raw.products p
    ON oi.product_id = p.product_id

GROUP BY
    oi.product_id,
    p.product_category_name;