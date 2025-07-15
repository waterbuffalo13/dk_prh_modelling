SELECT *
FROM {{ ref('store_sales_cleaned') }}
WHERE 1=1 
AND price < 0 