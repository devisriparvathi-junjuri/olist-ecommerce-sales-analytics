/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 08_payment_performance_view.sql

Purpose:
Create a reusable payment performance view for dashboard reporting.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

CREATE OR REPLACE VIEW analytics.vw_payment_performance AS

SELECT
    op.payment_type,

    COUNT(*) AS total_payment_records,

    COUNT(DISTINCT op.order_id) AS total_orders,

    ROUND(
        SUM(op.payment_value),
        2
    ) AS total_payment_value,

    ROUND(
        AVG(op.payment_value),
        2
    ) AS average_payment_value,

    ROUND(
        AVG(op.payment_installments),
        2
    ) AS average_installments

FROM raw.order_payments op

GROUP BY
    op.payment_type;