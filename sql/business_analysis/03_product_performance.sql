/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 03_product_analysis.sql

Business Questions:
1. Which product categories generate the highest revenue?
2. Which product categories sell the most units?
3. What is the average selling price by category?
4. Which products generate the highest revenue?
5. What percentage of total revenue comes from each category?

Business Importance:
Product-level analysis helps identify high-performing categories and products,
support pricing decisions, inventory planning, and revenue optimization.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/


-- ============================================================================
-- 1. Revenue by Product Category
-- ============================================================================

SELECT
    COALESCE(p.product_category_name, 'Unknown') AS product_category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM raw.order_items oi
JOIN raw.products p
    ON oi.product_id = p.product_id
GROUP BY product_category
ORDER BY total_revenue DESC;


-- ============================================================================
-- 2. Units Sold by Product Category
-- ============================================================================

SELECT
    COALESCE(p.product_category_name, 'Unknown') AS product_category,
    COUNT(*) AS units_sold
FROM raw.order_items oi
JOIN raw.products p
    ON oi.product_id = p.product_id
GROUP BY product_category
ORDER BY units_sold DESC;


-- ============================================================================
-- 3. Average Selling Price by Product Category
-- ============================================================================

SELECT
    COALESCE(p.product_category_name, 'Unknown') AS product_category,
    ROUND(AVG(oi.price), 2) AS average_price
FROM raw.order_items oi
JOIN raw.products p
    ON oi.product_id = p.product_id
GROUP BY product_category
ORDER BY average_price DESC;


-- ============================================================================
-- 4. Top 10 Products by Revenue
-- ============================================================================

SELECT
    oi.product_id,
    COALESCE(p.product_category_name, 'Unknown') AS product_category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM raw.order_items oi
JOIN raw.products p
    ON oi.product_id = p.product_id
GROUP BY
    oi.product_id,
    p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================================
-- 5. Revenue Contribution by Product Category
-- ============================================================================

SELECT
    COALESCE(p.product_category_name, 'Unknown') AS product_category,
    ROUND(SUM(oi.price), 2) AS category_revenue,
    ROUND(
        SUM(oi.price) * 100.0 /
        SUM(SUM(oi.price)) OVER (),
        2
    ) AS revenue_percentage
FROM raw.order_items oi
JOIN raw.products p
    ON oi.product_id = p.product_id
GROUP BY product_category
ORDER BY category_revenue DESC;