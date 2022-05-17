with ads as (
    select
        id as ad_id,
        name as ad_name,
        adset_id,
        account_id,
        campaign_id,
        created_time as created_at_timestamp,
        _airbyte_ads_hashid
    from {{ var('ads') }}
),

creatives as (
    select
        id as creative_id,
        _airbyte_ads_hashid
    from {{ var('ad_creative') }}
),

ad_creatives as (
    select
        id as creative_id,
        name
    from {{ var('ad_creatives') }}
),

ads as (
    select
        ads.ad_id,
        ads.ad_name,
        ads.adset_id,
        ads.account_id,
        ad_insights.account_name
        ads.campaign_id,
        ad_insights.campaign_name,
        ads.created_at_timestamp,
        ad_insights.spend,
        ad_insights.clicks,
        ad_insights.impressions
    from ads
    left join {{ ref('stg_facebook_ads_ads_insights') }} ad_insights using(_airbyte_ads_hashid)
    left join creatives using (_airbyte_ads_hashid)
    left join ad_creatives using (creative_id)
),
