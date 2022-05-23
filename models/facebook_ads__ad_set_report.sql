with ads as (
    select
        ad_id,
        ad_name,
        adset_id,
        adset_name,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        created_at_date,
        spend,
        clicks,
        impressions
    from {{ ref('stg_facebook_ads_ads') }}
),

adset as (
    select
        ads.created_at_date as date_day,
        ads.adset_id,
        ads.adset_name,
        ads.campaign_id,
        ads.campaign_name,
        ads.account_id,
        ads.account_name,
        sum(ads.spend) as spend,
        sum(ads.clicks) as clicks,
        sum(ads.impressions) as impressions
    from ads
    {{ dbt_utils.group_by(n=7) }}
)

select * from adset