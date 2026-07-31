/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 08_geolocation_analysis.sql

Business Questions:
1. Total geolocation records?
2. Total states?
3. Total cities?
4. Top 10 states by records?
5. Top 10 cities by records?

Business Importance:
Geolocation analysis helps understand customer and seller
geographic distribution.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

-- ============================================================================
-- 1. Total Geolocation Records
-- ============================================================================

SELECT COUNT(*) AS total_records
FROM raw.geolocation;


-- ============================================================================
-- 2. Total States
-- ============================================================================

SELECT COUNT(DISTINCT geolocation_state) AS total_states
FROM raw.geolocation;


-- ============================================================================
-- 3. Total Cities
-- ============================================================================

SELECT COUNT(DISTINCT geolocation_city) AS total_cities
FROM raw.geolocation;


-- ============================================================================
-- 4. Top 10 States
-- ============================================================================

SELECT
    geolocation_state,
    COUNT(*) AS total_records
FROM raw.geolocation
GROUP BY geolocation_state
ORDER BY total_records DESC
LIMIT 10;


-- ============================================================================
-- 5. Top 10 Cities
-- ============================================================================

SELECT
    geolocation_city,
    COUNT(*) AS total_records
FROM raw.geolocation
GROUP BY geolocation_city
ORDER BY total_records DESC
LIMIT 10;