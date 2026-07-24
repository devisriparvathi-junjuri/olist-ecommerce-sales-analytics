/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 03_check_duplicate_records.sql
Purpose : Identify duplicate records across all raw tables
Author  : Devi Sri Parvathi
===============================================================================
*/

-- ============================================================================
-- Customers
-- Business Rule: customer_id must be unique.
-- ============================================================================

SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM raw.customers
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================================
-- Orders
-- Business Rule: order_id must be unique.
-- ============================================================================

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM raw.orders
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================================
-- Products
-- Business Rule: product_id must be unique.
-- ============================================================================

SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM raw.products
GROUP BY product_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================================
-- Sellers
-- Business Rule: seller_id must be unique.
-- ============================================================================

SELECT
    seller_id,
    COUNT(*) AS duplicate_count
FROM raw.sellers
GROUP BY seller_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================================
-- Order Items
-- Business Rule:
-- Composite Key = (order_id, order_item_id)
-- ============================================================================

SELECT
    order_id,
    order_item_id,
    COUNT(*) AS duplicate_count
FROM raw.order_items
GROUP BY
    order_id,
    order_item_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================================
-- Order Payments
-- Business Rule:
-- Composite Key = (order_id, payment_sequential)
-- ============================================================================

SELECT
    order_id,
    payment_sequential,
    COUNT(*) AS duplicate_count
FROM raw.order_payments
GROUP BY
    order_id,
    payment_sequential
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================================
-- Order Reviews
-- Business Rule: review_id should be unique.
-- ============================================================================

SELECT
    review_id,
    COUNT(*) AS duplicate_count
FROM raw.order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================================
-- Geolocation
-- NOTE:
-- Duplicate geolocation records exist in the original Olist dataset.
-- We check exact duplicate rows instead of a primary key.
-- ============================================================================

SELECT
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state,
    COUNT(*) AS duplicate_count
FROM raw.geolocation
GROUP BY
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================================
-- Product Category Translation
-- Business Rule: product_category_name should be unique.
-- ============================================================================

SELECT
    product_category_name,
    COUNT(*) AS duplicate_count
FROM raw.product_category_translation
GROUP BY product_category_name
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;