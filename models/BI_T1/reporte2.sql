{{ config(materialized="table") }}

-- cliente que compra más por mes.
with resumen_mensual as (
    select s.customer_id, count(*) as qty_sales, d.year, d.month, d.month_name
    from {{ ref("sales") }} as s
    inner join {{ ref("dates") }} as d on d.date_id = s.date_id
    group by s.customer_id, d.year, d.month, d.month_name
    order by d.year desc, d.month desc
)

select *, 
PARSE_DATE('%Y-%m-%d', CONCAT(CAST(year AS STRING), '-', LPAD(CAST(month AS STRING), 2, '0'), '-01')) AS year_month 
from resumen_mensual



