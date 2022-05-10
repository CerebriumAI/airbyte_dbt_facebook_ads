with latest_conversation as (
    select *
    from {{ ref('int_intercom__latest_conversation') }}
),

conversations as (

    select
        conversation_id,
        created_at_timestamp,
        updated_at_timestamp,
        created_at_date,
        updated_at_date,
        conversation_type,
        conversation_title,
        conversation_state,
        is_read,
        rating as conversation_rating,
        remark as conversation_remark,
        sla_name,
        sla_status

    from latest_conversation

)

select * from conversations
