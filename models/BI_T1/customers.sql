{{ config(materialized="table") }}

select 
c.customer_id,
c.customer_name,
c.sex,
c.region,
c.age,
c.nacionality as nationality
from bi_tarea.sales_datamart_with_dimensions_2024_customer_dim as c
