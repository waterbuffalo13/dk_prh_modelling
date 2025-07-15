SELECT *
FROM {{ ref('store_sales_cleaned') }}
WHERE PRICE = 0