{% macro campaigns(source_name, table_name, campaign_name_filter=none) %}
campaign AS (
    SELECT DISTINCT
        JSON_VALUE(data, '$.id') AS campaign_id,
        JSON_VALUE(data, '$.name') AS campaign_name
    FROM {{ source(source_name, table_name) }}
    {% if campaign_name_filter is not none %}
    WHERE LOWER(JSON_VALUE(data, '$.name')) LIKE '%{{ campaign_name_filter | lower }}%'
    {% endif %}
)
{% endmacro %}
