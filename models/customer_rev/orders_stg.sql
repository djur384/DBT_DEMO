{{ config(materialized='view') }}

with src as (
  select
    order_id,
    customer_id,
    try_to_date(order_date)   as order_date,
    cast(status as varchar)   as status_cd,
    total_amount              as total_amount
  from {{ source('rawdata','orders') }}
  where order_id is not null
)

select
  order_id,
  customer_id,
  order_date,
  status_cd,
  case
    when status_cd = '01' then 'In Progress'
    when status_cd = '02' then 'Completed'
    when status_cd = '03' then 'Cancelled'
    else null
  end                          as status_desc,
  cast(null as varchar)        as order_channel,
  total_amount,
  current_timestamp()          as dbt_updated_at
from src