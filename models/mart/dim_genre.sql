{{ config(materialized = 'table', schema = "MART") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
        'PRODUCT_GROUP',
        'DEPARTMENT',
        'SUB_DEPARTMENT',
        'CLASS'
    ]) 
  }} as GenreKey, 
  PRODUCT_GROUP,
  DEPARTMENT,
  SUB_DEPARTMENT,
  CLASS


FROM {{ source('raw', 'store_sales') }}

