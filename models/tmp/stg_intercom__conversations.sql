select
    id as conversation_id,
    created_at as created_at_timestamp,
    updated_at as updated_at_timestamp,
    *
from {{ var('conversations') }}
