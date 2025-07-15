{{ config(materialized = 'table', schema = "MART") }}

SELECT 
  DISTINCT {{ dbt_utils.generate_surrogate_key([
        'f.value'
    ]) 
  }} as Author_Key, 
  f.value::string AS FULL_NAME,
    IFF(
        POSITION(',' IN f.value) > 0,             
        TRIM(SPLIT_PART(f.value, ',', 2)),         
        TRIM(f.value)  
    ) AS FIRST_NAME,
    IFF(
        POSITION(',' IN f.value) > 0,
        SPLIT_PART(TRIM(f.value), ',', 1),
        ''
    ) AS LAST_NAMES
FROM  {{ ref('store_sales_cleaned') }} s,
LATERAL FLATTEN(input=>authors) f


