
CREATE TABLE User (
    user_id CHAR(36) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX (email)
);

-- Create Property table (already in 3NF)
CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY,
    host_id CHAR(36) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE CASCADE,
    INDEX (host_id)
);

-- Create Pricing table (extracted from Property to avoid partial dependency)
CREATE TABLE Pricing (
    pricing_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    effective_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    INDEX (property_id)
);

-- Create Booking table (already in 3NF)
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    INDEX (property_id),
    INDEX (user_id)
);

-- Create BookingPrice table (junction table for booking pricing)
CREATE TABLE BookingPrice (
    booking_id CHAR(36) NOT NULL,
    pricing_id CHAR(36) NOT NULL,
    PRIMARY KEY (booking_id, pricing_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (pricing_id) REFERENCES Pricing(pricing_id) ON DELETE CASCADE
);


CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE,
    INDEX (booking_id)
);

-- Create Review table (already in 3NF)
CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    INDEX (property_id),
    INDEX (user_id)
);


CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY,
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE,
    INDEX (sender_id),
    INDEX (recipient_id)
);
