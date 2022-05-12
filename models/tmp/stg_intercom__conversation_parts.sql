select
    id as conversation_part_id,
    created_at as created_at_timestamp,
    updated_at as updated_at_timestamp,
    {{ dbt_date.from_unixtimestamp('created_at') }} as created_at_date,
    {{ dbt_date.from_unixtimestamp('updated_at') }} as updated_at_date,
    {{ fivetran_utils.json_parse(string="author", string_path=["id"]) }} as author_id,
    {{ fivetran_utils.json_parse(string="author", string_path=["type"]) }} as author_type,
    *
from {{ var('conversation_parts') }}
