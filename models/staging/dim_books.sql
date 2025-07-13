{{ config(materialized = 'table', schema = "staging") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
    'ISBN', 
    'Author',
    'Title', 
    'Publisher',
    'RRP',
    'CORE_STOCK_FLAG',
    'PUBLICATION_DATE'
    ]) 
  }} as primary_key, 
    ISBN, 
    Author,
    Title, 
    Publisher,
    RRP,
    CORE_STOCK_FLAG,
    PUBLICATION_DATE
FROM {{ source('raw', 'store_sales') }}
