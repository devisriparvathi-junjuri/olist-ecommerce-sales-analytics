/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 04_products_analysis.sql

Business Questions:
1. How many products are available?
2. How many product categories are there?
3. Which categories have the most products?
4. Are there products without category names?
5. What are the average product dimensions?
6. What is the average product weight?

Business Importance:
Understanding the product catalog helps identify inventory
distribution and category strength before sales analysis.

Author : Devi Sri Parvathi
===============================================================================
*/

-- ============================================================================
-- 1. Total Products
-- ============================================================================

SELECT COUNT(*) AS total_products
FROM raw.products;


-- ============================================================================
-- 2. Total Product Categories
-- ============================================================================

SELECT COUNT(DISTINCT product_category_name) AS total_categories
FROM raw.products;


-- ============================================================================
-- 3. Top 10 Product Categories
-- ============================================================================

SELECT
    product_category_name,
    COUNT(*) AS total_products
FROM raw.products
GROUP BY product_category_name
ORDER BY total_products DESC
LIMIT 10;


-- ============================================================================
-- 4. Products Without Category
-- ============================================================================

SELECT COUNT(*) AS uncategorized_products
FROM raw.products
WHERE product_category_name IS NULL;


-- ============================================================================
-- 5. Average Product Weight
-- ============================================================================

SELECT
    ROUND(AVG(product_weight_g),2) AS avg_weight_grams
FROM raw.products;


-- ============================================================================
-- 6. Average Product Dimensions
-- ============================================================================

SELECT
    ROUND(AVG(product_length_cm),2) AS avg_length_cm,
    ROUND(AVG(product_height_cm),2) AS avg_height_cm,
    ROUND(AVG(product_width_cm),2) AS avg_width_cm
FROM raw.products;


-- ============================================================================
-- 7. Products with Maximum Weight
-- ============================================================================

SELECT
    product_id,
    product_category_name,
    product_weight_g
FROM raw.products
ORDER BY product_weight_g DESC
LIMIT 10;