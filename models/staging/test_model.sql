{{ config(materialized = 'table', schema = "test") }}

SELECT * FROM {{ source('raw', 'store_sales') }}