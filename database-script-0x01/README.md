# 🗃️ Property Rental Platform – Database Documentation

This document describes the database structure of a property rental platform that includes users, properties, pricing, bookings, reviews, messages, and payments. All tables are normalized to **Third Normal Form (3NF)** to optimize data consistency and reduce redundancy.

---

## 📋 Table of Contents

1. [Users](#1-users)
2. [Properties](#2-properties)
3. [Pricing](#3-pricing)
4. [Bookings](#4-bookings)
5. [BookingPrice](#5-bookingprice)
6. [Payments](#6-payments)
7. [Reviews](#7-reviews)
8. [Messages](#8-messages)
9. [Normalization Summary](#9-normalization-summary)

---

## 1. 🧑 Users

**Table:** `User`  
**Purpose:** Stores platform user information including guests, hosts, and admins.

| Column        | Type               | Description                          |
|---------------|--------------------|--------------------------------------|
| user_id       | CHAR(36)           | Primary key (UUID)                   |
| first_name    | VARCHAR(50)        | User's first name                    |
| last_name     | VARCHAR(50)        | User's last name                     |
| email         | VARCHAR(100)       | Unique email address                 |
| password_hash | VARCHAR(255)       | Hashed user password                 |
| phone_number  | VARCHAR(20)        | Optional phone number                |
| role          | ENUM               | guest / host / admin                 |
| created_at    | TIMESTAMP          | Record creation timestamp            |

✅ **Normalized to 3NF**  
🔗 Relationships:  
- Referenced by: `Property`, `Booking`, `Review`, `Message`

---

## 2. 🏡 Properties

**Table:** `Property`  
**Purpose:** Represents properties listed by users (hosts).

| Column      | Type        | Description                          |
|-------------|-------------|--------------------------------------|
| property_id | CHAR(36)    | Primary key (UUID)                   |
| host_id     | CHAR(36)    | FK to `User(user_id)`               |
| name        | VARCHAR(100)| Property name                        |
| description | TEXT        | Description of the property          |
| location    | VARCHAR(255)| Full address or location string      |
| created_at  | TIMESTAMP   | Created timestamp                    |
| updated_at  | TIMESTAMP   | Auto-updated timestamp               |

✅ **Normalized to 3NF**  
🔗 Relationships:
- References: `User`
- Referenced by: `Pricing`, `Booking`, `Review`

---

## 3. 💵 Pricing

**Table:** `Pricing`  
**Purpose:** Stores nightly rates and date-based pricing for properties.

| Column         | Type         | Description                           |
|----------------|--------------|---------------------------------------|
| pricing_id     | CHAR(36)     | Primary key (UUID)                    |
| property_id    | CHAR(36)     | FK to `Property(property_id)`        |
| price_per_night| DECIMAL(10,2)| Nightly price                         |
| effective_date | DATE         | Date from which price is effective    |

✅ **Normalized to 3NF**  
🔗 Relationships:
- References: `Property`
- Referenced by: `BookingPrice`

---

## 4. 📆 Bookings

**Table:** `Booking`  
**Purpose:** Manages property reservations by users.

| Column      | Type        | Description                            |
|-------------|-------------|----------------------------------------|
| booking_id  | CHAR(36)    | Primary key (UUID)                     |
| property_id | CHAR(36)    | FK to `Property(property_id)`         |
| user_id     | CHAR(36)    | FK to `User(user_id)`                 |
| start_date  | DATE        | Start of booking                       |
| end_date    | DATE        | End of booking                         |
| status      | ENUM        | pending / confirmed / canceled         |
| created_at  | TIMESTAMP   | Booking creation timestamp             |

✅ **Normalized to 3NF**  
🔗 Relationships:
- References: `User`, `Property`
- Referenced by: `Payment`, `BookingPrice`

---

## 5. 🔗 BookingPrice

**Table:** `BookingPrice`  
**Purpose:** Junction table connecting bookings with pricing.

| Column      | Type     | Description                           |
|-------------|----------|---------------------------------------|
| booking_id  | CHAR(36) | FK to `Booking(booking_id)`           |
| pricing_id  | CHAR(36) | FK to `Pricing(pricing_id)`           |

🔑 **Composite Primary Key**: (booking_id, pricing_id)  
✅ **Normalized to 3NF**  
🔗 Relationships:
- References: `Booking`, `Pricing`

---

## 6. 💳 Payments

**Table:** `Payment`  
**Purpose:** Records payment transactions for bookings.

| Column         | Type         | Description                            |
|----------------|--------------|----------------------------------------|
| payment_id     | CHAR(36)     | Primary key (UUID)                     |
| booking_id     | CHAR(36)     | FK to `Booking(booking_id)`           |
| amount         | DECIMAL(10,2)| Total amount paid                      |
| payment_date   | TIMESTAMP    | Date of payment                        |
| payment_method | ENUM         | credit_card / paypal / stripe          |

✅ **Normalized to 3NF**  
🔗 Relationships:
- References: `Booking`

---

## 7. 🌟 Reviews

**Table:** `Review`  
**Purpose:** Stores feedback left by users for properties.

| Column     | Type      | Description                           |
|------------|-----------|---------------------------------------|
| review_id  | CHAR(36)  | Primary key (UUID)                    |
| property_id| CHAR(36)  | FK to `Property(property_id)`        |
| user_id    | CHAR(36)  | FK to `User(user_id)`                |
| rating     | INT       | Rating between 1 and 5                |
| comment    | TEXT      | Review content                        |
| created_at | TIMESTAMP | Timestamp of review creation          |

✅ **Normalized to 3NF**  
🔗 Relationships:
- References: `User`, `Property`

---

## 8. 💬 Messages

**Table:** `Message`  
**Purpose:** Enables user-to-user communication.

| Column        | Type      | Description                           |
|---------------|-----------|---------------------------------------|
| message_id    | CHAR(36)  | Primary key (UUID)                    |
| sender_id     | CHAR(36)  | FK to `User(user_id)`                |
| recipient_id  | CHAR(36)  | FK to `User(user_id)`                |
| message_body  | TEXT      | The actual message text               |
| sent_at       | TIMESTAMP | When the message was sent             |

✅ **Normalized to 3NF**  
🔗 Relationships:
- References: `User` (as sender and recipient)

---

## 9. 📊 Normalization Summary

All tables in the schema adhere to the **Third Normal Form (3NF)**:

| Table         | 1NF | 2NF | 3NF |
|---------------|-----|-----|-----|
| User          | ✅  | ✅  | ✅  |
| Property      | ✅  | ✅  | ✅  |
| Pricing       | ✅  | ✅  | ✅  |
| Booking       | ✅  | ✅  | ✅  |
| BookingPrice  | ✅  | ✅  | ✅  |
| Payment       | ✅  | ✅  | ✅  |
| Review        | ✅  | ✅  | ✅  |
| Message       | ✅  | ✅  | ✅  |

---

## 🧾 License

This documentation is open-source and available under the [MIT License](LICENSE).

---

## ✍️ Author

Maintained by [Your Name or Organization].

