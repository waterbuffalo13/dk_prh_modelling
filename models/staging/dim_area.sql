{{ config(materialized = 'table', schema = "staging") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
        'AREA_NUMBER',
        'AREA_NAME',
        'STORE_NAME'
    ]) 
  }} as AreaID, 
  AREA_NUMBER,
  AREA_NAME,
  STORE_NAME
FROM {{ source('raw', 'store_sales') }}
