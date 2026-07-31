/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 07_reviews_analysis.sql

Business Questions:
1. Average review score?
2. Review score distribution?
3. How many reviews contain comments?
4. How many reviews have no comments?

Business Importance:
Customer reviews help measure customer satisfaction and
identify service quality trends.

Author : Devi Sri Parvathi Junjuri
===============================================================================
*/

-- ============================================================================
-- 1. Average Review Score
-- ============================================================================

SELECT
    ROUND(AVG(review_score),2) AS average_review_score
FROM raw.order_reviews;


-- ============================================================================
-- 2. Review Score Distribution
-- ============================================================================

SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM raw.order_reviews
GROUP BY review_score
ORDER BY review_score;


-- ============================================================================
-- 3. Reviews With Comments
-- ============================================================================

SELECT
    COUNT(*) AS reviews_with_comments
FROM raw.order_reviews
WHERE review_comment_message IS NOT NULL;


-- ============================================================================
-- 4. Reviews Without Comments
-- ============================================================================

SELECT
    COUNT(*) AS reviews_without_comments
FROM raw.order_reviews
WHERE review_comment_message IS NULL;