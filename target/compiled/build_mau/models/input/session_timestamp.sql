WITH session_timestamp AS (
    SELECT
        sessionId,
        ts
    FROM DEV.raw.session_timestamp
)

SELECT * FROM session_timestamp