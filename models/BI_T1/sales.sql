{{ config(materialized="table") }}

select * from bi_tarea.sales_datamart_with_dimensions_2024_sales_fact
