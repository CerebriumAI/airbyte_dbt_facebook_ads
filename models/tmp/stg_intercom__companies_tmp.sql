select
    id as company_id,
    created_at as created_at_timestamp,
    *
from {{ var('companies') }}
