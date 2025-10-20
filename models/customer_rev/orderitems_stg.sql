{{ config(materialized='view') }}

select
    orderitem_id,
    order_id,
    product_name,
    quantity,
    unit_price,
    quantity * unit_price as total_price,
    current_timestamp()   as dbt_updated_at
from {{ source('rawdata', 'orderitems') }}
