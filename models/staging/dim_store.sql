-- {{ config(materialized = 'table', schema = "staging") }}


SELECT 
DISTINCT {{ dbt_utils.generate_surrogate_key([
        'STORE_NAME',
        'STORE_NUMBER'
    ]) 
}} as StoreKey, 
STORE_NUMBER,
STORE_NAME,
{{ dbt_utils.generate_surrogate_key([
        'AREA_NUMBER'
    ]) 
}} as AreaKey
FROM {{ source('raw', 'store_sales') }} 
