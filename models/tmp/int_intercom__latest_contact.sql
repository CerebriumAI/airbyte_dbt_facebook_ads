with contacts as (
    select *
    from {{ ref('stg_intercom__contacts') }}
),

--Returns the most recent contact record by creating a row number ordered by the updated_at_timestamp date, then filtering to only return the #1 row per contact.
latest_contact as (
 select
     *,
         row_number() over(partition by contact_id order by updated_at_timestamp desc) as latest_contact_index
 from contacts
)

select *
from latest_contact
where latest_contact_index = 1
