/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 06_payment_analysis.sql

Business Questions:
1. Which payment methods are most popular?
2. How much revenue comes from each payment method?
3. What is the average payment value by payment method?
4. Which payment methods are commonly used with installments?
5. What is the average number of installments?

Business Importance:
Payment analysis helps understand customer payment preferences,
revenue distribution, and installment behavior.

Author : Devi Sri Parvathi
===============================================================================
*/


-- ============================================================================
-- 1. Payment Method Usage
-- ============================================================================

SELECT
    payment_type,
    COUNT(*) AS total_transactions
FROM raw.order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;


-- ============================================================================
-- 2. Revenue by Payment Method
-- ============================================================================

SELECT
    payment_type,
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM raw.order_payments
GROUP BY payment_type
ORDER BY total_revenue DESC;


-- ============================================================================
-- 3. Average Payment Value by Payment Method
-- ============================================================================

SELECT
    payment_type,
    ROUND(AVG(payment_value), 2) AS average_payment_value
FROM raw.order_payments
GROUP BY payment_type
ORDER BY average_payment_value DESC;


-- ============================================================================
-- 4. Average Installments by Payment Method
-- ============================================================================

SELECT
    payment_type,
    ROUND(AVG(payment_installments), 2) AS average_installments
FROM raw.order_payments
GROUP BY payment_type
ORDER BY average_installments DESC;


-- ============================================================================
-- 5. Payment Methods with Installments
-- ============================================================================

SELECT
    payment_type,
    COUNT(*) AS installment_transactions
FROM raw.order_payments
WHERE payment_installments > 1
GROUP BY payment_type
ORDER BY installment_transactions DESC;