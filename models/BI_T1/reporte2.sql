{{ config(materialized="table") }}

select c.customer_id, c.customer_name, d.quarter, d.year, sum(s.total_sales) as total_vendido
from {{ ref("sales") }} s
inner join {{ ref("customers") }} c on (s.customer_id = c.customer_id)
inner join {{ ref("dates") }} d on (s.date_id = d.date_id)
group by c.customer_id, c.customer_name, d.quarter, d.year
order by c.customer_id, d.quarter, d.year desc



