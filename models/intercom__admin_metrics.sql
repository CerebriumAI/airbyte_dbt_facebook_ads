with conversation_metrics as (
    select *
    from {{ ref('intercom__conversation_metrics') }}
    where assignee_type = 'admin'
),

 admin_table as (
     select *
     from {{ ref('stg_intercom__admins') }}
 ),

--Aggregates admin specific metrics. The admin in question is the one who last closed the conversations.
admin_metrics as (
    select
        last_closed_by_id,
        sum(case when conversation_metrics.conversation_state = 'closed' then 1 else 0 end) as total_conversations_closed,
        avg(conversation_metrics.count_total_parts) as average_conversation_parts,
        avg(conversation_metrics.conversation_rating) as average_conversation_rating
    from conversation_metrics

    group by 1
),

--Generates the median values for admins who last closed conversations.
median_metrics as (
    select
        last_closed_by_id,
        {{ fivetran_utils.percentile("conversation_metrics.count_reopens", "last_closed_by_id", "0.5") }} as median_conversations_reopened,
        {{ fivetran_utils.percentile("conversation_metrics.count_assignments", "last_closed_by_id", "0.5") }} as median_conversation_assignments,
        {{ fivetran_utils.percentile("conversation_metrics.time_to_first_response_minutes", "last_closed_by_id", "0.5") }} as median_time_to_first_response_time_minutes
    from conversation_metrics

    group by 1
),

--Joins the aggregate, and median CTEs to the admin table with team enrichment. Distinct is necessary to keep grain with median values and aggregates.
final as (
    select distinct
    admin_table.admin_id,
    admin_table.name as admin_name,

    admin_table.job_title,
    admin_metrics.total_conversations_closed,
    admin_metrics.average_conversation_parts,
    admin_metrics.average_conversation_rating,
    median_metrics.median_conversations_reopened,
    median_metrics.median_conversation_assignments
from admin_table

left join admin_metrics
    on admin_metrics.last_closed_by_id = admin_table.admin_id

left join median_metrics
    on median_metrics.last_closed_by_id = admin_table.admin_id
)

select * from final
