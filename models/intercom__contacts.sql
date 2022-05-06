with contacts as (

    select
        contact_id,
        name,
        email,
        phone,
        last_seen_at_timestamp,
        created_at_timestamp,
    from {{ ref('stg_intercom_contacts_tmp') }}

),

     companies as (

         select
             contact_id,
             min(created_at_timestamp) as first_conversation_timestamp,
             max(created_at_timestamp) as most_recent_conversation_timestamp
         from {{ ref('stg_intercom_companies_tmp' )}}
         group by 1

     ),

     final_contacts as (

         select
             contacts.contact_id,
             contacts.first_name,
             contacts.last_name,
             contacts.email,
             contacts.phone,
             contacts.total_spent,
             contacts.companies_count,
             contacts.created_at_timestamp,
             contacts.default_address_city,
             contacts.default_address_country,
             companies.first_conversation_timestamp,
             companies.most_recent_conversation_timestamp
         from contacts
                  left join companies using (contact_id)

     )

select * from final_contacts
