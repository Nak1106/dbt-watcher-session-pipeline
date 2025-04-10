WITH session_timestamp AS (
    SELECT
        sessionId,
        ts
    FROM {{ source('raw', 'session_timestamp') }}
)

SELECT * FROM session_timestamp
