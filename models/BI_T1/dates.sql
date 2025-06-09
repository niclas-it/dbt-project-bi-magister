{{ config(materialized="table") }}

SELECT
  *,
  DATE_TRUNC(date_id, WEEK) AS week_date
FROM bi_tarea.sales_datamart_with_dimensions_2024_date_dim
