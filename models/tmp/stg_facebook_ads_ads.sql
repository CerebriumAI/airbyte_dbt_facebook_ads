with ads as (
    select
        id as ad_id,
        name as ad_name,
        adset_id,
        account_id,
        campaign_id,
        date(created_time) as created_at_date,
        _airbyte_ads_hashid
    from {{ var('ads') }}
),

creatives as (
    select
        id as creative_id,
        _airbyte_ads_hashid
    from {{ var('ads_creative') }}
),

ad_creatives as (
    select
        id as creative_id,
        name as creative_name
    from {{ var('ad_creatives') }}
),

ad_insights as (
    select *
    from  {{ ref('stg_facebook_ads_insights') }}
),

final_ads as (
    select
        ads.ad_id,
        ads.ad_name,
        ads.adset_id,
        ad_insights.adset_name,
        ads.account_id,
        ad_insights.account_name,
        ads.campaign_id,
        ad_insights.campaign_name,
        ad_creatives.creative_id,
        ad_creatives.creative_name,
        ads.created_at_date,
        ad_insights.spend,
        ad_insights.clicks,
        ad_insights.impressions
    from ads
    left join ad_insights using(ad_id)
    left join creatives using (_airbyte_ads_hashid)
    left join ad_creatives using (creative_id)
)

select * from final_ads
