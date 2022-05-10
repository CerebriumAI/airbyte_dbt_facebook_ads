select
    id as conversation_id,
    created_at as created_at_timestamp,
    updated_at as updated_at_timestamp,
    {{ dbt_date.from_unixtimestamp('created_at') }} as created_at_date,
    {{ dbt_date.from_unixtimestamp('updated_at') }} as updated_at_date,
    type as conversation_type,
    title as conversation_title,
    state as conversation_state,
    read as is_read,
    {{ fivetran_utils.json_parse(string="conversation_rating", string_path=["rating"]) }} as rating,
    {{ fivetran_utils.json_parse(string="conversation_rating", string_path=["remark"]) }} as remark,
    {{ fivetran_utils.json_parse(string="sla_applied", string_path=["sla_name"]) }} as sla_name,
    {{ fivetran_utils.json_parse(string="sla_applied", string_path=["sla_status"]) }} as sla_status,
    *
from {{ var('conversations') }}
