/*
date_day,
account_id,
account_name,
campaign_id,
campaign_name,
adset_id,
adset_name,
clicks,
impressions,
spend
*/

with ads as (
    select
        ad_id,
        ad_name,
        adset_id,
        account_id,
        account_name
        campaign_id,
        campaign_name,
        created_at_timestamp,
        spend,
        clicks,
        impressions
    from {{ ref('stg_facebook_ads_ads') }}
),

adset as (
    select
        ads.created_at_timestamp,
        ads.adset_id,
        ads.adset_name,
        ads.campaign_id,
        ads.campaign_name,
        ads.account_id,
        ads.account_name,
        sum(ads.spend),
        sum(ads.clicks),
        sum(ads.impressions)
    from campaigns
    left join ads using (campaign_id) and (created_at_timestamp)
    {{ dbt_utils.group_by(n=6) }}
)

select * from final_campaigns