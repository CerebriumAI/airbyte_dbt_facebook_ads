with companies as (

    select
        company_id,
        created_at_timestamp

    from {{ ref('stg_intercom__companies') }}

)

select * from companies
