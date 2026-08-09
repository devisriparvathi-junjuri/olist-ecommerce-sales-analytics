/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 03_ranking_analysis.sql

Purpose:
Use Window Functions to rank products within product categories.

Business Question:
What are the top 3 products by revenue within each product category?

Author : Devi Sri Parvathi
===============================================================================
*/


-- ============================================================================
-- 1. Calculate Product Revenue
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
-- 2. Rank Products Within Each Category
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
        ) AS revenue_rank

    FROM product_revenue
)

SELECT
    product_id,
    product_category,
    ROUND(total_revenue, 2) AS total_revenue,
    revenue_rank
FROM ranked_products
ORDER BY
    product_category,
    revenue_rank;
-- ============================================================================
-- 3. Top 3 Products by Revenue in Each Category
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
        ) AS revenue_rank

    FROM product_revenue
)

SELECT
    product_id,
    product_category,
    ROUND(total_revenue, 2) AS total_revenue,
    revenue_rank
FROM ranked_products
WHERE revenue_rank <= 3
ORDER BY
    product_category,
    revenue_rank;