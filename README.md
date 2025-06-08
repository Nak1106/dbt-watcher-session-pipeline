# 📘 dbt Session Summary Project on Snowflake

This repository contains a complete **dbt project** built on **Snowflake**, designed to model and snapshot session-level user activity. It was created for an academic assignment following structured class instructions.

---

## 🎯 Assignment Objectives

- ✅ Create a dbt project connected to Snowflake  
- ✅ Set up input models using **CTEs**  
- ✅ Build an output model: `session_summary`  
- ✅ Implement **snapshots** for the output table  
- ✅ Add schema-level tests on key fields  
- ✅ Include all SQL and YAML files + screenshots in this repo

---

## 🧩 Input Models

### 📄 `models/input/user_session_channel.sql`

```sql
WITH base AS (
    SELECT 
        userId,
        sessionId,
        channel
    FROM {{ source('raw', 'user_session_channel') }}
)
SELECT * FROM base;
```

### 📄 `models/input/session_timestamp.sql`

```sql
WITH base AS (
    SELECT 
        sessionId,
        ts
    FROM {{ source('raw', 'session_timestamp') }}
)
SELECT * FROM base;
```

---

## 📦 Output Model

### 📄 `models/output/session_summary.sql`

```sql
WITH user_sessions AS (
    SELECT * FROM {{ ref('user_session_channel') }}
),
timestamps AS (
    SELECT * FROM {{ ref('session_timestamp') }}
)
SELECT 
    u.userId,
    u.sessionId,
    u.channel,
    t.ts
FROM user_sessions u
JOIN timestamps t
    ON u.sessionId = t.sessionId;
```

---

## 🧪 Schema Tests

### 📄 `models/output/schema.yml`

```yaml
version: 2

models:
  - name: session_summary
    columns:
      - name: sessionId
        tests:
          - unique
          - not_null
```

---

## 🕒 Snapshots

### 📄 `snapshots/snapshot_session_summary.sql`

```sql
{% snapshot snapshot_session_summary %}
{{
    config(
      target_schema='snapshots',
      unique_key='sessionId',
      strategy='check',
      check_cols=['userId', 'channel', 'ts']
    )
}}
SELECT * FROM {{ ref('session_summary') }}
{% endsnapshot %}
```

---

## 🖼️ Screenshots

| 📌 Screenshot | Description |
|---------------|-------------|
| `dbt_model_1.png` | Input models: `user_session_channel` & `session_timestamp` |
| `dbt_model_2.png` | Output model: `session_summary` |
| `dbt_snapshot.png` | Snapshot for `session_summary` |
| `dbt_test_results.png` | dbt test run showing uniqueness and not_null tests |

> ✔ All screenshots available in the `/screenshots` folder

---

## 💻 Tools & Tech

- `dbt-core`
- `Snowflake` (target platform)
- `YAML` for model/test configuration
- SQL CTEs for modeling logic

---

## 📚 Learning Outcomes

- Using dbt's modular SQL approach to build and test pipelines  
- Applying snapshot logic to track dimension changes  
- Writing schema-level tests for data integrity  
- Creating source models and documenting metadata  

---

## 👨‍💻 Author

**Nakshatra Desai**  
Graduate Student – MS Data Analytics @ SJSU  
📫 [LinkedIn](https://www.linkedin.com/in/nakshatra-desai-547a771b6/)

---
