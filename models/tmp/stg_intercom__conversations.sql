select
    id as conversation_id,
    created_at as created_at_timestamp,
    updated_at as updated_at_timestamp,
    type as conversation_type,
    title as conversation_title,
    state as conversation_state,
    read as is_read,
    *
from {{ var('conversations') }}
