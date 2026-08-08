/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 05_delivery_analysis.sql

Business Questions:
1. What is the average delivery time?
2. How many orders were delivered late?
3. How many orders were delivered on time?
4. What is the average difference between estimated and actual delivery?
5. Which customer states have the longest average delivery time?

Business Importance:
Delivery performance is a key factor in customer satisfaction.
Analyzing delivery times helps identify operational bottlenecks
and regions requiring improvement.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/


-- ============================================================================
-- 1. Average Delivery Time
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
    ) AS avg_delivery_days
FROM raw.orders
WHERE order_delivered_customer_date IS NOT NULL;


-- ============================================================================
-- 2. Late vs On-Time Delivery
-- ============================================================================

SELECT
    CASE
        WHEN order_delivered_customer_date >
             order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    COUNT(*) AS total_orders
FROM raw.orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status
ORDER BY total_orders DESC;


-- ============================================================================
-- 3. Late Delivery Percentage
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
-- 4. Average Difference Between Estimated and Actual Delivery
-- ============================================================================

SELECT
    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    - order_estimated_delivery_date
                )
            ) / 86400
        ),
        2
    ) AS avg_delivery_difference_days
FROM raw.orders
WHERE order_delivered_customer_date IS NOT NULL;


-- ============================================================================
-- 5. Average Delivery Time by Customer State
-- ============================================================================

SELECT
    c.customer_state,
    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    o.order_delivered_customer_date
                    - o.order_purchase_timestamp
                )
            ) / 86400
        ),
        2
    ) AS avg_delivery_days
FROM raw.orders o
JOIN raw.customers c
    ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;