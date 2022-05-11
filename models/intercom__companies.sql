with companies_plan as (

    select distinct
        _airbyte_companies_hashid,
        plan_id,
        plan_name
    from {{ ref('stg_intercom__companies_plan' )}}
        group by _airbyte_companies_hashid, plan_id, plan_name

),

companies as (

    select
        company_id,
        company_name,
        created_at_timestamp,
        industry,
        monthly_spend,
        companies_plan.plan_id,
        companies_plan.plan_name,
        session_count,
        updated_at_timestamp,
        user_count,
        website

    from {{ ref('int_intercom__latest_company') }}
        left join companies_plan using (_airbyte_companies_hashid)

)

select * from companies
