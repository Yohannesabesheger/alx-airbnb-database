# alx-airbnb-database

![Database Schema](https://img.shields.io/badge/Schema-3NF-blue)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange)
![License](https://img.shields.io/badge/License-MIT-green)

## 📚 Table of Contents
- [Overview](#-overview)
- [Features](#-features)
- [Database Schema](#-database-schema)
- [Installation](#-installation)
- [Usage](#-usage)
- [Development](#-development)
- [Contributing](#-contributing)
- [License](#-license)

## 🌟 Overview

This repository contains the **complete database implementation** for the ALX Airbnb Clone project. It provides a fully normalized relational database schema designed to power all backend operations of an Airbnb-like property booking platform.

## ✨ Features

### Core Functionality
- ✅ User management (Guests, Hosts, Admins)
- ✅ Property listings with rich descriptions
- ✅ Booking/reservation system
- ✅ Payment processing
- ✅ Review and rating system
- ✅ Messaging between users

### Database Features
- 🏷️ **3rd Normal Form compliance**
- 🔗 **Relationship integrity** with proper foreign keys
- ⏳ **Historical data tracking** (pricing changes)
- 🔒 **Data validation** (constraints, ENUMs, CHECKs)
- 🚀 **Optimized indexes** for performance
- 📅 **Automatic timestamps** for auditing

## 🗃️ Database Schema

### Entity Relationship Diagram
![ER Diagram](docs/er_diagram.png) *(Placeholder - add actual diagram path)*

### Tables Structure

| Table          | Description                          | Key Features                          |
|----------------|--------------------------------------|---------------------------------------|
| `User`         | User accounts and profiles           | Role-based access, authentication     |
| `Property`     | Property listings                    | Geolocation, host relationship       |
| `Pricing`      | Property pricing history             | Effective dating, rate changes       |
| `Booking`      | Reservation management               | Date ranges, status tracking         |
| `BookingPrice` | Price snapshot at booking time       | Preserves original booking price     |
| `Payment`      | Financial transactions               | Multiple payment methods             |
| `Review`       | Property ratings and feedback        | 1-5 star rating system               |
| `Message`      | User-to-user communication           | Timestamped conversations            |

## 💻 Installation

### Prerequisites
- MySQL 8.0+
- MySQL client tools

### Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/alx-airbnb-database.git
   cd alx-airbnb-database
