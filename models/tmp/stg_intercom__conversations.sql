select
    id as conversation_id,
    created_at as created_at_timestamp,
    *
from {{ var('conversations') }}
