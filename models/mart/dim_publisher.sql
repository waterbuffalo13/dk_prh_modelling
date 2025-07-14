{{ config(materialized = 'table', schema = "MART") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
    'PUBLISHER_NAME', 'PUBLISHER_IMPRINT'
    ]) 
  }} as PUBLISHER_KEY, 
    PUBLISHER_NAME,
    PUBLISHER_IMPRINT
FROM {{ ref('store_sales_cleaned') }}
ORDER BY PUBLISHER_NAME,
    PUBLISHER_IMPRINT 