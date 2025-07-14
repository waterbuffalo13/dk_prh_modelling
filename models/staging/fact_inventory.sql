{{ config(materialized = 'table', schema = "staging") }}

SELECT 
    CAST(CREATED_AT AS DATE) AS "Snapshot Date",
    STORE_NAME,
    ISBN,
    TITLE,
    RRP,
    QTY_ON_HAND AS "STOCK_COUNT",
    QTY_ON_ORDER AS "ORDERS_REQUESTED",
    QTY_RECEIVED AS "ORDERS_COMPLETED"
FROM {{ source('raw', 'store_sales') }} 
