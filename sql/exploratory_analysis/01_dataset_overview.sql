/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 01_dataset_overview.sql

Business Question:
What is the overall size of each dataset?

Business Importance:
Provides a quick overview of the dataset before performing
detailed business analysis.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

SELECT 'Customers' AS table_name, COUNT(*) AS total_records
FROM raw.customers

UNION ALL

SELECT 'Orders', COUNT(*)
FROM raw.orders

UNION ALL

SELECT 'Products', COUNT(*)
FROM raw.products

UNION ALL

SELECT 'Sellers', COUNT(*)
FROM raw.sellers

UNION ALL

SELECT 'Order Items', COUNT(*)
FROM raw.order_items

UNION ALL

SELECT 'Payments', COUNT(*)
FROM raw.order_payments

UNION ALL

SELECT 'Reviews', COUNT(*)
FROM raw.order_reviews

UNION ALL

SELECT 'Geolocation', COUNT(*)
FROM raw.geolocation

UNION ALL

SELECT 'Product Categories', COUNT(*)
FROM raw.product_category_translation

ORDER BY total_records DESC;