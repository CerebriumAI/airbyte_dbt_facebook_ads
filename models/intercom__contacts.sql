with contacts as (

    select
        contact_id,
        name,
        email,
        phone,
        last_seen_at_timestamp,
        created_at_timestamp
    from {{ ref('stg_intercom__contacts') }}

),

     final_contacts as (

         select
             contacts.contact_id,
             contacts.name,
             contacts.email,
             contacts.phone,
             contacts.last_seen_at_timestamp,
             contacts.created_at_timestamp
         from contacts
     )

select * from final_contacts
