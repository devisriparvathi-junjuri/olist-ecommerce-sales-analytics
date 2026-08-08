/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 07_customer_satisfaction.sql

Business Questions:
1. What is the overall average review score?
2. What percentage of reviews are positive?
3. What percentage of reviews are negative?
4. Which customer states have the lowest average review scores?
5. How do review scores differ between reviews with and without comments?

Business Importance:
Customer satisfaction analysis helps identify service quality,
customer experience issues, and regions requiring improvement.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/


-- ============================================================================
-- 1. Overall Average Review Score
-- ============================================================================

SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM raw.order_reviews;


-- ============================================================================
-- 2. Positive Review Percentage
-- ============================================================================
-- Scores 4 and 5 are considered positive.

SELECT
    ROUND(
        COUNT(*) FILTER (WHERE review_score IN (4, 5)) * 100.0
        / COUNT(*),
        2
    ) AS positive_review_percentage
FROM raw.order_reviews;


-- ============================================================================
-- 3. Negative Review Percentage
-- ============================================================================
-- Scores 1 and 2 are considered negative.

SELECT
    ROUND(
        COUNT(*) FILTER (WHERE review_score IN (1, 2)) * 100.0
        / COUNT(*),
        2
    ) AS negative_review_percentage
FROM raw.order_reviews;


-- ============================================================================
-- 4. Lowest Average Review Score by Customer State
-- ============================================================================

SELECT
    c.customer_state,
    ROUND(AVG(r.review_score), 2) AS average_review_score,
    COUNT(*) AS total_reviews
FROM raw.order_reviews r
JOIN raw.orders o
    ON r.order_id = o.order_id
JOIN raw.customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
HAVING COUNT(*) >= 100
ORDER BY average_review_score ASC
LIMIT 10;


-- ============================================================================
-- 5. Review Score by Comment Availability
-- ============================================================================

SELECT
    CASE
        WHEN review_comment_message IS NULL
            THEN 'No Comment'
        ELSE 'Has Comment'
    END AS comment_status,
    ROUND(AVG(review_score), 2) AS average_review_score,
    COUNT(*) AS total_reviews
FROM raw.order_reviews
GROUP BY comment_status
ORDER BY average_review_score DESC;