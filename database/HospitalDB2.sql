-- =========================
-- 6. PRESCRIPTION TABLE
-- =========================

CREATE TABLE Prescription (
    prescription_id NUMBER PRIMARY KEY,
    record_id NUMBER,
    medicine_name VARCHAR2(100),
    dosage VARCHAR2(100),
    duration_days NUMBER,
    special_instructions VARCHAR2(300),

    CONSTRAINT fk_prescription_record
    FOREIGN KEY (record_id)
    REFERENCES Medical_Record(record_id)
);

-- =========================
-- 7. BILL TABLE
-- =========================

CREATE TABLE Bill (
    bill_id NUMBER PRIMARY KEY,
    appointment_id NUMBER UNIQUE,
    consultation_fee NUMBER(10,2),
    medicine_charges NUMBER(10,2),
    lab_charges NUMBER(10,2),
    total_amount NUMBER(10,2),
    payment_status VARCHAR2(20),

    CONSTRAINT fk_bill_appointment
    FOREIGN KEY (appointment_id)
    REFERENCES Appointment(appointment_id)
);

-- =========================
-- 8. PAYMENT TABLE
-- =========================

CREATE TABLE Payment (
    payment_id NUMBER PRIMARY KEY,
    bill_id NUMBER UNIQUE,
    payment_date DATE,
    payment_method VARCHAR2(50),
    amount_paid NUMBER(10,2),
    transaction_reference VARCHAR2(100),

    CONSTRAINT fk_payment_bill
    FOREIGN KEY (bill_id)
    REFERENCES Bill(bill_id)
);