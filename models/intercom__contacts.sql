select
    contact_id,
    name,
    email,
    phone,
    last_seen_at_timestamp,
    created_at_timestamp
from {{ ref('int_intercom__latest_contact') }}
