# Database Performance Monitoring and Refinement Report

## Objective

To continuously monitor query performance using `EXPLAIN ANALYZE` and other profiling tools, identify bottlenecks, apply schema/index improvements, and measure the impact.

---

## 1. Monitored Queries

### Query 1: Fetch Confirmed Bookings with User and Property Details

```sql
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    p.name AS property_name
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE b.status = 'confirmed' 
  AND b.start_date >= '2024-01-01';
