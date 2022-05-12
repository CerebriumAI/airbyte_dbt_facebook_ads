with companies as (
    select *
    from {{ ref('stg_intercom__companies') }}
),

--Returns the most recent company record by creating a row number ordered by the updated_at_timestamp date, then filtering to only return the #1 row per company.
latest_company as (
 select
     *,
         row_number() over(partition by company_id order by updated_at_timestamp desc) as latest_company_index
 from companies
)

select *
from latest_company
where latest_company_index = 1
