/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 05_sellers_analysis.sql

Business Questions:
1. How many sellers are there?
2. How many seller cities and states are represented?
3. Which states have the most sellers?
4. Which cities have the most sellers?

Business Importance:
Analyzing seller distribution helps understand marketplace
coverage, regional concentration, and expansion opportunities.

Author : Devi Sri Parvathi
===============================================================================
*/

-- ============================================================================
-- 1. Total Sellers
-- ============================================================================

SELECT COUNT(*) AS total_sellers
FROM raw.sellers;


-- ============================================================================
-- 2. Total Seller States
-- ============================================================================

SELECT COUNT(DISTINCT seller_state) AS total_states
FROM raw.sellers;


-- ============================================================================
-- 3. Total Seller Cities
-- ============================================================================

SELECT COUNT(DISTINCT seller_city) AS total_cities
FROM raw.sellers;


-- ============================================================================
-- 4. Top 10 States by Number of Sellers
-- ============================================================================

SELECT
    seller_state,
    COUNT(*) AS total_sellers
FROM raw.sellers
GROUP BY seller_state
ORDER BY total_sellers DESC
LIMIT 10;


-- ============================================================================
-- 5. Top 10 Cities by Number of Sellers
-- ============================================================================

SELECT
    seller_city,
    COUNT(*) AS total_sellers
FROM raw.sellers
GROUP BY seller_city
ORDER BY total_sellers DESC
LIMIT 10;