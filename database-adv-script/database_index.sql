-- ===========================
-- BEFORE CREATING INDEXES
-- ===========================

-- Analyze performance of a common query on Booking table
EXPLAIN SELECT * FROM Booking WHERE user_id = 'some-user-id';

EXPLAIN ANALYZE SELECT * FROM Booking WHERE user_id = 'some-user-id';

-- Analyze a join query involving Property and Booking
EXPLAIN
SELECT p.property_id, p.name, b.booking_id
FROM Property p
JOIN Booking b ON p.property_id = b.property_id
WHERE p.location = 'Addis Ababa';

EXPLAIN ANALYZE
SELECT p.property_id, p.name, b.booking_id
FROM Property p
JOIN Booking b ON p.property_id = b.property_id
WHERE p.location = 'Addis Ababa';

-- ===========================
-- CREATE INDEXES
-- ===========================

-- Indexes for User table
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_user_id ON User(user_id);

-- Indexes for Booking table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- Indexes for Property table
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);

-- ===========================
-- AFTER CREATING INDEXES
-- ===========================

-- Rerun the same queries with EXPLAIN to compare performance

EXPLAIN SELECT * FROM Booking WHERE user_id = 'some-user-id';

EXPLAIN ANALYZE SELECT * FROM Booking WHERE user_id = 'some-user-id';

EXPLAIN
SELECT p.property_id, p.name, b.booking_id
FROM Property p
JOIN Booking b ON p.property_id = b.property_id
WHERE p.location = 'Addis Ababa';

EXPLAIN ANALYZE
SELECT p.property_id, p.name, b.booking_id
FROM Property p
JOIN Booking b ON p.property_id = b.property_id
WHERE p.location = 'Addis Ababa';
