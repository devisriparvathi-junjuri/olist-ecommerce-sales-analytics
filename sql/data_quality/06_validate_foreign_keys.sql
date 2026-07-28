/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 06_validate_foreign_keys.sql
Purpose : Validate Foreign Key Relationships
Author  : Devi Sri Parvathi
===============================================================================
*/

-- ============================================================================
-- Orders -> Customers
-- ============================================================================

SELECT COUNT(*) AS invalid_customer_records
FROM raw.orders o
LEFT JOIN raw.customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- ============================================================================
-- Order Items -> Orders
-- ============================================================================

SELECT COUNT(*) AS invalid_order_records
FROM raw.order_items oi
LEFT JOIN raw.orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- ============================================================================
-- Order Items -> Products
-- ============================================================================

SELECT COUNT(*) AS invalid_product_records
FROM raw.order_items oi
LEFT JOIN raw.products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- ============================================================================
-- Order Items -> Sellers
-- ============================================================================

SELECT COUNT(*) AS invalid_seller_records
FROM raw.order_items oi
LEFT JOIN raw.sellers s
ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

-- ============================================================================
-- Order Payments -> Orders
-- ============================================================================

SELECT COUNT(*) AS invalid_payment_orders
FROM raw.order_payments op
LEFT JOIN raw.orders o
ON op.order_id = o.order_id
WHERE o.order_id IS NULL;

-- ============================================================================
-- Order Reviews -> Orders
-- ============================================================================

SELECT COUNT(*) AS invalid_review_orders
FROM raw.order_reviews r
LEFT JOIN raw.orders o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- ============================================================================
-- Products -> Product Category Translation
-- ============================================================================

SELECT COUNT(*) AS invalid_product_categories
FROM raw.products p
LEFT JOIN raw.product_category_translation pct
ON p.product_category_name = pct.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND pct.product_category_name IS NULL;