{{ config(materialized='view') }}

with src as (
  select
    order_id,
    customer_id,
    try_to_date(order_date) as order_date,
    cast(status as varchar) as status_raw,
    total_amount
  from {{ source('rawdata','orders') }}
  where order_id is not null
)
select
  order_id,
  customer_id,
  order_date,
  upper(status_raw)   as status_cd,       -- e.g., 'COMPLETED'
  initcap(status_raw) as status_desc,     -- e.g., 'Completed'
  cast(null as varchar) as order_channel,
  total_amount,
  current_timestamp() as dbt_updated_at
from src
