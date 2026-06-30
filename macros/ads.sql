{% macro ads(source_name, table_name) %}
ad AS (
    SELECT DISTINCT
        JSON_VALUE(data, '$.id') AS ad_id,
        JSON_VALUE(data, '$.name') AS creative_name,
        JSON_VALUE(data, '$.ad_group_id') AS ad_group_id
    FROM {{ source(source_name, table_name) }}
)
{% endmacro %}
