/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 05_foreign_keys.sql
Purpose : Add Foreign Key constraints
===============================================================================
*/

-- ============================================================================
-- Orders → Customers
-- ============================================================================

ALTER TABLE raw.orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES raw.customers(customer_id);

-- ============================================================================
-- Order Items → Orders
-- ============================================================================

ALTER TABLE raw.order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES raw.orders(order_id);

-- ============================================================================
-- Order Items → Products
-- ============================================================================

ALTER TABLE raw.order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES raw.products(product_id);

-- ============================================================================
-- Order Items → Sellers
-- ============================================================================

ALTER TABLE raw.order_items
ADD CONSTRAINT fk_order_items_sellers
FOREIGN KEY (seller_id)
REFERENCES raw.sellers(seller_id);

-- ============================================================================
-- Order Payments → Orders
-- ============================================================================

ALTER TABLE raw.order_payments
ADD CONSTRAINT fk_order_payments_orders
FOREIGN KEY (order_id)
REFERENCES raw.orders(order_id);

-- ============================================================================
-- Order Reviews → Orders
-- ============================================================================

ALTER TABLE raw.order_reviews
ADD CONSTRAINT fk_order_reviews_orders
FOREIGN KEY (order_id)
REFERENCES raw.orders(order_id);

-- ============================================================================
-- Products → Product Category Translation
-- ============================================================================

ALTER TABLE raw.products
ADD CONSTRAINT fk_products_category_translation
FOREIGN KEY (product_category_name)
REFERENCES raw.product_category_translation(product_category_name);