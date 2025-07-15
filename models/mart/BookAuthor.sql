{{ config(materialized = 'table', schema = "MART") }}

select distinct
    {{ dbt_utils.generate_surrogate_key([
        'b.BOOK_ISBN' , 'a.value'
        ]) 
    }} AS BOOKAUTHOR_KEY,
    {{ dbt_utils.generate_surrogate_key(["b.BOOK_ISBN"]) }} as book_key,
    {{ dbt_utils.generate_surrogate_key(["a.value"]) }} as author_key,
from {{ ref("dim_book") }} b, lateral flatten(input => b.authors) a
