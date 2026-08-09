/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 07_advanced_product_analysis.sql

Purpose:
Advanced product-level analysis using CTEs and Window Functions.

Business Questions:
1. What are the top products by revenue?
2. What is each product's rank within its category?
3. What percentage of category revenue does each product generate?
4. Which products contribute to the first 80% of category revenue?

Author : Devi Sri Parvathi
===============================================================================
*/


-- ============================================================================
-- 1. Product Revenue
-- ============================================================================

WITH product_revenue AS (
    SELECT
        oi.product_id,
        COALESCE(
            p.product_category_name,
            'Unknown'
        ) AS product_category,
        SUM(oi.price) AS total_revenue
    FROM raw.order_items oi
    JOIN raw.products p
        ON oi.product_id = p.product_id
    GROUP BY
        oi.product_id,
        p.product_category_name
)

SELECT
    product_id,
    product_category,
    ROUND(total_revenue, 2) AS total_revenue
FROM product_revenue
ORDER BY total_revenue DESC;


-- ============================================================================
-- 2. Product Rank Within Category
-- ============================================================================

WITH product_revenue AS (
    SELECT
        oi.product_id,
        COALESCE(
            p.product_category_name,
            'Unknown'
        ) AS product_category,
        SUM(oi.price) AS total_revenue
    FROM raw.order_items oi
    JOIN raw.products p
        ON oi.product_id = p.product_id
    GROUP BY
        oi.product_id,
        p.product_category_name
),

ranked_products AS (
    SELECT
        product_id,
        product_category,
        total_revenue,

        RANK() OVER (
            PARTITION BY product_category
            ORDER BY total_revenue DESC
        ) AS category_rank

    FROM product_revenue
)

SELECT
    product_id,
    product_category,
    ROUND(total_revenue, 2) AS total_revenue,
    category_rank
FROM ranked_products
ORDER BY
    product_category,
    category_rank;


-- ============================================================================
-- 3. Product Contribution to Category Revenue
-- ============================================================================

WITH product_revenue AS (
    SELECT
        oi.product_id,
        COALESCE(
            p.product_category_name,
            'Unknown'
        ) AS product_category,
        SUM(oi.price) AS total_revenue
    FROM raw.order_items oi
    JOIN raw.products p
        ON oi.product_id = p.product_id
    GROUP BY
        oi.product_id,
        p.product_category_name
)

SELECT
    product_id,
    product_category,
    ROUND(total_revenue, 2) AS total_revenue,

    ROUND(
        total_revenue * 100.0 /
        SUM(total_revenue) OVER (
            PARTITION BY product_category
        ),
        2
    ) AS category_revenue_percentage

FROM product_revenue
ORDER BY
    product_category,
    total_revenue DESC;


-- ============================================================================
-- 4. Cumulative Revenue Contribution Within Category
-- ============================================================================

WITH product_revenue AS (
    SELECT
        oi.product_id,
        COALESCE(
            p.product_category_name,
            'Unknown'
        ) AS product_category,
        SUM(oi.price) AS total_revenue
    FROM raw.order_items oi
    JOIN raw.products p
        ON oi.product_id = p.product_id
    GROUP BY
        oi.product_id,
        p.product_category_name
)

SELECT
    product_id,
    product_category,
    ROUND(total_revenue, 2) AS total_revenue,

    ROUND(
        SUM(total_revenue) OVER (
            PARTITION BY product_category
            ORDER BY total_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )
        * 100.0
        /
        SUM(total_revenue) OVER (
            PARTITION BY product_category
        ),
        2
    ) AS cumulative_revenue_percentage

FROM product_revenue
ORDER BY
    product_category,
    total_revenue DESC;


-- ============================================================================
-- 5. Products Contributing to First 80% of Category Revenue
-- ============================================================================

WITH product_revenue AS (
    SELECT
        oi.product_id,
        COALESCE(
            p.product_category_name,
            'Unknown'
        ) AS product_category,
        SUM(oi.price) AS total_revenue
    FROM raw.order_items oi
    JOIN raw.products p
        ON oi.product_id = p.product_id
    GROUP BY
        oi.product_id,
        p.product_category_name
),

cumulative_revenue AS (
    SELECT
        product_id,
        product_category,
        total_revenue,

        SUM(total_revenue) OVER (
            PARTITION BY product_category
            ORDER BY total_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )
        * 100.0
        /
        SUM(total_revenue) OVER (
            PARTITION BY product_category
        ) AS cumulative_percentage

    FROM product_revenue
)

SELECT
    product_id,
    product_category,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(cumulative_percentage, 2) AS cumulative_revenue_percentage
FROM cumulative_revenue
WHERE cumulative_percentage <= 80
ORDER BY
    product_category,
    cumulative_percentage;