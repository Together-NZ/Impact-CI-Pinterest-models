{% macro final_calculation() %}
sub_result AS (
    SELECT
        deduplicate_data.* EXCEPT (row_num),
        ad.* EXCEPT (ad_id),
        campaign.* EXCEPT (campaign_id)
    FROM deduplicate_data
    LEFT JOIN ad ON deduplicate_data.ad_id = ad.ad_id
    LEFT JOIN campaign ON deduplicate_data.campaign_id = campaign.campaign_id
),
raw_final AS (
    SELECT
        sub_result.*,
        ad_group.* EXCEPT (ad_group_id)
    FROM sub_result
    LEFT JOIN ad_group ON sub_result.ad_group_id = ad_group.ad_group_id
)
SELECT
    *,
    CASE
        WHEN ARRAY_LENGTH(SPLIT(ad_group_name, '_')) >= 8
            THEN SPLIT(ad_group_name, '_')[OFFSET(7)]
        ELSE NULL
    END AS audience_name,
    CASE
        WHEN ARRAY_LENGTH(SPLIT(creative_name, '_')) < 8 THEN 'Other'
        ELSE SPLIT(creative_name, '_')[OFFSET(5)]
    END AS ad_format_detail,
    CASE
        WHEN ARRAY_LENGTH(SPLIT(creative_name, '_')) < 8 THEN 'Other'
        ELSE SPLIT(creative_name, '_')[OFFSET(6)]
    END AS ad_format,
    SPLIT(creative_name, '_')[OFFSET(ARRAY_LENGTH(SPLIT(creative_name, '_')) - 1)] AS creative_descr,
    CASE
        WHEN ARRAY_LENGTH(SPLIT(campaign_name, '_')) <= 1 THEN 'Other'
        ELSE SPLIT(campaign_name, '_')[OFFSET(1)]
    END AS campaign_descr,
    'Pinterest' AS publisher
FROM raw_final
{% endmacro %}
