with conversations as (

    select
        conversation_id,
        created_at_timestamp,
        updated_at_timestamp,
        conversation_type,
        conversation_title,
        conversation_state,
        is_read

    from {{ ref('stg_intercom__conversations') }}

)

select * from conversations
