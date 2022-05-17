with campaigns as (
    select
        id as campaign_id,
        name as campaign_name,
        objective,
        account_id,
        date(created_time) as created_at_date
    from {{ var('campaigns') }}
)

select * from campaigns

