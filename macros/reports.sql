{% macro reports(source_name, table_name) %}
data AS (
    SELECT
        JSON_VALUE(data, '$.AD_ID') AS ad_id,
        JSON_VALUE(data, '$.CAMPAIGN_ID') AS campaign_id,
        JSON_VALUE(data, '$.DATE') AS date,
        SAFE_CAST(JSON_VALUE(data, '$.IMPRESSION_1') AS INT64) AS impressions,
        SAFE_CAST(JSON_VALUE(data, '$.OUTBOUND_CLICK_1') AS INT64) AS clicks,
        SAFE_CAST(JSON_VALUE(data, '$.SPEND_IN_DOLLAR') AS FLOAT64) AS media_cost,
        SAFE_CAST(JSON_VALUE(data, '$.TOTAL_VIDEO_P100_COMPLETE') AS INT64) AS video_completion,
        SAFE_CAST(JSON_VALUE(data, '$.TOTAL_VIDEO_P25_COMBINED') AS INT64) AS video_25_completion,
        SAFE_CAST(JSON_VALUE(data, '$.TOTAL_VIDEO_P50_COMBINED') AS INT64) AS video_50_completion,
        SAFE_CAST(JSON_VALUE(data, '$.TOTAL_VIDEO_P75_COMBINED') AS INT64) AS video_75_completion,
        SAFE_CAST(JSON_VALUE(data, '$.TOTAL_VIDEO_MRC_VIEWS') AS INT64) AS video_views,
        ROW_NUMBER() OVER (
            PARTITION BY JSON_VALUE(data, '$.AD_ID'), JSON_VALUE(data, '$.DATE')
            ORDER BY _sdc_extracted_at DESC
        ) AS row_num
    FROM {{ source(source_name, table_name) }}
),
deduplicate_data AS (
    SELECT * FROM data WHERE row_num = 1
)
{% endmacro %}
