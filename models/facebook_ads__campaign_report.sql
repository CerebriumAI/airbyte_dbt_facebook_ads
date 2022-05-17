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
        id as campaign_id,
        name as campaign_name,
        objective,
        account_id,
        created_time as created_at_timestamp
    from {{ ref('stg_facebook_ads_campaigns') }}
),

ads as (
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

final_campaigns as (
    select
        campaigns.created_at_timestamp,
        campaigns.campaign_id,
        campaigns.campaign_name,
        campaigns.account_id,
        ads.account_name,
        campaigns.objective,
        sum(ads.spend),
        sum(ads.clicks),
        sum(ads.impressions)
    from campaigns
    left join ads using (campaign_id) and (created_at_timestamp)
    {{ dbt_utils.group_by(n=6) }}
)

select * from final_campaigns