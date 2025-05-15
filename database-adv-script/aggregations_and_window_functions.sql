-- 1. Total Number of Bookings by Each User
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name;
-- 2. Ranking Properties by Total Number of Bookings using ROW_NUMBER()
SELECT 
    property_id,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_num,
    RANK() OVER (ORDER BY total_bookings DESC) AS rank
FROM (
    SELECT 
        b.property_id,
        COUNT(b.booking_id) AS total_bookings
    FROM 
        Booking b
    GROUP BY 
        b.property_id
) AS property_booking_counts;
