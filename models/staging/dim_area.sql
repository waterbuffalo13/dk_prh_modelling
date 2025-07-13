{{ config(materialized = 'table', schema = "staging") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
        'AREA_NUMBER',
    ]) 
  }} as AreaKey, 
  AREA_NUMBER,
  AREA_NAME
FROM {{ source('raw', 'store_sales') }}
ORDER BY AREA_NUMBER
