select
    id as plan_id,
    name as plan_name,
    *
from {{ var('companies_plan') }}
