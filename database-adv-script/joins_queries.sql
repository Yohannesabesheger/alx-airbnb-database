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

-- Left Joun
--Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at,
    u.user_id,
    u.first_name,
    u.last_name
FROM 
    Property p
LEFT JOIN Review r ON p.property_id = r.property_id
LEFT JOIN User u ON r.user_id = u.user_id
GROUP BY 
    p.property_id, p.name, p.location,
    r.review_id, r.rating, r.comment, r.created_at,
    u.user_id, u.first_name, u.last_name;


