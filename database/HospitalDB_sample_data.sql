-- =========================
-- SAMPLE DATA INSERTION
-- =========================

-- DEPARTMENT

INSERT INTO Department VALUES
(1, 'Cardiology', 'Dr. Sharma', 'EXT101');

INSERT INTO Department VALUES
(2, 'Neurology', 'Dr. Mehta', 'EXT102');

INSERT INTO Department VALUES
(3, 'Orthopedics', 'Dr. Verma', 'EXT103');


-- DOCTOR

INSERT INTO Doctor VALUES
(101, 'Dr. Rajesh Kumar', 'Cardiologist',
'9876543210', 'rajesh@hospital.com', 800, 1);

INSERT INTO Doctor VALUES
(102, 'Dr. Priya Singh', 'Neurologist',
'9876543211', 'priya@hospital.com', 1000, 2);

INSERT INTO Doctor VALUES
(103, 'Dr. Amit Verma', 'Orthopedic Surgeon',
'9876543212', 'amit@hospital.com', 900, 3);


-- PATIENT

INSERT INTO Patient VALUES
(201, 'Rahul Sharma', 'Male', 25, 'B+',
'9876500001', 'rahul@gmail.com',
'Patiala, Punjab', '9876500011', SYSDATE);

INSERT INTO Patient VALUES
(202, 'Sneha Gupta', 'Female', 30, 'A+',
'9876500002', 'sneha@gmail.com',
'Delhi', '9876500012', SYSDATE);

INSERT INTO Patient VALUES
(203, 'Arjun Mehta', 'Male', 40, 'O+',
'9876500003', 'arjun@gmail.com',
'Chandigarh', '9876500013', SYSDATE);


-- APPOINTMENT

INSERT INTO Appointment VALUES
(301, 201, 101, SYSDATE + 1, '10:00 AM', 'Confirmed');

INSERT INTO Appointment VALUES
(302, 202, 102, SYSDATE + 2, '12:00 PM', 'Pending');

INSERT INTO Appointment VALUES
(303, 203, 103, SYSDATE + 3, '03:00 PM', 'Confirmed');


-- MEDICAL RECORD

INSERT INTO Medical_Record VALUES
(401, 301, 'Mild chest pain',
'Chest discomfort', 'Prescribed ECG test', SYSDATE);

INSERT INTO Medical_Record VALUES
(402, 302, 'Migraine',
'Frequent headaches', 'Prescribed MRI scan', SYSDATE);


-- PRESCRIPTION

INSERT INTO Prescription VALUES
(501, 401, 'Aspirin', '1 tablet daily',
7, 'After meals');

INSERT INTO Prescription VALUES
(502, 402, 'Paracetamol', '2 tablets daily',
5, 'Before sleep');


-- BILL

INSERT INTO Bill VALUES
(601, 301, 800, 200, 500, 1500, 'Pending');

INSERT INTO Bill VALUES
(602, 302, 1000, 300, 700, 2000, 'Paid');


-- PAYMENT

INSERT INTO Payment VALUES
(701, 602, SYSDATE, 'UPI',
2000, 'TXN123456');

COMMIT;