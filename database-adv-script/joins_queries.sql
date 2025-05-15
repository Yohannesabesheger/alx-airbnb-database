-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
-- Inner Join
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at AS user_created_at
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id;

