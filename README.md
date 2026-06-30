# Impact-CI-pinterest_models

dbt package for Pinterest Ads transforms. Used by client projects via `packages.yml`.

### Usage

```sql
WITH
{{ pinterest.reports(source_name='pinterest_raw', table_name='reports') }},
{{ pinterest.ad_groups(source_name='pinterest_raw', table_name='ad_groups') }},
{{ pinterest.campaigns(source_name='pinterest_raw', table_name='campaigns') }},
{{ pinterest.ads(source_name='pinterest_raw', table_name='ads') }},
{{ pinterest.final_calculation() }}
```

Optional campaign filter (e.g. colorsteel):

```sql
{{ pinterest.campaigns(source_name='pinterest_raw', table_name='campaigns', campaign_name_filter='colorsteel') }}
```
