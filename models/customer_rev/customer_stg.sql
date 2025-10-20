{{ config(materialized='view') }}

select
    customer_id,
    initcap(name)                       as customer_name,
    lower(email)                        as email,
    regexp_replace(phone, '[^0-9]', '') as phone,
    initcap(city)                       as city,
    initcap(province)                   as province,
    upper(postal_code)                  as postal_code,
    try_to_date(registration_date)      as registration_date,
    current_timestamp()                 as loaded_at
from {{ source('rawdata', 'customers') }}
