with cte as (
  select
    to_timestamp(started_at) as started_at,
    date(started_at) as date_started_at,
    hour(to_timestamp(started_at)) as hour_started_at,
    case
      when dayname(to_timestamp(started_at)) in ('Sat', 'Sun') then 'WEEKEND'
      else 'BUSINESS DAY' 
    end as date_type,

    case 
      when month(to_timestamp(started_at)) in ('12', '1', '2') then 'WINTER'
      when month(to_timestamp(started_at)) in ('3', '4', '5') then 'SPRING'
      when month(to_timestamp(started_at)) in ('6', '7', '8') then 'SUMMER'
      else 'AUTUMN'
    end as station_of_year
  
  from {{ source('demo', 'bike')}}
  where started_at <> 'started_at'
)

select 
  *
from
  cte