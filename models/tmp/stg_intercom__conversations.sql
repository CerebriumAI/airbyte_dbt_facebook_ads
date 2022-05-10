with conversation_rating as (
    select
        rating,
        remark,
        _airbyte_conversations_hashid
    from {{ var('conversations_conversation_rating') }}
),

conversations_sla_applied as (
    select
        sla_name,
        sla_status,
        _airbyte_conversations_hashid
    from {{ var('conversations_sla_applied') }}
),

conversations_assignee as (
    select
        id as assignee_id,
        name as assignee_name,
        type as assignee_type,
        email as assignee_email,
        _airbyte_conversations_hashid
    from {{ var('conversations_assignee') }}
),

conversations_statistics as (
    select
        last_closed_by_id,
        _airbyte_conversations_hashid
    from {{ var('conversations_statistics') }}
),

conversations as (
    select
        id as conversation_id,
        created_at as created_at_timestamp,
        updated_at as updated_at_timestamp,
        {{ dbt_date.from_unixtimestamp('created_at') }} as created_at_date,
        {{ dbt_date.from_unixtimestamp('updated_at') }} as updated_at_date,
        type as conversation_type,
        title as conversation_title,
        state as conversation_state,
        read as is_read,
        *
    from {{ var('conversations') }}
),

final as (
    select
        conversations.*,
        conversation_rating.rating as conversation_rating_value,
        conversation_rating.remark as conversation_remark,
        conversations_sla_applied.sla_name,
        conversations_sla_applied.sla_status,
        conversations_assignee.assignee_id,
        conversations_assignee.assignee_name,
        conversations_assignee.assignee_type,
        conversations_assignee.assignee_email,
        conversations_statistics.last_closed_by_id
    from conversations

        left join conversation_rating using (_airbyte_conversations_hashid)
        left join conversations_assignee using (_airbyte_conversations_hashid)
        left join conversations_sla_applied using (_airbyte_conversations_hashid)
        left join conversations_statistics using (_airbyte_conversations_hashid)
)

select * from final
