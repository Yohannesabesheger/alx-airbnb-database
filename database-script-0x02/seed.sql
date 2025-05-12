-- ==========================
-- 1. User Table
-- ==========================
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
('b5a1d6e2-f1c3-4f84-b3f2-a2babc8e6344', 'Emily', 'Clark', 'emily.clark@example.com', 'hashed_pw_1', '555-1234', 'guest'),
('65a92fb3-dbd6-4e3c-90d2-ecf5c8235de9', 'David', 'Nguyen', 'david.host@example.com', 'hashed_pw_2', '555-5678', 'host'),
('9c3c2065-7084-4bb3-b735-c087cd4aaf3a', 'Sophia', 'Lopez', 'sophia.admin@example.com', 'hashed_pw_3', NULL, 'admin');

-- ==========================
-- 2. Property Table
-- ==========================
INSERT INTO Property (property_id, host_id, name, description, location)
VALUES
('f34a198b-d681-4f3e-b1f7-01b9e8e76b2b', '65a92fb3-dbd6-4e3c-90d2-ecf5c8235de9', 'Lakeside Retreat', 'Charming cottage with lake views and a cozy fireplace.', '123 Lakeview Dr, Tahoe, CA'),
('40c5794b-2f8b-4a71-8a6e-d8f1378e28c1', '65a92fb3-dbd6-4e3c-90d2-ecf5c8235de9', 'Urban Loft', 'Modern loft in the heart of downtown with rooftop access.', '456 Market St, San Francisco, CA'),
('dbd73f25-4f38-4ee6-b2a3-25ef41a5c1de', '65a92fb3-dbd6-4e3c-90d2-ecf5c8235de9', 'Country Escape', 'Farmhouse surrounded by nature and hiking trails.', '789 Country Rd, Asheville, NC');

-- ==========================
-- 3. Pricing Table
-- ==========================
INSERT INTO Pricing (pricing_id, property_id, price_per_night, effective_date)
VALUES
('5d3e1f1a-92f1-4d5a-bf2d-7f4ec456f21e', 'f34a198b-d681-4f3e-b1f7-01b9e8e76b2b', 120.00, '2025-05-10'),
('d43c9e4d-0989-4c3a-b91f-b6141d44f015', '40c5794b-2f8b-4a71-8a6e-d8f1378e28c1', 200.00, '2025-05-01'),
('12b8f2ec-6d49-44f3-b170-2de59bcf0c1a', 'dbd73f25-4f38-4ee6-b2a3-25ef41a5c1de', 95.00, '2025-05-05');

-- ==========================
-- 4. Booking Table
-- ==========================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status)
VALUES
('c7f76a31-16fd-4033-9383-1e731fc038ba', 'f34a198b-d681-4f3e-b1f7-01b9e8e76b2b', 'b5a1d6e2-f1c3-4f84-b3f2-a2babc8e6344', '2025-06-01', '2025-06-05', 'confirmed'),
('19e2f3dc-7e62-4e96-9062-d3bc96c1e2b7', '40c5794b-2f8b-4a71-8a6e-d8f1378e28c1', 'b5a1d6e2-f1c3-4f84-b3f2-a2babc8e6344', '2025-06-10', '2025-06-15', 'pending'),
('87e884d0-839e-4268-946d-d6b4a72e8ea3', 'dbd73f25-4f38-4ee6-b2a3-25ef41a5c1de', 'b5a1d6e2-f1c3-4f84-b3f2-a2babc8e6344', '2025-07-01', '2025-07-04', 'canceled');

-- ==========================
-- 5. BookingPrice Table
-- ==========================
INSERT INTO BookingPrice (booking_id, pricing_id)
VALUES
('c7f76a31-16fd-4033-9383-1e731fc038ba', '5d3e1f1a-92f1-4d5a-bf2d-7f4ec456f21e'),
('19e2f3dc-7e62-4e96-9062-d3bc96c1e2b7', 'd43c9e4d-0989-4c3a-b91f-b6141d44f015'),
('87e884d0-839e-4268-946d-d6b4a72e8ea3', '12b8f2ec-6d49-44f3-b170-2de59bcf0c1a');

-- ==========================
-- 6. Payment Table
-- ==========================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
('b8b7c98b-3c8b-41ab-87a9-1f95fc1ffbba', 'c7f76a31-16fd-4033-9383-1e731fc038ba', 480.00, 'credit_card'),
('f328aa2e-9dcb-4f0e-9217-b9bb77ffbce2', '19e2f3dc-7e62-4e96-9062-d3bc96c1e2b7', 1000.00, 'paypal'),
('9fa6a303-f342-4b52-a924-0c48ae81b890', '87e884d0-839e-4268-946d-d6b4a72e8ea3', 285.00, 'stripe');

-- ==========================
-- 7. Review Table
-- ==========================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
('af2bd108-2e1f-4e61-9a61-9c77e3d8adcb', 'f34a198b-d681-4f3e-b1f7-01b9e8e76b2b', 'b5a1d6e2-f1c3-4f84-b3f2-a2babc8e6344', 5, 'Lovely stay with amazing lake views. Highly recommend!'),
('98ff632a-5a3e-43eb-a5c7-c23b63aa745f', '40c5794b-2f8b-4a71-8a6e-d8f1378e28c1', 'b5a1d6e2-f1c3-4f84-b3f2-a2babc8e6344', 4, 'Great location and clean space. A bit noisy at night.'),
('ee7280b0-4711-4121-98e4-bdbe7693a3a9', 'dbd73f25-4f38-4ee6-b2a3-25ef41a5c1de', 'b5a1d6e2-f1c3-4f84-b3f2-a2babc8e6344', 3, 'Nice rural escape but Wi-Fi was spotty.');

-- ==========================
-- 8. Message Table
-- ==========================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
('0f7e0389-d8a7-4e13-9bd5-dc9b2f2690f6', 'b5a1d6e2-f1c3-4f84-b3f2-a2babc8e6344', '65a92fb3-dbd6-4e3c-90d2-ecf5c8235de9', 'Hi David, is Lakeside Retreat available the first week of June?'),
('dfe1b89e-96bb-49a6-aab6-25394ea7706e', '65a92fb3-dbd6-4e3c-90d2-ecf5c8235de9', 'b5a1d6e2-f1c3-4f84-b3f2-a2babc8e6344', 'Yes, it’s available! Would you like to proceed with the booking?'),
('8ffb6b8a-542e-4211-ae1a-4de275bd8f30', 'b5a1d6e2-f1c3-4f84-b3f2-a2babc8e6344', '65a92fb3-dbd6-4e3c-90d2-ecf5c8235de9', 'Yes, I’ve booked it. Looking forward to my stay!');
