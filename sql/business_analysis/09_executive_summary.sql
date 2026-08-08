/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 09_executive_summary.sql

Purpose:
Provide a high-level executive summary of the Olist e-commerce business
using key sales, customer, delivery, and satisfaction metrics.

Business Questions:
1. What is the total revenue?
2. How many unique customers are there?
3. How many orders have been placed?
4. What is the average order value?
5. What is the average delivery time?
6. What percentage of orders were delivered late?
7. What is the average customer review score?
8. What percentage of customers are repeat customers?

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/


-- ============================================================================
-- 1. Total Revenue
-- ============================================================================

SELECT
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM raw.order_payments;


-- ============================================================================
-- 2. Total Unique Customers
-- ============================================================================

SELECT
    COUNT(DISTINCT customer_unique_id) AS total_unique_customers
FROM raw.customers;


-- ============================================================================
-- 3. Total Orders
-- ============================================================================

SELECT
    COUNT(*) AS total_orders
FROM raw.orders;


-- ============================================================================
-- 4. Average Order Value
-- ============================================================================

SELECT
    ROUND(AVG(order_value), 2) AS average_order_value
FROM (
    SELECT
        order_id,
        SUM(payment_value) AS order_value
    FROM raw.order_payments
    GROUP BY order_id
) order_totals;


-- ============================================================================
-- 5. Average Delivery Time
-- ============================================================================

SELECT
    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    - order_purchase_timestamp
                )
            ) / 86400
        ),
        2
    ) AS average_delivery_days
FROM raw.orders
WHERE order_delivered_customer_date IS NOT NULL;


-- ============================================================================
-- 6. Late Delivery Percentage
-- ============================================================================

SELECT
    ROUND(
        COUNT(*) FILTER (
            WHERE order_delivered_customer_date >
                  order_estimated_delivery_date
        ) * 100.0 / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM raw.orders
WHERE order_delivered_customer_date IS NOT NULL;


-- ============================================================================
-- 7. Average Customer Review Score
-- ============================================================================

SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM raw.order_reviews;


-- ============================================================================
-- 8. Repeat Customer Percentage
-- ============================================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM raw.customers c
    JOIN raw.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    ROUND(
        COUNT(*) FILTER (
            WHERE total_orders > 1
        ) * 100.0 / COUNT(*),
        2
    ) AS repeat_customer_percentage
FROM customer_orders;