/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 02_customer_analysis.sql

Business Questions:
1. How many unique customers are there?
2. How many cities do customers belong to?
3. How many states are represented?
4. Which states have the most customers?
5. Which cities have the most customers?

Business Importance:
Understanding customer distribution helps businesses identify
their strongest markets and plan regional expansion.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

-- ============================================================================
-- 1. Total Customers
-- ============================================================================

SELECT COUNT(*) AS total_customers
FROM raw.customers;


-- ============================================================================
-- 2. Unique Customers
-- ============================================================================

SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM raw.customers;


-- ============================================================================
-- 3. Total Cities
-- ============================================================================

SELECT COUNT(DISTINCT customer_city) AS total_cities
FROM raw.customers;


-- ============================================================================
-- 4. Total States
-- ============================================================================

SELECT COUNT(DISTINCT customer_state) AS total_states
FROM raw.customers;


-- ============================================================================
-- 5. Top 10 States by Customer Count
-- ============================================================================

SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM raw.customers
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 10;


-- ============================================================================
-- 6. Top 10 Cities by Customer Count
-- ============================================================================

SELECT
    customer_city,
    COUNT(*) AS total_customers
FROM raw.customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;