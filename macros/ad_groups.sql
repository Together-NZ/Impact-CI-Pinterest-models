{% macro ad_groups(source_name, table_name) %}
ad_group AS (
    SELECT DISTINCT
        JSON_VALUE(data, '$.id') AS ad_group_id,
        JSON_VALUE(data, '$.name') AS ad_group_name
    FROM {{ source(source_name, table_name) }}
)
{% endmacro %}
