{{ config(materialized = 'table', schema = "MART") }}

SELECT 
    CAST(CREATED_AT AS DATE) AS "Snapshot Date",
    STORE_NAME,
    BOOK_ISBN,
    BOOK_NAME,
    {{ dbt_utils.generate_surrogate_key(['BOOK_ISBN']) }} as BOOK_KEY,
  {{ dbt_utils.generate_surrogate_key([
        'AREA_NUMBER'
    ]) 
  }} as AREA_KEY,
    PRICE,
    AVAILABLE_STOCK,
    ORDERS_REQUESTED,
    ORDERS_RECIEVED
FROM {{ ref('store_sales_cleaned') }}
