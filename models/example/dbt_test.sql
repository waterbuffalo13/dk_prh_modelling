{{ config(materialized = 'table') }}

SELECT * 
FROM PRH_COMMERCIAL_SALES.RAW.STORE_SALES

 --full-refresh