-- Drop existing Booking table if needed (for clean setup)
DROP TABLE IF EXISTS Booking CASCADE;

-- =====================================
-- Create Partitioned Booking Table
-- =====================================
CREATE TABLE Booking (
    booking_id CHAR(36) NOT NULL,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- =====================================
-- Create Partitions by Year
-- =====================================
CREATE TABLE Booking_2022 PARTITION OF Booking
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE Booking_2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Add indexes for filtering and joining
CREATE INDEX idx_booking_user ON Booking (user_id);
CREATE INDEX idx_booking_property ON Booking (property_id);
CREATE INDEX idx_booking_status ON Booking (status);
s