/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 05_validate_primary_keys.sql
Purpose : Validate Primary Key constraints
Author  : Devi Sri Parvathi
===============================================================================
*/

-- ============================================================================
-- Customers
-- Primary Key : customer_id
-- ============================================================================

SELECT COUNT(*) AS total_records,
       COUNT(customer_id) AS non_null_customer_id,
       COUNT(DISTINCT customer_id) AS unique_customer_id
FROM raw.customers;


-- ============================================================================
-- Orders
-- Primary Key : order_id
-- ============================================================================

SELECT COUNT(*) AS total_records,
       COUNT(order_id) AS non_null_order_id,
       COUNT(DISTINCT order_id) AS unique_order_id
FROM raw.orders;


-- ============================================================================
-- Products
-- Primary Key : product_id
-- ============================================================================

SELECT COUNT(*) AS total_records,
       COUNT(product_id) AS non_null_product_id,
       COUNT(DISTINCT product_id) AS unique_product_id
FROM raw.products;


-- ============================================================================
-- Sellers
-- Primary Key : seller_id
-- ============================================================================

SELECT COUNT(*) AS total_records,
       COUNT(seller_id) AS non_null_seller_id,
       COUNT(DISTINCT seller_id) AS unique_seller_id
FROM raw.sellers;


-- ============================================================================
-- Order Reviews
-- Primary Key : review_id
-- ============================================================================

SELECT COUNT(*) AS total_records,
       COUNT(review_id) AS non_null_review_id,
       COUNT(DISTINCT review_id) AS unique_review_id
FROM raw.order_reviews;


-- ============================================================================
-- Product Category Translation
-- Primary Key : product_category_name
-- ============================================================================

SELECT COUNT(*) AS total_records,
       COUNT(product_category_name) AS non_null_category_name,
       COUNT(DISTINCT product_category_name) AS unique_category_name
FROM raw.product_category_translation;