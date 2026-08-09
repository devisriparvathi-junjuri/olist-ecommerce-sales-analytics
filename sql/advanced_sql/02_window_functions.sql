/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 02_window_functions.sql

Purpose:
Practice SQL Window Functions using the Olist dataset.

Author : Devi Sri Parvathi
===============================================================================
*/


-- ============================================================================
-- 1. Total Revenue Alongside Each Payment
-- ============================================================================

SELECT
    order_id,
    payment_value,
    ROUND(SUM(payment_value) OVER (), 2) AS total_revenue
FROM raw.order_payments
LIMIT 20;
-- ============================================================================
-- 2. Revenue by Payment Type Using PARTITION BY
-- ============================================================================

SELECT
    order_id,
    payment_type,
    payment_value,
    ROUND(
        SUM(payment_value) OVER (
            PARTITION BY payment_type
        ),
        2
    ) AS payment_type_revenue
FROM raw.order_payments
LIMIT 20;
-- ============================================================================
-- 3. ROW_NUMBER()
-- ============================================================================

SELECT
    order_id,
    payment_type,
    payment_value,
    ROW_NUMBER() OVER (
        PARTITION BY payment_type
        ORDER BY payment_value DESC
    ) AS payment_rank
FROM raw.order_payments;
-- ============================================================================
-- 4. RANK()
-- ============================================================================

SELECT
    order_id,
    payment_type,
    payment_value,
    RANK() OVER (
        PARTITION BY payment_type
        ORDER BY payment_value DESC
    ) AS payment_rank
FROM raw.order_payments;
-- ============================================================================
-- 6. LAG()
-- ============================================================================

SELECT
    order_id,
    payment_value,
    LAG(payment_value) OVER (
        ORDER BY payment_value
    ) AS previous_payment
FROM raw.order_payments
LIMIT 20;