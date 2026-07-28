/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 07_data_quality_summary.sql
Purpose : Summarize Data Quality Validation Results
Author  : Devi Sri Parvathi
===============================================================================
*/

SELECT
    'Row Count Validation' AS validation_type,
    'Completed' AS status

UNION ALL

SELECT
    'NULL Value Validation',
    'Completed'

UNION ALL

SELECT
    'Duplicate Record Validation',
    'Completed'

UNION ALL

SELECT
    'Data Type Validation',
    'Completed'

UNION ALL

SELECT
    'Primary Key Validation',
    'Completed'

UNION ALL

SELECT
    'Foreign Key Validation',
    'Completed';