CREATE SEQUENCE appointment_seq
START WITH 1000
INCREMENT BY 1;


CREATE OR REPLACE PROCEDURE Book_Appointment (
    p_patient_id NUMBER,
    p_doctor_id NUMBER,
    p_appointment_date DATE,
    p_appointment_time VARCHAR2,
    p_status VARCHAR2
)
AS
BEGIN
    INSERT INTO Appointment (
        appointment_id,
        patient_id,
        doctor_id,
        appointment_date,
        appointment_time,
        appointment_status
    )
    VALUES (
        appointment_seq.NEXTVAL,
        p_patient_id,
        p_doctor_id,
        p_appointment_date,
        p_appointment_time,
        p_status
    );

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/



CREATE OR REPLACE FUNCTION Calculate_Total_Bill (
    p_consultation_fee NUMBER,
    p_medicine_charges NUMBER,
    p_lab_charges NUMBER
)
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    v_total :=
        p_consultation_fee +
        p_medicine_charges +
        p_lab_charges;

    RETURN v_total;
END;
/





CREATE OR REPLACE TRIGGER Prevent_Double_Booking
BEFORE INSERT ON Appointment
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Appointment
    WHERE doctor_id = :NEW.doctor_id
      AND TRUNC(appointment_date) = TRUNC(:NEW.appointment_date)
      AND appointment_time = :NEW.appointment_time;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Doctor already has an appointment at this time.'
        );
    END IF;
END;
/



CREATE OR REPLACE PROCEDURE Add_Patient (
    p_patient_id NUMBER,
    p_full_name VARCHAR2,
    p_gender VARCHAR2,
    p_age NUMBER,
    p_blood_group VARCHAR2,
    p_phone VARCHAR2,
    p_email VARCHAR2,
    p_address VARCHAR2,
    p_emergency_contact VARCHAR2
)
AS
BEGIN
    INSERT INTO Patient (
        patient_id,
        full_name,
        gender,
        age,
        blood_group,
        phone,
        email,
        address,
        emergency_contact,
        registration_date
    )
    VALUES (
        p_patient_id,
        p_full_name,
        p_gender,
        p_age,
        p_blood_group,
        p_phone,
        p_email,
        p_address,
        p_emergency_contact,
        SYSDATE
    );

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/




CREATE OR REPLACE PROCEDURE Update_Patient (
    p_patient_id NUMBER,
    p_full_name VARCHAR2,
    p_gender VARCHAR2,
    p_age NUMBER,
    p_blood_group VARCHAR2,
    p_phone VARCHAR2,
    p_email VARCHAR2,
    p_address VARCHAR2,
    p_emergency_contact VARCHAR2
)
AS
BEGIN
    UPDATE Patient
    SET
        full_name = p_full_name,
        gender = p_gender,
        age = p_age,
        blood_group = p_blood_group,
        phone = p_phone,
        email = p_email,
        address = p_address,
        emergency_contact = p_emergency_contact
    WHERE patient_id = p_patient_id;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


CREATE OR REPLACE PROCEDURE Update_Appointment_Status (
    p_appointment_id NUMBER,
    p_status VARCHAR2
)
AS
BEGIN
    UPDATE Appointment
    SET appointment_status = p_status
    WHERE appointment_id = p_appointment_id;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/



CREATE SEQUENCE bill_seq
START WITH 5000
INCREMENT BY 1;


CREATE OR REPLACE TRIGGER Generate_Bill_On_Completion

AFTER UPDATE OF appointment_status
ON Appointment

FOR EACH ROW

WHEN (
    NEW.appointment_status = 'Completed'
    AND OLD.appointment_status != 'Completed'
)

DECLARE

    v_fee NUMBER;

    v_count NUMBER;

BEGIN

    SELECT COUNT(*)
    INTO v_count
    FROM Bill
    WHERE appointment_id = :NEW.appointment_id;

    IF v_count = 0 THEN

        SELECT consultation_fee
        INTO v_fee
        FROM Doctor
        WHERE doctor_id = :NEW.doctor_id;

        INSERT INTO Bill (

            bill_id,
            appointment_id,
            consultation_fee,
            medicine_charges,
            lab_charges,
            total_amount,
            payment_status

        )
        VALUES (

            bill_seq.NEXTVAL,
            :NEW.appointment_id,
            v_fee,
            500,
            300,
            v_fee + 500 + 300,
            'Pending'

        );

    END IF;

END;
/

CREATE OR REPLACE PROCEDURE Update_Bill_Status (
    p_bill_id NUMBER,
    p_status VARCHAR2
)
AS
BEGIN
    UPDATE Bill
    SET payment_status = p_status
    WHERE bill_id = p_bill_id;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

CREATE OR REPLACE PROCEDURE Add_Doctor (
    p_doctor_id NUMBER,
    p_full_name VARCHAR2,
    p_specialization VARCHAR2,
    p_phone VARCHAR2,
    p_email VARCHAR2,
    p_consultation_fee NUMBER,
    p_department_id NUMBER
)
AS
BEGIN

    INSERT INTO Doctor (
        doctor_id,
        full_name,
        specialization,
        phone,
        email,
        consultation_fee,
        department_id
    )
    VALUES (
        p_doctor_id,
        p_full_name,
        p_specialization,
        p_phone,
        p_email,
        p_consultation_fee,
        p_department_id
    );

    COMMIT;

END;
/

CREATE OR REPLACE PROCEDURE Update_Doctor (
    p_doctor_id NUMBER,
    p_full_name VARCHAR2,
    p_specialization VARCHAR2,
    p_phone VARCHAR2,
    p_email VARCHAR2,
    p_consultation_fee NUMBER,
    p_department_id NUMBER
)
AS
BEGIN

    UPDATE Doctor
    SET
        full_name = p_full_name,
        specialization = p_specialization,
        phone = p_phone,
        email = p_email,
        consultation_fee = p_consultation_fee,
        department_id = p_department_id
    WHERE doctor_id = p_doctor_id;

    COMMIT;

END;
/


CREATE OR REPLACE PROCEDURE Add_Medical_Record (

    p_record_id NUMBER,
    p_patient_id NUMBER,
    p_doctor_id NUMBER,
    p_diagnosis VARCHAR2,
    p_treatment VARCHAR2,
    p_notes VARCHAR2,
    p_record_date DATE

)
AS
BEGIN

    INSERT INTO Medical_Record (

        record_id,
        patient_id,
        doctor_id,
        diagnosis,
        treatment,
        notes,
        record_date

    )
    VALUES (

        p_record_id,
        p_patient_id,
        p_doctor_id,
        p_diagnosis,
        p_treatment,
        p_notes,
        p_record_date

    );

    COMMIT;

END;
/