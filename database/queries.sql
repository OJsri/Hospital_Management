SELECT
    p.full_name AS patient_name,
    d.full_name AS doctor_name,
    a.appointment_date,
    a.appointment_time,
    a.appointment_status
FROM Appointment a
JOIN Patient p
ON a.patient_id = p.patient_id
JOIN Doctor d
ON a.doctor_id = d.doctor_id;


SELECT
    SUM(total_amount) AS total_revenue
FROM Bill;


SELECT
    d.full_name,
    COUNT(a.appointment_id) AS total_appointments
FROM Doctor d
JOIN Appointment a
ON d.doctor_id = a.doctor_id
GROUP BY d.full_name;



SELECT
    d.full_name,
    COUNT(a.appointment_id) AS total_appointments
FROM Doctor d
JOIN Appointment a
ON d.doctor_id = a.doctor_id
GROUP BY d.full_name
HAVING COUNT(a.appointment_id) >=1;


SELECT
    full_name
FROM Patient
WHERE patient_id IN (
    SELECT a.patient_id
    FROM Appointment a
    JOIN Bill b
    ON a.appointment_id = b.appointment_id
    WHERE b.payment_status = 'Pending'
);


CREATE OR REPLACE VIEW Doctor_Schedule AS
SELECT
    d.full_name AS doctor_name,
    a.appointment_date,
    a.appointment_time,
    a.appointment_status
FROM Doctor d
JOIN Appointment a
ON d.doctor_id = a.doctor_id;

SELECT * FROM Doctor_Schedule;