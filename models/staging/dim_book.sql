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
  }} as BookKey, 
    ISBN, 
    SPLIT(Author, ';') AS Authors,
    Title, 
    Publisher,
    RRP,
    CORE_STOCK_FLAG,
    PUBLICATION_DATE,
    AVAILABILITY,
    {{ dbt_utils.generate_surrogate_key([
        'PRODUCT_GROUP',
        'DEPARTMENT',
        'SUB_DEPARTMENT',
        'CLASS'
    ]) }} AS GenreKey
FROM {{ source('raw', 'store_sales') }} 

