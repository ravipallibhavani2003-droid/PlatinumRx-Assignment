
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);


CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);


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


CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(100),
    amount DECIMAL(10,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);


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
