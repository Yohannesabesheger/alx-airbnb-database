## 🔍 Subquery Examples

This section demonstrates how to use **correlated** and **non-correlated subqueries** in SQL, based on a property booking system schema.

---

### ✅ 1. Properties with Average Rating Greater Than 4.0  
**(Non-Correlated Subquery)**

This query retrieves all properties that have an **average review rating above 4.0**. It uses a subquery that runs independently from the outer query.

```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location
FROM 
    Property p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            Review r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    );
    
## Write a correlated subquery to find users who have made more than 3 bookings.


    sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    User u
WHERE (
    SELECT 
        COUNT(*) 
    FROM 
        Booking b 
    WHERE 
        b.user_id = u.user_id
) > 3;
