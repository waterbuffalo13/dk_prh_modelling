{{ config(materialized = 'table', schema = "MART") }}

SELECT 
DISTINCT {{ dbt_utils.generate_surrogate_key([
        'STORE_NAME', 'STORE_NUMBER'
    ]) 
}} as STORE_KEY, 
STORE_NUMBER,
STORE_NAME,
{{ dbt_utils.generate_surrogate_key([
        'AREA_NUMBER'
    ]) 
}} as AreaKey
FROM {{ ref('store_sales_cleaned') }}
