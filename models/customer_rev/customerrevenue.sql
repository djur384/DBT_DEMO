{{ config(materialized='table') }}

SELECT
    os.customer_id,
    c.customer_name,
    SUM(os.order_count) AS total_orders,
    SUM(os.revenue)     AS total_revenue
FROM {{ ref('orders_fact') }} os
JOIN {{ ref('customer_stg') }} c
  ON os.customer_id = c.customer_id
GROUP BY
    os.customer_id,
    c.customer_name
