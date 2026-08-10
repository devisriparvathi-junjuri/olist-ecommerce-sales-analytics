/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 04_seller_performance_view.sql

Purpose:
Create a reusable seller performance view for dashboard reporting.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

CREATE OR REPLACE VIEW analytics.vw_seller_performance AS

SELECT
    oi.seller_id,

    MAX(s.seller_state) AS seller_state,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    COUNT(*) AS total_units_sold,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_revenue,

    ROUND(
        AVG(oi.price),
        2
    ) AS average_selling_price

FROM raw.order_items oi

JOIN raw.sellers s
    ON oi.seller_id = s.seller_id

GROUP BY
    oi.seller_id;