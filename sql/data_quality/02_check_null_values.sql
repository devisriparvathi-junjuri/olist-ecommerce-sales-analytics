/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 02_check_null_values.sql
Purpose : Check NULL values in all raw tables
Author  : Devi Sri Parvathi
===============================================================================
*/

-- ============================================================================
-- Customers
-- Expected: No NULL values
-- ============================================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_id) AS customer_id,
    COUNT(customer_unique_id) AS customer_unique_id,
    COUNT(customer_zip_code_prefix) AS customer_zip_code_prefix,
    COUNT(customer_city) AS customer_city,
    COUNT(customer_state) AS customer_state
FROM raw.customers;

-- ============================================================================
-- Orders
-- Expected: NULLs in approval and delivery timestamps are normal
-- ============================================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id,
    COUNT(customer_id) AS customer_id,
    COUNT(order_status) AS order_status,
    COUNT(order_purchase_timestamp) AS order_purchase_timestamp,
    COUNT(order_approved_at) AS order_approved_at,
    COUNT(order_delivered_carrier_date) AS order_delivered_carrier_date,
    COUNT(order_delivered_customer_date) AS order_delivered_customer_date,
    COUNT(order_estimated_delivery_date) AS order_estimated_delivery_date
FROM raw.orders;

-- ============================================================================
-- Products
-- ============================================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(product_id) AS product_id,
    COUNT(product_category_name) AS product_category_name,
    COUNT(product_name_length) AS product_name_length,
    COUNT(product_description_length) AS product_description_length,
    COUNT(product_photos_qty) AS product_photos_qty,
    COUNT(product_weight_g) AS product_weight_g,
    COUNT(product_length_cm) AS product_length_cm,
    COUNT(product_height_cm) AS product_height_cm,
    COUNT(product_width_cm) AS product_width_cm
FROM raw.products;

-- ============================================================================
-- Sellers
-- ============================================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(seller_id) AS seller_id,
    COUNT(seller_zip_code_prefix) AS seller_zip_code_prefix,
    COUNT(seller_city) AS seller_city,
    COUNT(seller_state) AS seller_state
FROM raw.sellers;

-- ============================================================================
-- Order Items
-- ============================================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id,
    COUNT(order_item_id) AS order_item_id,
    COUNT(product_id) AS product_id,
    COUNT(seller_id) AS seller_id,
    COUNT(shipping_limit_date) AS shipping_limit_date,
    COUNT(price) AS price,
    COUNT(freight_value) AS freight_value
FROM raw.order_items;

-- ============================================================================
-- Order Payments
-- ============================================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id,
    COUNT(payment_sequential) AS payment_sequential,
    COUNT(payment_type) AS payment_type,
    COUNT(payment_installments) AS payment_installments,
    COUNT(payment_value) AS payment_value
FROM raw.order_payments;

-- ============================================================================
-- Order Reviews
-- ============================================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(review_id) AS review_id,
    COUNT(order_id) AS order_id,
    COUNT(review_score) AS review_score,
    COUNT(review_comment_title) AS review_comment_title,
    COUNT(review_comment_message) AS review_comment_message,
    COUNT(review_creation_date) AS review_creation_date,
    COUNT(review_answer_timestamp) AS review_answer_timestamp
FROM raw.order_reviews;

-- ============================================================================
-- Geolocation
-- ============================================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(geolocation_zip_code_prefix) AS geolocation_zip_code_prefix,
    COUNT(geolocation_lat) AS geolocation_lat,
    COUNT(geolocation_lng) AS geolocation_lng,
    COUNT(geolocation_city) AS geolocation_city,
    COUNT(geolocation_state) AS geolocation_state
FROM raw.geolocation;

-- ============================================================================
-- Product Category Translation
-- ============================================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(product_category_name) AS product_category_name,
    COUNT(product_category_name_english) AS product_category_name_english
FROM raw.product_category_translation;