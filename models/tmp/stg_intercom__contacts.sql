select
    id as contact_id,
    created_at as created_at_timestamp,
    updated_at as updated_at_timestamp,
    last_seen_at as last_seen_at_timestamp,
    *
from {{ var('contacts') }}
