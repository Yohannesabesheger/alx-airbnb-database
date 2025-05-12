# 📘 Database Normalization Documentation

This document outlines the normalization process for a property rental platform's database schema. All tables are normalized to **Third Normal Form (3NF)** to ensure data consistency, reduce redundancy, and improve efficiency.

---

## 🔖 Summary

This schema supports a property rental system and includes:

- **Users**: Guests, hosts, and admins
- **Properties**: Listings created by hosts
- **Pricing**: Nightly price details for properties
- **Bookings**: Reservations made by users
- **Booking Prices**: Pricing breakdown per booking
- **Payments**: Transactions made for bookings
- **Reviews**: User feedback on properties
- **Messages**: User-to-user communications

### ✅ Normalization Status

| Table           | Description                                | 1NF | 2NF | 3NF |
|------------------|--------------------------------------------|-----|-----|-----|
| `User`           | Platform user info                         | ✅  | ✅  | ✅  |
| `Property`       | Host-created property listings             | ✅  | ✅  | ✅  |
| `Pricing`        | Pricing per property per effective date    | ✅  | ✅  | ✅  |
| `Booking`        | Property booking info                      | ✅  | ✅  | ✅  |
| `BookingPrice`   | M:N mapping between bookings and prices    | ✅  | ✅  | ✅  |
| `Payment`        | Payments for bookings                      | ✅  | ✅  | ✅  |
| `Review`         | Reviews of properties by users             | ✅  | ✅  | ✅  |
| `Message`        | Direct messages between users              | ✅  | ✅  | ✅  |

All tables comply with normalization rules and utilize **foreign key constraints** for referential integrity and **UUIDs** as primary keys.

---

## 🧱 Schema Overview

This system includes the following main entities:

- `User`: Platform users (guest, host, admin)
- `Property`: Listings hosted by users
- `Pricing`: Nightly prices for properties
- `Booking`: Reservations made by guests
- `BookingPrice`: Pricing details per booking
- `Payment`: Payments for bookings
- `Review`: User reviews for properties
- `Message`: Communication between users

---

## 🔍 Normalization Principles

Normalization ensures database efficiency by eliminating redundancy and ensuring data dependencies make sense. The process includes:

- **1NF (First Normal Form)**: Eliminate repeating groups; atomic values only.
- **2NF (Second Normal Form)**: Eliminate partial dependencies on a composite key.
- **3NF (Third Normal Form)**: Eliminate transitive dependencies; all fields depend only on the primary key.

---

## 🧑 User Table

```sql

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
