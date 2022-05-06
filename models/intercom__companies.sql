with companies as (

    select
        company_id,
        created_at_timestamp

    from {{ ref('stg_intercom_companies_tmp') }}

)

select * from companies
