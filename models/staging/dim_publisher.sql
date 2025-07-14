{{ config(materialized = 'table', schema = "staging") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
    'Publisher', 'Imprint'
    ]) 
  }} as PublisherImprintKey, 
    Publisher,
    Imprint 
FROM {{ source('raw', 'store_sales') }} 
ORDER BY Publisher, Imprint