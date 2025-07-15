-- tests/valid_sale_date_range.sql
SELECT *
FROM {{ ref('store_sales_cleaned') }}
WHERE SNAPSHOT_DATE > CURRENT_DATE
   OR SNAPSHOT_DATE < '2000-01-01'  
