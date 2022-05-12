select
    id as company_id,
    name as company_name,
    created_at as created_at_timestamp,
    updated_at as updated_at_timestamp,
    industry,
    monthly_spend,
    session_count,
    user_count,
    website,
    _airbyte_companies_hashid
from {{ var('companies') }}
