WITH  __dbt__cte__user_session_channel as (
WITH user_session_channel_cte AS (
    SELECT
        userId,
        sessionId,
        channel
    FROM DEV.raw.user_session_channel
)

SELECT * FROM user_session_channel_cte
),  __dbt__cte__session_timestamp as (
WITH session_timestamp AS (
    SELECT
        sessionId,
        ts
    FROM DEV.raw.session_timestamp
)

SELECT * FROM session_timestamp
), u AS (
    SELECT * FROM __dbt__cte__user_session_channel
), st AS (
    SELECT * FROM __dbt__cte__session_timestamp
)
SELECT u.userId, u.sessionId, u.channel, st.ts
FROM u
JOIN st ON u.sessionId = st.sessionId
WHERE st.ts IS NOT NULL