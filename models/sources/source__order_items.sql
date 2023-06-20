with
    source as (

         select * from {{ source('grubhub', 'order_items') }}

     )

     , renamed_transformed as (

        select 
            order_id
            , quantity
            , item_name
            , regexp_replace(price, '$', '')::number as price

        from source

        )

/* skipping reorder, not necessary */
select * from renamed_transformed            
