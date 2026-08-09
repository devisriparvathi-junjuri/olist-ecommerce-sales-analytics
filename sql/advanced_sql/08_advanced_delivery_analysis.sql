/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 08_advanced_delivery_analysis.sql

Purpose:
Advanced delivery performance analysis using CTEs and Window Functions.

Business Questions:
1. What is the average delivery time by customer state?
2. How does each state's delivery time compare with the overall average?
3. Which states have the fastest and slowest delivery?
4. What is each state's delivery performance rank?

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/


-- ============================================================================
-- 1. Average Delivery Time by State
-- ============================================================================

WITH state_delivery AS (
    SELECT
        c.customer_state,

        AVG(
            EXTRACT(
                EPOCH FROM (
                    o.order_delivered_customer_date
                    - o.order_purchase_timestamp
                )
            ) / 86400
        ) AS average_delivery_days

    FROM raw.customers c

    JOIN raw.orders o
        ON c.customer_id = o.customer_id

    WHERE o.order_delivered_customer_date IS NOT NULL

    GROUP BY c.customer_state
)

SELECT
    customer_state,
    ROUND(average_delivery_days, 2) AS average_delivery_days
FROM state_delivery
ORDER BY average_delivery_days;
-- ============================================================================
-- 2. State Delivery Time vs Overall Average
-- ============================================================================

WITH state_delivery AS (
    SELECT
        c.customer_state,

        AVG(
            EXTRACT(
                EPOCH FROM (
                    o.order_delivered_customer_date
                    - o.order_purchase_timestamp
                )
            ) / 86400
        ) AS average_delivery_days

    FROM raw.customers c

    JOIN raw.orders o
        ON c.customer_id = o.customer_id

    WHERE o.order_delivered_customer_date IS NOT NULL

    GROUP BY c.customer_state
)

SELECT
    customer_state,

    ROUND(average_delivery_days, 2)
        AS average_delivery_days,

    ROUND(
        AVG(average_delivery_days) OVER (),
        2
    ) AS overall_average_delivery_days,

    ROUND(
        average_delivery_days
        - AVG(average_delivery_days) OVER (),
        2
    ) AS difference_from_average

FROM state_delivery

ORDER BY difference_from_average;
-- ============================================================================
-- 3. Rank States by Delivery Performance
-- ============================================================================

WITH state_delivery AS (
    SELECT
        c.customer_state,

        AVG(
            EXTRACT(
                EPOCH FROM (
                    o.order_delivered_customer_date
                    - o.order_purchase_timestamp
                )
            ) / 86400
        ) AS average_delivery_days

    FROM raw.customers c

    JOIN raw.orders o
        ON c.customer_id = o.customer_id

    WHERE o.order_delivered_customer_date IS NOT NULL

    GROUP BY c.customer_state
),

ranked_states AS (
    SELECT
        customer_state,
        average_delivery_days,

        RANK() OVER (
            ORDER BY average_delivery_days ASC
        ) AS delivery_rank

    FROM state_delivery
)

SELECT
    customer_state,
    ROUND(average_delivery_days, 2) AS average_delivery_days,
    delivery_rank
FROM ranked_states
ORDER BY delivery_rank;
-- ============================================================================
-- 4. Top 5 Fastest States
-- ============================================================================

WITH state_delivery AS (
    SELECT
        c.customer_state,

        AVG(
            EXTRACT(
                EPOCH FROM (
                    o.order_delivered_customer_date
                    - o.order_purchase_timestamp
                )
            ) / 86400
        ) AS average_delivery_days

    FROM raw.customers c

    JOIN raw.orders o
        ON c.customer_id = o.customer_id

    WHERE o.order_delivered_customer_date IS NOT NULL

    GROUP BY c.customer_state
),

ranked_states AS (
    SELECT
        customer_state,
        average_delivery_days,

        RANK() OVER (
            ORDER BY average_delivery_days ASC
        ) AS delivery_rank

    FROM state_delivery
)

SELECT
    customer_state,
    ROUND(average_delivery_days, 2) AS average_delivery_days,
    delivery_rank
FROM ranked_states
WHERE delivery_rank <= 5
ORDER BY delivery_rank;