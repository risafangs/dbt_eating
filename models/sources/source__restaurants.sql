with
    source as (

        select * from {{ source('grubhub', 'restaurants') }}

    )

    , renamed_transformed as (

         select
             name
             , type
             , min(restaurant_id) as restaurant_id

         from source
         group by 1, 2

    )

    , final as (

        select distinct
            restaurant_id
            , name
            , type

        from renamed_transformed 

    )

select * from final
