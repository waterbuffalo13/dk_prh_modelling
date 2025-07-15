{{ config(materialized = 'table', schema = "MART") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
    'BOOK_ISBN' ]) 
  }} as BOOK_KEY, 
    BOOK_ISBN,  
    PUBLISHER_NAME,
    AUTHORS,
    {{ dbt_utils.generate_surrogate_key([
        'PRODUCT_GROUP',
        'DEPARTMENT',
        'SUB_DEPARTMENT',
        'CLASS'
    ]) 
  }} as Category_Key, 
    BOOK_NAME,
    
    PRICE,
    CORE_STOCK_FLAG,
    PUBLICATION_DATE,
    AVAILABILITY,
    {{ dbt_utils.generate_surrogate_key([
        'PRODUCT_GROUP',
        'DEPARTMENT',
        'SUB_DEPARTMENT',
        'CLASS'
    ]) }} AS CategoryKey
FROM {{ ref('store_sales_cleaned') }}

