/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 05_delivery_performance_view.sql

Purpose:
Create a reusable delivery performance view for dashboard reporting.

Author : Devi Sri Parvathi
===============================================================================
*/

CREATE OR REPLACE VIEW analytics.vw_delivery_performance AS

SELECT
    o.order_id,

    c.customer_state,

    o.order_status,

    o.order_purchase_timestamp,

    o.order_delivered_customer_date,

    o.order_estimated_delivery_date,

    ROUND(
        EXTRACT(
            EPOCH FROM (
                o.order_delivered_customer_date
                - o.order_purchase_timestamp
            )
        ) / 86400,
        2
    ) AS delivery_days,

    ROUND(
        EXTRACT(
            EPOCH FROM (
                o.order_delivered_customer_date
                - o.order_estimated_delivery_date
            )
        ) / 86400,
        2
    ) AS delivery_delay_days,

    CASE
        WHEN o.order_delivered_customer_date
             <= o.order_estimated_delivery_date
            THEN 'On Time'

        WHEN o.order_delivered_customer_date
             > o.order_estimated_delivery_date
            THEN 'Delayed'

        ELSE 'Not Delivered'
    END AS delivery_status

FROM raw.orders o

JOIN raw.customers c
    ON o.customer_id = c.customer_id

WHERE o.order_delivered_customer_date IS NOT NULL;