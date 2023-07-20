with
   orders as (

        select * from {{ ref('source__orders') }}

    )

    , weekly as (

        select
            date_trunc('week', ordered_at) as order_week
            , type
            , sum(total_amount) as total_spend_usd
            , count(distinct restaurant_id) as total_unique_restaurants

         from orders
         where status not in ('canceled')

         group by all

    )

select * from weekly
