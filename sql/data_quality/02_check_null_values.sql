/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 02_check_null_values.sql
Purpose : Check NULL values in all tables
Author  : Devi Sri Parvathi
===============================================================================
*/

-- ============================================================================
-- Customers
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