with  ad_insights as (
    select 
        ad_id,
        ad_name,
        adset_id,
        objective,
        spend,
        clicks,
        impressions,
        account_name,
        campaign_name,
        created_time as created_at_timestamp,
        _airbyte_ads_insights_hashid
    from  {{ var('ad_insights') }}
)

