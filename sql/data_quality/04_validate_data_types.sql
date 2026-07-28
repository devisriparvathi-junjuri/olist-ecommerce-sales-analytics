/*
===============================================================================
Project : Olist E-commerce Sales Analytics
File    : 04_validate_data_types.sql
Purpose : Validate data types of all columns
===============================================================================
*/

SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'raw'
ORDER BY table_name, ordinal_position;