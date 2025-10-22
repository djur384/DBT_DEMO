WITH BIKE as (

select
distinct
start_station_id AS station_id,
start_station_name AS station_name,
start_lat AS station_lat,
start_lng AS start_station_lng


from {{ ref('stg_bike') }}

where RIDE_ID != '"bikeid"'


)

select 
*
from BIKE