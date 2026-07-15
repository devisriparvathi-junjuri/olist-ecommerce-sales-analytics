/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 04_primary_keys.sql
Purpose : Add Primary Key constraints to all tables
===============================================================================
*/

-- ============================================================================
-- Customers
-- ============================================================================

ALTER TABLE raw.customers
ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);

-- ============================================================================
-- Orders
-- ============================================================================

ALTER TABLE raw.orders
ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);

-- ============================================================================
-- Products
-- ============================================================================

ALTER TABLE raw.products
ADD CONSTRAINT pk_products PRIMARY KEY (product_id);

-- ============================================================================
-- Sellers
-- ============================================================================

ALTER TABLE raw.sellers
ADD CONSTRAINT pk_sellers PRIMARY KEY (seller_id);

-- ============================================================================
-- Order Items (Composite Primary Key)
-- ============================================================================

ALTER TABLE raw.order_items
ADD CONSTRAINT pk_order_items
PRIMARY KEY (order_id, order_item_id);

-- ============================================================================
-- Order Payments (Composite Primary Key)
-- ============================================================================

ALTER TABLE raw.order_payments
ADD CONSTRAINT pk_order_payments
PRIMARY KEY (order_id, payment_sequential);

-- ============================================================================
-- Order Reviews
-- ============================================================================

ALTER TABLE raw.order_reviews
ADD CONSTRAINT pk_order_reviews PRIMARY KEY (review_id);

-- ============================================================================
-- Product Category Translation
-- ============================================================================

ALTER TABLE raw.product_category_translation
ADD CONSTRAINT pk_product_category_translation
PRIMARY KEY (product_category_name);