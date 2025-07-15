{{ config(materialized = 'view', schema = "MART") }}

SELECT s.SNAPSHOT_DATE , a.area_number, a.area_name, b.BOOK_KEY, c.Category_Key, c.PRODUCT_GROUP, b.BOOK_NAME,COUNT(s.qty_sold) AS "PRODUCTS_SOLD", SUM(GBP_SALES_AMOUNT) AS "TOTAL_SALES"
FROM  {{ ref('dim_book') }} b  
JOIN {{ ref('dim_category') }} c ON b.category_key = c.category_key
JOIN {{ ref('fact_sales') }} s ON b.book_key = s.book_key
JOIN {{ ref('dim_area') }} a ON a.area_key = s.area_key
WHERE s.IS_SALE = 1
GROUP BY s.SNAPSHOT_DATE ,a.area_number, a.area_name, b.BOOK_KEY, c.Category_Key,c.PRODUCT_GROUP, b.BOOK_NAME
ORDER BY a.area_number, TOTAL_SALES DESC