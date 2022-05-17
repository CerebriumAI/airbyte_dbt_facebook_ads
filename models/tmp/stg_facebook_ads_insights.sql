with ad_insights as (
    select 
        ad_id,
        ad_name,
        adset_id,
        adset_name,
        objective,
        spend,
        clicks,
        impressions,
        account_name,
        campaign_name,
        date(created_time) as created_at_date
    from  {{ var('ads_insights') }}
)

select * from ad_insights