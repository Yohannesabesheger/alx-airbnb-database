# Partitioning Performance Report

## Objective

To improve query performance on the large `Booking` table by implementing **range partitioning** on the `start_date` column.

## Partitioning Strategy

The `Booking` table was partitioned by year using the `start_date` column. The table was split into separate partitions for each year, such as:
- Booking_2022
- Booking_2023
- Booking_2024

## Query Used for Testing

```sql
EXPLAIN ANALYZE
SELECT booking_id, start_date, end_date
FROM Booking
WHERE start_date >= '2024-01-01' AND start_date < '2025-01-01';
