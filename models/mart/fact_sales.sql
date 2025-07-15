{{ config(materialized = 'table', schema = "MART") }}

SELECT 
    CAST(CREATED_AT AS DATE) AS "SNAPSHOT_DATE",
      {{ dbt_utils.generate_surrogate_key([
        'STORE_NAME', 'STORE_NUMBER'
    ]) 
}} as STORE_KEY, 
    STORE_NAME,
    {{ dbt_utils.generate_surrogate_key([
    'BOOK_ISBN' ]) 
  }} as BOOK_KEY,
  {{ dbt_utils.generate_surrogate_key([
        'AREA_NUMBER',
    ]) 
  }} as AREA_KEY,
    PRICE,
    QTY_SOLD,
    QTY_REFUNDED,
    (QTY_SOLD * PRICE) - (QTY_REFUNDED*PRICE)  AS "GBP_SALES_AMOUNT",
    CASE WHEN QTY_SOLD > 0 THEN 1 ELSE 0 END AS "IS_SALE"
FROM {{ ref('store_sales_cleaned') }}
WHERE 1=1
AND QTY_SOLD > 0 OR QTY_REFUNDED > 0