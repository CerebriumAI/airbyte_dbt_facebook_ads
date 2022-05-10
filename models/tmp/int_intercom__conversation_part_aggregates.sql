with conversation_parts as (
    select *
    from {{ ref('stg_intercom__conversation_parts') }}
),

latest_conversation as (
     select *
     from {{ ref('int_intercom__latest_conversation') }}
 ),

--Aggregates conversation part data related to a single conversation from the int_intercom__latest_conversation model. See below for specific aggregates.
final as (
 select
     latest_conversation.conversation_id,
     latest_conversation.created_at_date as conversation_created_at_date,
     count(conversation_parts.conversation_part_id) as count_total_parts,
     min(case when conversation_parts.part_type = 'comment' and conversation_parts.author_type in ('lead','user') then conversation_parts.created_at_date else null end) as first_contact_reply_at,
     min(case when conversation_parts.part_type like '%assignment%' then conversation_parts.created_at_date else null end) as first_assignment_at,
     min(case when conversation_parts.part_type = 'comment' and conversation_parts.author_type = 'admin' then conversation_parts.created_at_date else null end) as first_admin_response_at,
     min(case when conversation_parts.part_type = 'open' then conversation_parts.created_at_date else null end) as first_reopen_at,
     max(case when conversation_parts.part_type like '%assignment%' then conversation_parts.created_at_date else null end) as last_assignment_at,
     max(case when conversation_parts.part_type = 'comment' and conversation_parts.author_type in ('lead','user') then conversation_parts.created_at_date else null end) as last_contact_reply_at,
     max(case when conversation_parts.part_type = 'comment' and conversation_parts.author_type = 'admin' then conversation_parts.created_at_date else null end) as last_admin_response_at,
     max(case when conversation_parts.part_type = 'open' then conversation_parts.created_at_date else null end) as last_reopen_at,
     sum(case when conversation_parts.part_type like '%assignment%' then 1 else 0 end) as count_assignments,
     sum(case when conversation_parts.part_type = 'open' then 1 else 0 end) as count_reopens
 from latest_conversation

      left join conversation_parts
        on latest_conversation.conversation_id = conversation_parts.conversation_id

 group by 1, 2

)

select *
from final
