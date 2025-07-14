{{ config(materialized = 'table', schema = "MART") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
        'PRODUCT_GROUP',
        'DEPARTMENT',
        'SUB_DEPARTMENT',
        'CLASS'
    ]) 
  }} as Category_Key, 
  PRODUCT_GROUP,
  DEPARTMENT,
  SUB_DEPARTMENT,
  CLASS


FROM {{ ref('store_sales_cleaned') }}

