{{ config(materialized = 'table', schema = "MART") }}

SELECT 
    CAST(CREATED_AT AS DATE) AS "Snapshot Date",
    STORE_NAME,
    BOOK_NAME,
    PRICE,
    QTY_SOLD,
    QTY_REFUNDED,
    (QTY_SOLD * PRICE) - (QTY_REFUNDED*PRICE)  AS "GBP_SALES_AMOUNT"
FROM {{ ref('store_sales_cleaned') }}
