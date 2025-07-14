{{ config(materialized = 'table', schema = "MART") }}

SELECT 
    CAST(CREATED_AT AS DATE) AS "Snapshot Date",
    STORE_NAME,
    TITLE,
    RRP,
    QTY_SOLD,
    QTY_RETURNED,
    (QTY_SOLD * RRP) - (QTY_RETURNED*RRP)  AS "GBP_SALES_AMOUNT"
FROM {{ source('raw', 'store_sales') }} 
