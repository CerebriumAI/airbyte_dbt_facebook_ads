/*
date_day,
account_id,
account_name,
campaign_id,
campaign_name,
clicks,
impressions,
spend
*/

with campaigns as (
    select
        campaign_id,
        campaign_name,
        objective,
        account_id,
        created_at_date
    from {{ ref('stg_facebook_ads_campaigns') }}
),

ads as (
    select
        ad_id,
        ad_name,
        adset_id,
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

final_campaigns as (
    select
        campaigns.created_at_date as date_day,
        campaigns.campaign_id,
        campaigns.campaign_name,
        campaigns.account_id,
        ads.account_name,
        campaigns.objective,
        sum(ads.spend) as spend,
        sum(ads.clicks) as clicks,
        sum(ads.impressions) as impressions
    from campaigns
    left join ads using (campaign_id, created_at_date)
    {{ dbt_utils.group_by(n=6) }}
)

select * from final_campaigns