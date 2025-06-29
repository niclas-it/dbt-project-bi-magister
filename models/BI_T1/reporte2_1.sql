{{ config(materialized="table") }}

with
    compras_mes as (
        select d.year, d.month, s.customer_id, sum(s.total_sales) as total
        from {{ ref("sales") }} as s
        inner join {{ ref("dates") }} as d on d.date_id = s.date_id
        group by d.year, d.month, s.customer_id
    ),
    top_clientes as (
        select *
        from
            (
                select
                    *, row_number() over (partition by month order by total desc) as rn
                from compras_mes
            )
        where rn = 1
    )
select
    *,
    parse_date(
        '%Y-%m-%d',
        concat(cast(year as string), '-', lpad(cast(month as string), 2, '0'), '-01')
    ) as year_month
from top_clientes
