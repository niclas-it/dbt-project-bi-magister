{{ config(materialized="table") }}

-- cantidad y total por producto por semana

select d.week_date, s.product_id, sum(s.quantity) as qty, sum(s.total_sales) as total
from {{ ref("sales") }} s
inner join {{ ref("dates") }} d on (s.date_id = d.date_id)
group by d.week_date, s.product_id
order by d.week_date desc, qty desc
