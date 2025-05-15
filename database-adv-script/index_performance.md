✅ Step-by-step Instructions:
🔍 Identify High-Usage Columns
Based on typical query patterns (e.g., JOINs, filtering, and sorting), the following columns are commonly used:

User table: email, user_id

Booking table: user_id, property_id, start_date

Property table: host_id, location

📈 Measure Query Performance
Use the EXPLAIN or ANALYZE command before and after adding indexes to assess performance improvement.

```sql
EXPLAIN SELECT * FROM Booking WHERE user_id = 'some-user-id';

After creating indexes, rerun the same EXPLAIN and compare the output, focusing on:

Use of index scan instead of sequential scan

Lower cost estimates

Fewer rows returned early in the plan