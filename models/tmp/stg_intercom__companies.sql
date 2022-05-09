select
    name as company_name,
    created_at as created_at_timestamp,
    updated_at as updated_at_timestamp,
    *
from {{ var('companies') }}
