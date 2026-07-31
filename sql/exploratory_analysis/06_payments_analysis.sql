/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 06_payments_analysis.sql

Business Questions:
1. What payment methods are used?
2. Which payment method is the most popular?
3. Average payment value?
4. Maximum payment value?
5. Minimum payment value?
6. Average installments?

Business Importance:
Payment analysis helps understand customer payment behavior
and preferred payment options.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

-- ============================================================================
-- 1. Payment Method Distribution
-- ============================================================================

SELECT
    payment_type,
    COUNT(*) AS total_transactions
FROM raw.order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- ============================================================================
-- 2. Average Payment Value
-- ============================================================================

SELECT
    ROUND(AVG(payment_value),2) AS avg_payment
FROM raw.order_payments;


-- ============================================================================
-- 3. Maximum Payment Value
-- ============================================================================

SELECT
    MAX(payment_value) AS highest_payment
FROM raw.order_payments;


-- ============================================================================
-- 4. Minimum Payment Value
-- ============================================================================

SELECT
    MIN(payment_value) AS lowest_payment
FROM raw.order_payments;


-- ============================================================================
-- 5. Average Installments
-- ============================================================================

SELECT
    ROUND(AVG(payment_installments),2) AS avg_installments
FROM raw.order_payments;