/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 01_validate_row_counts.sql
Purpose : Validate imported row counts across all tables
Author  : Devi Sri Parvathi
===============================================================================
*/

SELECT 'customers' AS table_name, COUNT(*) AS total_rows
FROM raw.customers

UNION ALL

SELECT 'orders', COUNT(*)
FROM raw.orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM raw.order_items

UNION ALL

SELECT 'products', COUNT(*)
FROM raw.products

UNION ALL

SELECT 'sellers', COUNT(*)
FROM raw.sellers

UNION ALL

SELECT 'order_payments', COUNT(*)
FROM raw.order_payments

UNION ALL

SELECT 'order_reviews', COUNT(*)
FROM raw.order_reviews

UNION ALL

SELECT 'geolocation', COUNT(*)
FROM raw.geolocation

UNION ALL

SELECT 'product_category_translation', COUNT(*)
FROM raw.product_category_translation

ORDER BY table_name;