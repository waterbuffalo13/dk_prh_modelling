{{ config(materialized = 'table', schema = "staging") }}

SELECT 
    dbt_utils.generate_surrogate_key([ISBN, Author,Title,RRP, PUBLICATION_DATE]) AS order_key,
    ISBN, 
    Author,
    Title, 
    Publisher,
    RRP,
    CORE_STOCK_FLAG,
    PUBLICATION_DATE
FROM {{ source('raw', 'store_sales') }}
