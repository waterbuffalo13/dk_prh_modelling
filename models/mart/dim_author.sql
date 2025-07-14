{{ config(materialized = 'table', schema = "MART") }}

WITH AUTHORSCTE AS (
    SELECT SPLIT(TRIM(AUTHOR), ';') AS authors_array
    FROM {{ source('raw', 'store_sales') }}
)

SELECT 
    DISTINCT {{ dbt_utils.generate_surrogate_key([
        'f.value'
        ]) 
    }} as AuthorKey,
  TRIM(f.value) AS author_name,
  SPLIT_PART(TRIM(f.value), ',', 1) AS last_name,
  SPLIT_PART(TRIM(f.value), ',', 2) AS first_name

FROM AUTHORSCTE a,
LATERAL FLATTEN(input => a.authors_array) f
ORDER BY author_name ASC


