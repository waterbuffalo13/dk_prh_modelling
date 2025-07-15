{{ config(materialized = 'table', schema = "MART") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
        'AREA_NUMBER',
    ]) 
  }} as AREA_KEY, 
  AREA_NUMBER,
  AREA_NAME
FROM {{ ref('store_sales_cleaned') }}
ORDER BY AREA_NUMBER
