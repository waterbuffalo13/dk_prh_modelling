SELECT 
    {{ dbt_utils.generate_surrogate_key([
        'BOOK_ISBN' ]) 
    }}, 