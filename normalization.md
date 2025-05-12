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
