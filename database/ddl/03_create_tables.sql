/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 03_create_tables.sql
Purpose : Create all tables in the raw schema
Author  : Devi Sri Parvathi Junjuri
Database: PostgreSQL 18
===============================================================================
*/

/*
===============================================================================
Table: customers
Description: Stores customer demographic and location information.
===============================================================================
*/

CREATE TABLE raw.customers(customer_id VARCHAR(32),
    customer_unique_id VARCHAR(32),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

-- ============================================================================
-- Table: orders
-- Description: Stores order information
-- ============================================================================

CREATE TABLE raw.orders (
    order_id VARCHAR(32),
    customer_id VARCHAR(32),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- ============================================================================
-- Table: products
-- Description: Stores product information
-- ============================================================================

CREATE TABLE raw.products (
    product_id VARCHAR(32),
    product_category_name VARCHAR(100),
    product_name_lenght INTEGER,
    product_description_lenght INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

-- ============================================================================
-- Table: order_items
-- Description: Stores product-level details for each order
-- ============================================================================

CREATE TABLE raw.order_items (
    order_id VARCHAR(32),
    order_item_id INTEGER,
    product_id VARCHAR(32),
    seller_id VARCHAR(32),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2)
);

-- ============================================================================
-- Table: order_payments
-- Description: Stores payment details for each order
-- ============================================================================

CREATE TABLE raw.order_payments (
    order_id VARCHAR(32),
    payment_sequential INTEGER,
    payment_type VARCHAR(20),
    payment_installments INTEGER,
    payment_value NUMERIC(10,2)
);

-- ============================================================================
-- Table: order_reviews
-- Description: Stores customer reviews for each order
-- ============================================================================

CREATE TABLE raw.order_reviews (
    review_id VARCHAR(32),
    order_id VARCHAR(32),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

-- ============================================================================
-- Table: sellers
-- Description: Stores seller information
-- ============================================================================

CREATE TABLE raw.sellers (
    seller_id VARCHAR(32),
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);

-- ============================================================================
-- Table: geolocation
-- Description: Stores geographical information based on ZIP code
-- ============================================================================

CREATE TABLE raw.geolocation (
    geolocation_zip_code_prefix INTEGER,
    geolocation_lat DECIMAL(10,8),
    geolocation_lng DECIMAL(11,8),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);

-- ============================================================================
-- Table: product_category_translation
-- Description: Maps Portuguese product categories to English
-- ============================================================================

CREATE TABLE raw.product_category_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);