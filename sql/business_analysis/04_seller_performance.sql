/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 04_seller_performance.sql

Business Questions:
1. How much revenue does each seller generate?
2. How many orders does each seller handle?
3. Which sellers generate the highest revenue?
4. Which sellers sell the most products?
5. Which states generate the highest seller revenue?

Business Importance:
Seller performance analysis helps identify high-value sellers,
understand marketplace contribution, and support seller management
and partnership decisions.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/


-- ============================================================================
-- 1. Seller Revenue
-- ============================================================================

SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM raw.order_items oi
GROUP BY oi.seller_id
ORDER BY total_revenue DESC;


-- ============================================================================
-- 2. Seller Order Count
-- ============================================================================

SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS total_orders
FROM raw.order_items
GROUP BY seller_id
ORDER BY total_orders DESC;


-- ============================================================================
-- 3. Top 10 Sellers by Revenue
-- ============================================================================

SELECT
    oi.seller_id,
    s.seller_city,
    s.seller_state,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM raw.order_items oi
JOIN raw.sellers s
    ON oi.seller_id = s.seller_id
GROUP BY
    oi.seller_id,
    s.seller_city,
    s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================================
-- 4. Top 10 Sellers by Units Sold
-- ============================================================================

SELECT
    seller_id,
    COUNT(*) AS units_sold
FROM raw.order_items
GROUP BY seller_id
ORDER BY units_sold DESC
LIMIT 10;


-- ============================================================================
-- 5. Revenue by Seller State
-- ============================================================================

SELECT
    s.seller_state,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM raw.order_items oi
JOIN raw.sellers s
    ON oi.seller_id = s.seller_id
GROUP BY s.seller_state
ORDER BY total_revenue DESC;