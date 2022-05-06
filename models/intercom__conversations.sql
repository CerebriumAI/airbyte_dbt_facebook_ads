with conversations as (

    select
        conversation_id,
        created_at_timestamp

    from {{ ref('stg_intercom__conversations') }}

)

select * from conversations
