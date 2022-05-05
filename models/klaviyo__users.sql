with commit_comments_user as (
    select
        user_id,
        url,
        type,
        username
    from {{ ref('stg_intercom_commit_comments_user_tmp') }}
),

commit_comment_reactions_user as (
    select
        user_id,
        url,
        type,
        username
    from {{ ref('stg_intercom_commit_comment_reactions_user_tmp') }}
),

users_unioned as (
    select * from commit_comments_user
    union all
        select * from commit_comment_reactions_user

),

users as (
    select *
    from users_unioned
    group by 1,2
)

select * from users
