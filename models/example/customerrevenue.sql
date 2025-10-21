{{ config(materialized='table') }}

select
  o.customer_id,
  c.customer_name,
  count(distinct o.order_id) as total_orders,
  sum(oi.total_price)        as total_revenue
from {{ ref('orders_stg') }} o
join {{ ref('orderitems_stg') }} oi on o.order_id = oi.order_id
join {{ ref('customer_stg') }}  c  on o.customer_id = c.customer_id
group by o.customer_id, c.customer_name

