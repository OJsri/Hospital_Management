-- =========================
-- 1. DEPARTMENT TABLE
-- =========================

CREATE TABLE Department (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(100) NOT NULL,
    department_head VARCHAR2(100),
    contact_extension VARCHAR2(20)
);

-- =========================
-- 2. DOCTOR TABLE
-- =========================

CREATE TABLE Doctor (
    doctor_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    specialization VARCHAR2(100),
    phone VARCHAR2(15),
    email VARCHAR2(100) UNIQUE,
    consultation_fee NUMBER(10,2),
    department_id NUMBER,
    
    CONSTRAINT fk_doctor_department
    FOREIGN KEY (department_id)
    REFERENCES Department(department_id)
);

-- =========================
-- 3. PATIENT TABLE
-- =========================

CREATE TABLE Patient (
    patient_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    gender VARCHAR2(10),
    age NUMBER,
    blood_group VARCHAR2(5),
    phone VARCHAR2(15),
    email VARCHAR2(100) UNIQUE,
    address VARCHAR2(200),
    emergency_contact VARCHAR2(15),
    registration_date DATE DEFAULT SYSDATE
);

-- =========================
-- 4. APPOINTMENT TABLE
-- =========================

CREATE TABLE Appointment (
    appointment_id NUMBER PRIMARY KEY,
    patient_id NUMBER,
    doctor_id NUMBER,
    appointment_date DATE,
    appointment_time VARCHAR2(20),
    appointment_status VARCHAR2(20),

    CONSTRAINT fk_appointment_patient
    FOREIGN KEY (patient_id)
    REFERENCES Patient(patient_id),

    CONSTRAINT fk_appointment_doctor
    FOREIGN KEY (doctor_id)
    REFERENCES Doctor(doctor_id)
);

-- =========================
-- 5. MEDICAL RECORD TABLE
-- =========================

CREATE TABLE Medical_Record (
    record_id NUMBER PRIMARY KEY,
    appointment_id NUMBER UNIQUE,
    diagnosis VARCHAR2(200),
    symptoms VARCHAR2(300),
    treatment_notes VARCHAR2(500),
    visit_date DATE,

    CONSTRAINT fk_record_appointment
    FOREIGN KEY (appointment_id)
    REFERENCES Appointment(appointment_id)
);