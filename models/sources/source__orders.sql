with
    source as (

        select * from {{ source('grubhub', 'orders') }}

    )

    , renamed_transformed as (

        select
            order_id
            , to_date(ordered_at, 'MMM DD, YYYY H:MM') as ordered_at
            , type
            , total_amount
            , sub_total
            , status
            , restaurant_id
  
        from source

     )

     , reordered as (

         select
             order_id
             , restaurant_id
             , ordered_at
             , type
             , total_amount
             , sub_total
             , status

          from renamed_transformed

     )

select * from reordered
