{{ config(materialized = 'table', schema = "staging") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
        'PRODUCT_GROUP',
        'DEPARTMENT',
        'SUB_DEPARTMENT',
        'CLASS'
    ]) 
  }} as ProductKey, 
  PRODUCT_GROUP,
  DEPARTMENT,
  SUB_DEPARTMENT,
  CLASS


FROM {{ source('raw', 'store_sales') }}

