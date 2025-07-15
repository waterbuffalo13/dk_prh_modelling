SELECT *
FROM {{ ref('store_sales_cleaned') }}
WHERE 1=1 
AND qty_sold < 0 OR price < 0 