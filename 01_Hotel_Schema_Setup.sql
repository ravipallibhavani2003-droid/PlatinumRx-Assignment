-- =========================
-- DATABASE SETUP
-- =========================
CREATE DATABASE IF NOT EXISTS assignment_db;
USE assignment_db;

-- =========================
-- HOTEL MANAGEMENT TABLES
-- =========================

-- Users Table
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

-- Bookings Table
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(20),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Items Table
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

-- Booking_Commercials Table
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(5,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Sample Data Hotel
INSERT INTO users VALUES 
('21wrcxuy-67erfn', 'John Doe', '9700000000', 'john.doe@example.com', 'XX Street, ABC City'),
('31abcxuy-12defg', 'Jane Smith', '9800000000', 'jane.smith@example.com', 'YY Street, ABC City');

INSERT INTO bookings VALUES 
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-101', '21wrcxuy-67erfn'),
('bk-12f3g-45hj', '2021-11-15 14:20:10', 'rm-102', '31abcxuy-12defg');

INSERT INTO items VALUES 
('itm-a9e8-q8fu', 'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg', 89),
('itm-w978-23u4', 'Paneer Butter Masala', 120);

INSERT INTO booking_commercials VALUES
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4', 'bk-12f3g-45hj', 'bl-34qhd-r7h8', '2021-11-15 12:05:37', 'itm-w978-23u4', 2);

-- =========================
-- CLINIC MANAGEMENT TABLES
-- =========================

-- Clinics Table
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

-- Customer Table
CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

-- Clinic Sales Table
CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Expenses Table
CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(100),
    amount DECIMAL(10,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Sample Data Clinic
INSERT INTO clinics VALUES
('cnc-0100001', 'XYZ Clinic', 'CityA', 'StateX', 'CountryY'),
('cnc-0100002', 'ABC Clinic', 'CityB', 'StateX', 'CountryY');

INSERT INTO customer VALUES
('bk-09f3e-95hj', 'Jon Doe', '9700000000'),
('bk-12f3g-45hj', 'Alice Brown', '9800000000');

INSERT INTO clinic_sales VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'Online'),
('ord-00100-00101', 'bk-12f3g-45hj', 'cnc-0100002', 15000, '2021-11-15 10:20:10', 'Walk-In');

INSERT INTO expenses VALUES
('exp-0100-00100', 'cnc-0100001', 'First-aid supplies', 557, '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100002', 'Medicines', 1200, '2021-11-15 09:30:00');