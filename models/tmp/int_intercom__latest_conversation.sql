with conversations as (
    select *
    from {{ ref('stg_intercom__conversations') }}
),

--Returns the most recent conversation record by creating a row number ordered by the conversation_updated_at date, then filtering to only return the #1 row per conversation.
latest_conversation as (
 select
     *,
     row_number() over(partition by conversation_id order by updated_at desc) as latest_conversation_index
 from conversations
)

select *
from latest_conversation
where latest_conversation_index = 1
