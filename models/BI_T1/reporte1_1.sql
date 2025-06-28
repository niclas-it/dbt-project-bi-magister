{{ config(materialized="table") }}

-- Producto más vendido por semana, si hay empate, si muestra tambien.
with
    ventas_semanales as (
        select d.week_date, s.product_id, sum(s.quantity) as qty
        from {{ ref("sales") }} s
        inner join {{ ref("dates") }} d on s.date_id = d.date_id
        group by d.week_date, s.product_id
    ),
    maximos as (
        select week_date, max(qty) as max_qty from ventas_semanales group by week_date
    )

select vs.week_date, vs.product_id, vs.qty
from ventas_semanales vs
join maximos m on vs.week_date = m.week_date and vs.qty = m.max_qty
order by vs.week_date desc
