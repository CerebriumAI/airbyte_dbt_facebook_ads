with campaigns as (
    select
        id as campaign_id,
        name as campaign_name,
        objective,
        account_id,
        created_time as created_at_timestamp
    from {{ var('campaigns') }}
)

select * from campaigns

