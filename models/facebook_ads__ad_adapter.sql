/*

base url
url host
url path
utm source
utm meidum
utm campaign
utm content
utm term
*/

with ads as (
    select
        created_at_timestamp as date_day,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        adset_id,
        adset_name,
        ad_id,
        ad_name,
        account_id,
        impressions,
        clicks,
        spend
    from {{ ref('stg_facebook_ads_ads') }}
),