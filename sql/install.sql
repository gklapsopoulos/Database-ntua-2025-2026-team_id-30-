CREATE TABLE MEDIA_STAFF
(
    media_id INT NOT NULL AUTO_INCREMENT,
    description VARCHAR(100),
    URL VARCHAR(255) NOT NULL,
    PRIMARY KEY (media_id),
    UNIQUE (URL)
);

CREATE TABLE MEDIA_OPERATING_ROOMS(
    media_id INT NOT NULL AUTO_INCREMENT,
    description VARCHAR(100),
    URL VARCHAR(255) NOT NULL,
    PRIMARY KEY (media_id),
    UNIQUE (URL)
);

CREATE TABLE MEDIA_DEPARTMENT(
    media_id INT NOT NULL AUTO_INCREMENT,
    description VARCHAR(100),
    URL VARCHAR(255) NOT NULL,
    PRIMARY KEY (media_id),
    UNIQUE (URL)
);

CREATE TABLE STAFF
(
    staff_id INT NOT NULL AUTO_INCREMENT,
    AMKA BIGINT NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    age INT NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    staff_type VARCHAR(25) NOT NULL,
    media_id INT NOT NULL,
    working_status BOOLEAN NOT NULL,
    PRIMARY KEY (staff_id),
    FOREIGN KEY (media_id) REFERENCES MEDIA_STAFF(media_id),
    CONSTRAINT chk_staff_type CHECK (staff_type IN ('doctor', 'nurse', 'administrative staff')),
    CONSTRAINT chk_staff_age CHECK (age >= 18)
);

CREATE TABLE STAFF_PHONE
(
    phone VARCHAR(20) NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY (phone, staff_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id)
);

CREATE TABLE DOCTOR_RANKS
(
    `rank` INT NOT NULL,
    description VARCHAR(20),
    PRIMARY KEY (`rank`)
);

CREATE TABLE DOCTOR
(
    supervisor INT DEFAULT NULL,
    medical_license_number INT NOT NULL UNIQUE,
    specialty VARCHAR(30) NOT NULL,
    `rank` INT NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY (staff_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (supervisor) REFERENCES DOCTOR(staff_id),
    FOREIGN KEY (`rank`) REFERENCES DOCTOR_RANKS(`rank`),
    CONSTRAINT chk_doctor_rank CHECK (`rank` IN (1, 2, 3, 4)),
    CONSTRAINT chk_doctor_specialty CHECK (specialty IN ('Cardiology', 'Endocrinology', 'Gastroenterology', 'Neurology', 'Psychiatry', 'Neurosurgeon', 'Pediatrician', 'Gynecology', 'Anesthesiology', 'Oncology', 'Dermatology')),
    CONSTRAINT chk_director_has_no_supervisor CHECK (`rank` != 4 OR supervisor IS NULL),
    CONSTRAINT chk_resident_has_supervisor CHECK (`rank` != 1 OR supervisor IS NOT NULL)
);

CREATE TABLE DEPARTMENT
(
    department_name VARCHAR(50) NOT NULL,
    description VARCHAR(50) NOT NULL,
    floor INT NOT NULL,
    building VARCHAR(25) NOT NULL,
    bed_count INT NOT NULL,
    director_id INT NOT NULL UNIQUE,
    media_id INT NOT NULL,
    PRIMARY KEY (department_name),
    FOREIGN KEY (director_id) REFERENCES DOCTOR(staff_id),
    FOREIGN KEY (media_id) REFERENCES MEDIA_DEPARTMENT(media_id),
    CONSTRAINT chk_department_bed_count CHECK (bed_count >= 0)
);

CREATE TABLE NURSES
(
    `rank` VARCHAR(20) NOT NULL,
    staff_id INT NOT NULL,
    department_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (staff_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (department_name) REFERENCES DEPARTMENT(department_name),
    CONSTRAINT chk_nurse_rank CHECK (`rank` IN ('nursing assistant', 'nurse', 'head nurse'))
);

CREATE TABLE ADMINISTRATIVE_STAFF
(
    role VARCHAR(30) NOT NULL,
    office VARCHAR(10) NOT NULL,
    staff_id INT NOT NULL,
    department_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (staff_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (department_name) REFERENCES DEPARTMENT(department_name),
    CONSTRAINT chk_admin_role CHECK (role IN ('Admissions Officer', 'Department Secretary', 'Appointment Scheduler', 'Accountant', 'Billing Specialist', 'HR Officer', 'Procurement Officer', 'Inventory Manager', 'Administrative Director', 'IT Support Officer'))
);

CREATE TABLE DOCTOR_DEPARTMENT
(
    department_name VARCHAR(50) NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY (staff_id, department_name),
    FOREIGN KEY (department_name) REFERENCES DEPARTMENT(department_name),
    FOREIGN KEY (staff_id) REFERENCES DOCTOR(staff_id)
);

CREATE TABLE PATIENTS
(
    AMKA BIGINT NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    father_name VARCHAR(25) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    weight NUMERIC(4,1) NOT NULL,
    height INT NOT NULL,
    street VARCHAR(35) NOT NULL,
    street_number INT NOT NULL,
    city VARCHAR(30) NOT NULL,
    insurance_provider VARCHAR(35) NOT NULL,
    email VARCHAR(50) NOT NULL,
    profession VARCHAR(25) NOT NULL,
    nationality VARCHAR(30) NOT NULL,
    PRIMARY KEY (AMKA),
    CONSTRAINT chk_patient_age CHECK (age >= 0)
);

CREATE TABLE PATIENT_PHONE
(
    phone VARCHAR(20) NOT NULL,
    AMKA BIGINT NOT NULL,
    PRIMARY KEY (phone, AMKA),
    FOREIGN KEY (AMKA) REFERENCES PATIENTS(AMKA)
);

CREATE TABLE PATIENT_RELATIVES
(
    relative_id INT NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(25) NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    relationship VARCHAR(25) NOT NULL,
    AMKA BIGINT NOT NULL,
    PRIMARY KEY (relative_id),
    FOREIGN KEY (AMKA) REFERENCES PATIENTS(AMKA)
);

CREATE TABLE RELATIVE_PHONE
(
    phone VARCHAR(20) NOT NULL,
    relative_id INT NOT NULL,
    PRIMARY KEY (phone, relative_id),
    FOREIGN KEY (relative_id) REFERENCES PATIENT_RELATIVES(relative_id) ON DELETE CASCADE
);

CREATE TABLE BEDS
(
    bed_number INT NOT NULL,
    type VARCHAR(25) NOT NULL,
    status VARCHAR(25) NOT NULL,
    department_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (bed_number),
    FOREIGN KEY (department_name) REFERENCES DEPARTMENT(department_name),
    CONSTRAINT chk_bed_type CHECK (type IN ('ICU', 'single-bed', 'multi-bed', 'Isolation', 'Recovery-bed', 'Double-room-bed')),
    CONSTRAINT chk_bed_status CHECK (status IN ('occupied', 'not occupied', 'maintenance'))
);

CREATE TABLE SHIFTS
(
    shift_id INT NOT NULL AUTO_INCREMENT,
    shift_date DATE NOT NULL,
    slot VARCHAR(15) NOT NULL,
    department_name VARCHAR(50) NOT NULL,
    shift_status VARCHAR(10) NOT NULL,
    PRIMARY KEY (shift_id),
    FOREIGN KEY (department_name) REFERENCES DEPARTMENT(department_name),
    CONSTRAINT chk_shift_slot CHECK (slot IN ('morning', 'afternoon', 'night')),
    CONSTRAINT chk_shift_status CHECK (shift_status IN ('full', 'not full'))
);

CREATE TABLE DUTY_TEAM
(
    staff_id INT NOT NULL,
    shift_id INT NOT NULL,
    PRIMARY KEY (staff_id, shift_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (shift_id) REFERENCES SHIFTS(shift_id)
);

CREATE TABLE TRIAGE
(
    triage_id INT NOT NULL AUTO_INCREMENT,
    urgency_level INT NOT NULL,
    arrival_time DATETIME NOT NULL,
    service_time DATETIME,
    AMKA BIGINT NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY (triage_id),
    FOREIGN KEY (AMKA) REFERENCES PATIENTS(AMKA),
    FOREIGN KEY (staff_id) REFERENCES NURSES(staff_id),
    CONSTRAINT chk_triage_urgency CHECK (urgency_level IN (1, 2, 3, 4, 5))
);

CREATE TABLE DIAGNOSES
(
    diagnosis_code VARCHAR(250) NOT NULL,
    description VARCHAR(250) NOT NULL,
    PRIMARY KEY (diagnosis_code)
);

CREATE TABLE DRG
(
    drg_code VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL,
    cost INT NOT NULL,
    average_length_of_stay INT NOT NULL,
    PRIMARY KEY (drg_code),
    CONSTRAINT chk_drg_cost CHECK (cost >= 0),
    CONSTRAINT chk_drg_average_length CHECK (average_length_of_stay >= 0)
);

CREATE TABLE HOSPITALIZATION
(
    hospitalization_id INT NOT NULL AUTO_INCREMENT,
    triage_id INT NOT NULL UNIQUE,
    department_name VARCHAR(50) NOT NULL,
    bed_id INT NOT NULL,
    admission_diagnosis VARCHAR(250) NOT NULL,
    discharge_diagnosis VARCHAR(250) NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    current_cost INT NOT NULL,
    drg_code VARCHAR(50) NOT NULL,
    PRIMARY KEY (hospitalization_id),
    FOREIGN KEY (triage_id) REFERENCES TRIAGE(triage_id),
    FOREIGN KEY (department_name) REFERENCES DEPARTMENT(department_name),
    FOREIGN KEY (bed_id) REFERENCES BEDS(bed_number),
    FOREIGN KEY (admission_diagnosis) REFERENCES DIAGNOSES(diagnosis_code),
    FOREIGN KEY (discharge_diagnosis) REFERENCES DIAGNOSES(diagnosis_code),
    FOREIGN KEY (drg_code) REFERENCES DRG(drg_code),
    CONSTRAINT chk_hospitalization_dates CHECK (discharge_date IS NULL OR admission_date < discharge_date)
);

CREATE TABLE LAB_TESTS
(
    test_type INT NOT NULL,
    test_code VARCHAR(250) NOT NULL,
    description VARCHAR(250) NOT NULL,
    cost INT NOT NULL DEFAULT 100,
    PRIMARY KEY (test_code)
);

CREATE TABLE HOSPITALIZATION_TEST
(
    test_id INT NOT NULL AUTO_INCREMENT,
    test_date DATE NOT NULL,
    result VARCHAR(100) NOT NULL,
    test_code VARCHAR(250) NOT NULL,
    hospitalization_id INT NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY (test_id),
    FOREIGN KEY (test_code) REFERENCES LAB_TESTS(test_code),
    FOREIGN KEY (hospitalization_id) REFERENCES HOSPITALIZATION(hospitalization_id),
    FOREIGN KEY (staff_id) REFERENCES DOCTOR(staff_id)
);

CREATE TABLE MEDICAL_PROCEDURES
(
    procedure_code VARCHAR(250) NOT NULL,
    description VARCHAR(400) NOT NULL,
    category VARCHAR(150) NOT NULL, 
    cost INT NOT NULL DEFAULT 250,
    PRIMARY KEY (procedure_code)
);

CREATE TABLE OPERATING_ROOM
(
    room_id INT NOT NULL,
    media_id INT NOT NULL,
    description VARCHAR(200) NOT NULL,
    FOREIGN KEY (media_id) REFERENCES MEDIA_OPERATING_ROOMS(media_id),
    PRIMARY KEY (room_id)
);

CREATE TABLE HOSPITALIZATION_PROCEDURE
(
    procedure_hospitalization_id INT NOT NULL AUTO_INCREMENT,
    procedure_start_time DATETIME NOT NULL,
    procedure_end_time DATETIME NOT NULL,
    procedure_duration INT NOT NULL DEFAULT 0,
    procedure_code VARCHAR(250) NOT NULL,
    hospitalization_id INT NOT NULL,
    room_id INT NOT NULL,
    PRIMARY KEY (procedure_hospitalization_id),
    UNIQUE (hospitalization_id, procedure_start_time, procedure_end_time),
    FOREIGN KEY (procedure_code) REFERENCES MEDICAL_PROCEDURES(procedure_code),
    FOREIGN KEY (hospitalization_id) REFERENCES HOSPITALIZATION(hospitalization_id),
    FOREIGN KEY (room_id) REFERENCES OPERATING_ROOM(room_id),
    CONSTRAINT chk_procedure_duration CHECK (procedure_end_time > procedure_start_time),
    CONSTRAINT chk_procedure_time_whole_hour CHECK (MINUTE(procedure_start_time) = 0 AND SECOND(procedure_start_time) = 0)
);

CREATE TABLE SURGERY
(
    surgeon_id INT NOT NULL,
    surgery_id INT NOT NULL,
    PRIMARY KEY (surgery_id),
    FOREIGN KEY (surgeon_id) REFERENCES DOCTOR(staff_id),
    FOREIGN KEY (surgery_id) REFERENCES HOSPITALIZATION_PROCEDURE(procedure_hospitalization_id)
);

CREATE TABLE SURGERY_STAFF
(
    staff_id INT NOT NULL,
    procedure_hospitalization_id INT NOT NULL,
    PRIMARY KEY (staff_id, procedure_hospitalization_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id),
    FOREIGN KEY (procedure_hospitalization_id) REFERENCES hospitalization_procedure(procedure_hospitalization_id)
);

CREATE TABLE MEDICATION
(
    medication_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(300) NOT NULL,
    route_of_administration VARCHAR(250) NULL,
    product_authorisation_country VARCHAR(50) NULL,
    marketing_authorisation_holder VARCHAR(250) NULL,
    pharmacovigilance_system_master_file_location VARCHAR(250) NULL,
    pharmacovigilance_email VARCHAR(50) NULL,
    pharmacovigilance_phone VARCHAR(50) NULL,
    PRIMARY KEY (medication_id)
);

CREATE TABLE PRESCRIPTION
(
    prescription_start_date DATE NOT NULL,
    prescription_end_date DATE NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    frequency VARCHAR(50) NOT NULL,
    medication_id INT NOT NULL,
    staff_id INT NOT NULL,
    AMKA BIGINT NOT NULL,
    hospitalization_id INT NOT NULL,
    PRIMARY KEY (medication_id, prescription_start_date, staff_id, AMKA),
    FOREIGN KEY (medication_id) REFERENCES MEDICATION(medication_id),
    FOREIGN KEY (staff_id) REFERENCES DOCTOR(staff_id),
    FOREIGN KEY (AMKA) REFERENCES PATIENTS(AMKA),
    FOREIGN KEY (hospitalization_id) REFERENCES HOSPITALIZATION(hospitalization_id),

    CONSTRAINT chk_prescription_dates CHECK (prescription_start_date <= prescription_end_date)
);



CREATE TABLE ACTIVE_SUBSTANCE
(
    substance_id INT NOT NULL AUTO_INCREMENT,
    substance_name VARCHAR(250) NOT NULL,
    PRIMARY KEY (substance_id)
);

CREATE TABLE MEDICATION_SUBSTANCE
(
    medication_id INT NOT NULL,
    substance_id INT NOT NULL,
    PRIMARY KEY (medication_id, substance_id),
    FOREIGN KEY (medication_id) REFERENCES MEDICATION(medication_id),
    FOREIGN KEY (substance_id) REFERENCES ACTIVE_SUBSTANCE(substance_id)
);

CREATE TABLE ALLERGIC_PATIENTS
(
    substance_id INT NOT NULL,
    AMKA BIGINT NOT NULL,
    PRIMARY KEY (substance_id, AMKA),
    FOREIGN KEY (substance_id) REFERENCES ACTIVE_SUBSTANCE(substance_id),
    FOREIGN KEY (AMKA) REFERENCES PATIENTS(AMKA)
);

CREATE TABLE EVALUATION_HOSPITALIZATION
(
    hospitalization_id INT NOT NULL,
    cleanliness INT NOT NULL,
    nursing_care_quality INT NOT NULL,
    food_quality INT NOT NULL,
    total_expierience INT NOT NULL,
    PRIMARY KEY (hospitalization_id),
    FOREIGN KEY (hospitalization_id) REFERENCES HOSPITALIZATION(hospitalization_id)
);

CREATE TABLE DOCTOR_EVALUATION
(
    hospitalization_id INT NOT NULL,
    doctor_id INT NOT NULL,
    evaluation INT NOT NULL,
    PRIMARY KEY (doctor_id, hospitalization_id),
    FOREIGN KEY (hospitalization_id) REFERENCES HOSPITALIZATION(hospitalization_id),
    FOREIGN KEY (doctor_id) REFERENCES DOCTOR(staff_id)
);


CREATE TABLE TRIAGE_SYMPTOMS
(
    symptom VARCHAR(50) NOT NULL,
    triage_id INT NOT NULL,
    PRIMARY KEY (triage_id, symptom),
    FOREIGN KEY (triage_id) REFERENCES TRIAGE(triage_id)
);


DELIMITER $$

CREATE PROCEDURE check_patient_allergies(IN p_medication_id INT, IN p_amka BIGINT)
BEGIN
    IF EXISTS (
        SELECT 1
        FROM MEDICATION_SUBSTANCE ms
        JOIN ALLERGIC_PATIENTS ap ON ms.substance_id = ap.substance_id
        WHERE ms.medication_id = p_medication_id
          AND ap.AMKA = p_amka
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Patient is allergic to one or more substances in this drug';
    END IF;
END$$

CREATE PROCEDURE check_monthly_duty_limits(IN p_staff_id INT, IN p_shift_id INT)
BEGIN
    DECLARE staff_role VARCHAR(25);
    DECLARE new_shift_date DATE;
    DECLARE counter INT;

    SELECT staff_type INTO staff_role
    FROM STAFF
    WHERE staff_id = p_staff_id;

    SELECT shift_date INTO new_shift_date
    FROM SHIFTS
    WHERE shift_id = p_shift_id;

    SELECT COUNT(*) INTO counter
    FROM DUTY_TEAM d
    JOIN SHIFTS s ON d.shift_id = s.shift_id
    WHERE d.staff_id = p_staff_id
      AND MONTH(s.shift_date) = MONTH(new_shift_date)
      AND YEAR(s.shift_date) = YEAR(new_shift_date);

    IF staff_role = 'doctor' AND counter >= 15 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Every doctor has to do only 15 shifts per month';
    END IF;

    IF staff_role = 'nurse' AND counter >= 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Every nurse has to do only 20 shifts per month';
    END IF;

    IF staff_role = 'administrative staff' AND counter >= 25 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The administrative staff has to do only 25 shifts per month';
    END IF;
END$$

CREATE PROCEDURE check_continuous_night_shifts(IN p_staff_id INT, IN p_shift_id INT)
BEGIN
    DECLARE new_shift_date DATE;
    DECLARE is_night INT;
    DECLARE cnt INT;

    SELECT shift_date,
           CASE WHEN slot = 'night' THEN 1 ELSE 0 END
    INTO new_shift_date, is_night
    FROM SHIFTS
    WHERE shift_id = p_shift_id;

    IF is_night = 1 THEN
        SELECT COUNT(*) INTO cnt
        FROM DUTY_TEAM dt
        JOIN SHIFTS s ON dt.shift_id = s.shift_id
        WHERE dt.staff_id = p_staff_id
          AND s.slot = 'night'
          AND s.shift_date < new_shift_date
          AND s.shift_date >= DATE_SUB(new_shift_date, INTERVAL 3 DAY);

        IF cnt >= 3 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Max 3 consecutive night shifts exceeded';
        END IF;
    END IF;
END$$

CREATE PROCEDURE check_eight_hours_rest(IN p_staff_id INT, IN p_shift_id INT)
BEGIN
    DECLARE ns DATETIME;

    SELECT TIMESTAMP(
        shift_date,
        CASE slot
            WHEN 'morning' THEN '07:00:00'
            WHEN 'afternoon' THEN '15:00:00'
            WHEN 'night' THEN '23:00:00'
        END
    )
    INTO ns
    FROM SHIFTS
    WHERE shift_id = p_shift_id;

    IF EXISTS (
        SELECT 1
        FROM DUTY_TEAM dt
        JOIN SHIFTS s ON s.shift_id = dt.shift_id
        WHERE dt.staff_id = p_staff_id
          AND dt.shift_id != p_shift_id
          AND ABS(
              TIMESTAMPDIFF(
                  HOUR,
                  TIMESTAMP(
                      s.shift_date,
                      CASE s.slot
                          WHEN 'morning' THEN '07:00:00'
                          WHEN 'afternoon' THEN '15:00:00'
                          WHEN 'night' THEN '23:00:00'
                      END
                  ),
                  ns
              )
          ) < 16
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '8 hours rest required between shifts';
    END IF;
END$$

CREATE PROCEDURE auto_update_shift_status(IN p_shift_id INT)
BEGIN
    DECLARE doc_count INT;
    DECLARE nurse_count INT;
    DECLARE admin_count INT;
    DECLARE resident_count INT;
    DECLARE higher_rank_count INT;

    SELECT
        COALESCE(SUM(CASE WHEN s.staff_type = 'doctor' THEN 1 ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN s.staff_type = 'nurse' THEN 1 ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN s.staff_type = 'administrative staff' THEN 1 ELSE 0 END), 0)
    INTO doc_count, nurse_count, admin_count
    FROM DUTY_TEAM t
    JOIN STAFF s ON t.staff_id = s.staff_id
    WHERE t.shift_id = p_shift_id;

    SELECT
        COALESCE(SUM(CASE WHEN d.`rank` = 1 THEN 1 ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN d.`rank` IN (3, 4) THEN 1 ELSE 0 END), 0)
    INTO resident_count, higher_rank_count
    FROM DUTY_TEAM t
    JOIN DOCTOR d ON d.staff_id = t.staff_id
    WHERE t.shift_id = p_shift_id;

    IF doc_count >= 3
       AND nurse_count >= 6
       AND admin_count >= 2
       AND (resident_count = 0 OR higher_rank_count > 0) THEN
        UPDATE SHIFTS
        SET shift_status = 'full'
        WHERE shift_id = p_shift_id
          AND shift_status = 'not full';
    ELSE
        UPDATE SHIFTS
        SET shift_status = 'not full'
        WHERE shift_id = p_shift_id
          AND shift_status = 'full';
    END IF;
END$$

CREATE TRIGGER supervision_chain
BEFORE INSERT ON DOCTOR
FOR EACH ROW
BEGIN
    DECLARE sup_rank INT;

    IF NEW.supervisor IS NOT NULL THEN
        SELECT `rank` INTO sup_rank
        FROM DOCTOR
        WHERE staff_id = NEW.supervisor;

        IF NEW.`rank` >= sup_rank THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Supervisor must have higher rank';
        END IF;
    END IF;
END$$

CREATE TRIGGER beds_inc
AFTER INSERT ON BEDS
FOR EACH ROW
BEGIN
    UPDATE DEPARTMENT
    SET bed_count = bed_count + 1
    WHERE department_name = NEW.department_name;
END$$

CREATE TRIGGER beds_dec
AFTER DELETE ON BEDS
FOR EACH ROW
BEGIN
    UPDATE DEPARTMENT
    SET bed_count = bed_count - 1
    WHERE department_name = OLD.department_name;
END$$

CREATE TRIGGER staff_rest_eighthours
BEFORE INSERT ON DUTY_TEAM
FOR EACH ROW
BEGIN
    DECLARE ns DATETIME;

    SELECT TIMESTAMP(
        shift_date,
        CASE slot
            WHEN 'morning' THEN '07:00:00'
            WHEN 'afternoon' THEN '15:00:00'
            WHEN 'night' THEN '23:00:00'
        END
    )
    INTO ns
    FROM SHIFTS
    WHERE shift_id = NEW.shift_id;

    IF EXISTS (
        SELECT 1
        FROM DUTY_TEAM dt
        JOIN SHIFTS s ON s.shift_id = dt.shift_id
        WHERE dt.staff_id = NEW.staff_id
          AND ABS(
              TIMESTAMPDIFF(
                  HOUR,
                  TIMESTAMP(
                      s.shift_date,
                      CASE s.slot
                          WHEN 'morning' THEN '07:00:00'
                          WHEN 'afternoon' THEN '15:00:00'
                          WHEN 'night' THEN '23:00:00'
                      END
                  ),
                  ns
              )
          ) < 16
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '8 hours rest required';
    END IF;
END$$

CREATE TRIGGER allergic_drugs_ins
BEFORE INSERT ON PRESCRIPTION
FOR EACH ROW
BEGIN
    CALL check_patient_allergies(NEW.medication_id, NEW.AMKA);
END$$

CREATE TRIGGER allergic_drugs_upd
BEFORE UPDATE ON PRESCRIPTION
FOR EACH ROW
BEGIN
    CALL check_patient_allergies(NEW.medication_id, NEW.AMKA);
END$$

CREATE TRIGGER evaluation_hosp
BEFORE INSERT ON EVALUATION_HOSPITALIZATION
FOR EACH ROW
BEGIN
    DECLARE d_date DATE;

    SELECT h.discharge_date INTO d_date
    FROM HOSPITALIZATION h
    WHERE h.hospitalization_id = NEW.hospitalization_id;

    IF d_date IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You cannot evaluate before you leave the hospital';
    END IF;
END$$

CREATE TRIGGER evaluation_doctor
BEFORE INSERT ON DOCTOR_EVALUATION
FOR EACH ROW
BEGIN
    DECLARE d_date DATE;
    DECLARE patient_amka BIGINT;

    SELECT t.AMKA, h.discharge_date
    INTO patient_amka, d_date
    FROM HOSPITALIZATION h
    JOIN TRIAGE t ON h.triage_id = t.triage_id
    WHERE h.hospitalization_id = NEW.hospitalization_id;

    IF NOT EXISTS (
        SELECT 1
        FROM PRESCRIPTION p
        WHERE p.staff_id = NEW.doctor_id
          AND p.AMKA = patient_amka
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You cannot evaluate a doctor that did not prescribe you';
    END IF;

    IF d_date IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You cannot evaluate a doctor before you leave';
    END IF;
END$$

CREATE TRIGGER duty_limit_monthly_ins
BEFORE INSERT ON DUTY_TEAM
FOR EACH ROW
BEGIN
    CALL check_monthly_duty_limits(NEW.staff_id, NEW.shift_id);
END$$

CREATE TRIGGER duty_limit_monthly_upd
BEFORE UPDATE ON DUTY_TEAM
FOR EACH ROW
BEGIN
    CALL check_monthly_duty_limits(NEW.staff_id, NEW.shift_id);
END$$

CREATE TRIGGER duty_limit_continuous_nights_ins
BEFORE INSERT ON DUTY_TEAM
FOR EACH ROW
BEGIN
    CALL check_continuous_night_shifts(NEW.staff_id, NEW.shift_id);
END$$

CREATE TRIGGER duty_limit_continuous_nights_upd
BEFORE UPDATE ON DUTY_TEAM
FOR EACH ROW
BEGIN
    CALL check_continuous_night_shifts(NEW.staff_id, NEW.shift_id);
END$$

CREATE TRIGGER duty_rest_ins
BEFORE INSERT ON DUTY_TEAM
FOR EACH ROW
BEGIN
    CALL check_eight_hours_rest(NEW.staff_id, NEW.shift_id);
END$$

CREATE TRIGGER duty_rest_upd
BEFORE UPDATE ON DUTY_TEAM
FOR EACH ROW
BEGIN
    CALL check_eight_hours_rest(NEW.staff_id, NEW.shift_id);
END$$

CREATE TRIGGER valid_team
BEFORE UPDATE ON SHIFTS
FOR EACH ROW
BEGIN
    DECLARE doc_count INT;
    DECLARE nurse_count INT;
    DECLARE admin_count INT;
    DECLARE resident_count INT;
    DECLARE higher_rank_count INT;

    IF NEW.shift_status = 'full' THEN
        SELECT
            COALESCE(SUM(CASE WHEN s.staff_type = 'doctor' THEN 1 ELSE 0 END), 0),
            COALESCE(SUM(CASE WHEN s.staff_type = 'nurse' THEN 1 ELSE 0 END), 0),
            COALESCE(SUM(CASE WHEN s.staff_type = 'administrative staff' THEN 1 ELSE 0 END), 0)
        INTO doc_count, nurse_count, admin_count
        FROM DUTY_TEAM t
        JOIN STAFF s ON t.staff_id = s.staff_id
        WHERE t.shift_id = NEW.shift_id;

        IF doc_count < 3 OR nurse_count < 6 OR admin_count < 2 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid shift team composition';
        END IF;

        SELECT
            COALESCE(SUM(CASE WHEN d.`rank` = 1 THEN 1 ELSE 0 END), 0),
            COALESCE(SUM(CASE WHEN d.`rank` IN (3, 4) THEN 1 ELSE 0 END), 0)
        INTO resident_count, higher_rank_count
        FROM DUTY_TEAM t
        JOIN DOCTOR d ON d.staff_id = t.staff_id
        WHERE t.shift_id = NEW.shift_id;

        IF resident_count > 0 AND higher_rank_count = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No high ranking doctor when resident present';
        END IF;
    END IF;
END$$

CREATE TRIGGER auto_shift_full_ins
AFTER INSERT ON DUTY_TEAM
FOR EACH ROW
BEGIN
    CALL auto_update_shift_status(NEW.shift_id);
END$$

CREATE TRIGGER auto_shift_full_upd
AFTER UPDATE ON DUTY_TEAM
FOR EACH ROW
BEGIN
    CALL auto_update_shift_status(NEW.shift_id);

    IF OLD.shift_id != NEW.shift_id THEN
        CALL auto_update_shift_status(OLD.shift_id);
    END IF;
END$$

CREATE PROCEDURE calculate_hospitalization_cost(
    IN p_drg_code VARCHAR(50),
    IN p_admission_date DATE,
    IN p_discharge_date DATE,
    OUT p_calculated_cost INT
)
BEGIN
    DECLARE stay_time INT;
    DECLARE mdn_cost INT;
    DECLARE mdn INT;

    SELECT average_length_of_stay, cost
    INTO mdn, mdn_cost
    FROM DRG
    WHERE drg_code = p_drg_code;

    IF p_discharge_date IS NOT NULL THEN
        SET stay_time = DATEDIFF(p_discharge_date, p_admission_date);

        IF stay_time > mdn THEN
            SET p_calculated_cost = mdn_cost + (mdn_cost / mdn) * (stay_time - mdn);
        ELSE
            SET p_calculated_cost = mdn_cost;
        END IF;
    ELSE 
        SET p_calculated_cost = mdn_cost;
    END IF;
END$$


CREATE TRIGGER final_cost_ins
BEFORE INSERT ON HOSPITALIZATION
FOR EACH ROW
BEGIN
    DECLARE temp_cost INT;

    CALL calculate_hospitalization_cost(NEW.drg_code, NEW.admission_date, NEW.discharge_date, temp_cost);

    SET NEW.current_cost = temp_cost;
END$$

CREATE TRIGGER final_cost_upd
BEFORE UPDATE ON HOSPITALIZATION
FOR EACH ROW
BEGIN
    DECLARE temp_cost INT;

    CALL calculate_hospitalization_cost(NEW.drg_code, NEW.admission_date, NEW.discharge_date, temp_cost);

    SET NEW.current_cost = temp_cost;
END$$

CREATE TRIGGER ensure_bed_is_free
 BEFORE INSERT on HOSPITALIZATION
 FOR EACH ROW BEGIN
    declare bed_stat CHAR(30);
    IF new.discharge_date is NULL OR new.discharge_date > CURRENT_DATE()
    THEN 
    select status
    into bed_stat
    from BEDS
    where  NEW.bed_id = bed_number;

    IF bed_stat <> 'not occupied' then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This bed is not available for hospitalization';
     END IF;

    UPDATE BEDS
      set status = 'occupied'
      WHERE bed_number = new.bed_id ; 
    END IF; 
END$$



CREATE TRIGGER free_bed
AFTER UPDATE on HOSPITALIZATION
FOR EACH ROW
BEGIN
IF OLD.discharge_date is NULL AND NEW.discharge_date is not NULL AND NEW.discharge_date <= CURRENT_DATE() 
THEN
    UPDATE BEDS 
    set status = 'not occupied'
    where bed_number  = NEW.bed_id ; 
END IF; 
END$$

CREATE PROCEDURE check_is_surgeon (IN p_surgeon_id INT)
    BEGIN 
    declare spec char(40);
    select specialty
    into spec
    FROM DOCTOR 
    where staff_id = p_surgeon_id; 

    IF spec NOT IN ('Neurosurgeon', 'Gynecology') THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Only surgeons can do surgeries';
    END IF;
END$$

CREATE TRIGGER is_surgeon_insert
BEFORE INSERT ON SURGERY
FOR EACH ROW 
BEGIN 
 CALL check_is_surgeon(NEW.surgeon_id);
END$$

CREATE TRIGGER is_surgeon_update
BEFORE UPDATE ON SURGERY
FOR EACH ROW 
BEGIN 
 CALL check_is_surgeon(NEW.surgeon_id);
END$$

CREATE TRIGGER trg_hosp_proc_duration_before_insert
BEFORE INSERT ON HOSPITALIZATION_PROCEDURE
FOR EACH ROW
BEGIN
    SET NEW.procedure_duration =
        TIMESTAMPDIFF(MINUTE, NEW.procedure_start_time, NEW.procedure_end_time);
END$$

CREATE TRIGGER trg_hosp_proc_duration_before_update
BEFORE UPDATE ON HOSPITALIZATION_PROCEDURE
FOR EACH ROW
BEGIN
    SET NEW.procedure_duration =
        TIMESTAMPDIFF(MINUTE, NEW.procedure_start_time, NEW.procedure_end_time);
END$$

CREATE TRIGGER multiple_hospital_procedures_in_one_room
BEFORE INSERT ON HOSPITALIZATION_PROCEDURE
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM HOSPITALIZATION_PROCEDURE h
        WHERE h.room_id = NEW.room_id
          AND NEW.procedure_start_time < h.procedure_end_time
          AND NEW.procedure_end_time > h.procedure_start_time
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Two procedures cannot happen in the same room at the same time';
    END IF;
END$$

CREATE TRIGGER multiple_hospital_procedures_in_one_room_update
BEFORE UPDATE ON HOSPITALIZATION_PROCEDURE
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM HOSPITALIZATION_PROCEDURE h
        WHERE h.room_id = NEW.room_id
          AND NEW.procedure_start_time < h.procedure_end_time
          AND NEW.procedure_end_time > h.procedure_start_time
          AND h.procedure_hospitalization_id <> OLD.procedure_hospitalization_id
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Two procedures cannot happen in the same room at the same time';
    END IF;
END$$

CREATE TRIGGER one_surgeon_two_places_at_the_same_time
BEFORE INSERT ON SURGERY
FOR EACH ROW
BEGIN
    DECLARE new_start_time DATETIME;
    DECLARE new_end_time DATETIME;

    SELECT hp.procedure_start_time, hp.procedure_end_time
    INTO new_start_time, new_end_time
    FROM HOSPITALIZATION_PROCEDURE hp
    WHERE hp.procedure_hospitalization_id = NEW.surgery_id;

    IF EXISTS (
        SELECT 1
        FROM SURGERY s
        JOIN HOSPITALIZATION_PROCEDURE hp
          ON hp.procedure_hospitalization_id = s.surgery_id
        WHERE s.surgeon_id = NEW.surgeon_id
          AND new_start_time < hp.procedure_end_time
          AND new_end_time > hp.procedure_start_time
          AND s.surgery_id <> NEW.surgery_id
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'One doctor cannot be in two rooms at the same time';
    END IF;
END$$

CREATE TRIGGER one_surgeon_two_places_at_the_same_time_update
BEFORE UPDATE ON SURGERY
FOR EACH ROW
BEGIN
    DECLARE new_start_time DATETIME;
    DECLARE new_end_time DATETIME;

    SELECT hp.procedure_start_time, hp.procedure_end_time
    INTO new_start_time, new_end_time
    FROM HOSPITALIZATION_PROCEDURE hp
    WHERE hp.procedure_hospitalization_id = NEW.surgery_id;

    IF EXISTS (
        SELECT 1
        FROM SURGERY s
        JOIN HOSPITALIZATION_PROCEDURE hp
          ON hp.procedure_hospitalization_id = s.surgery_id
        WHERE s.surgeon_id = NEW.surgeon_id
          AND new_start_time < hp.procedure_end_time
          AND new_end_time > hp.procedure_start_time
          AND s.surgery_id <> OLD.surgery_id
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'One doctor cannot be in two rooms at the same time';
    END IF;
END$$

CREATE PROCEDURE check_staff_correct_department(IN p_staff_id INT, IN p_shift_id INT)
BEGIN
    DECLARE stafftype VARCHAR(25);
    DECLARE shiftdep VARCHAR(50);
    DECLARE staffdep VARCHAR(50);

    SELECT staff_type
    INTO stafftype
    FROM STAFF
    WHERE staff_id = p_staff_id;

    SELECT department_name
    INTO shiftdep
    FROM SHIFTS
    WHERE shift_id = p_shift_id;

    IF stafftype = 'doctor' THEN
        IF NOT EXISTS (
            SELECT 1
            FROM DOCTOR_DEPARTMENT
            WHERE staff_id = p_staff_id
              AND department_name = shiftdep
        ) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'This doctor cannot do a shift that is not in their department';
        END IF;

    ELSEIF stafftype = 'nurse' THEN
        SELECT department_name
        INTO staffdep
        FROM NURSES
        WHERE staff_id = p_staff_id;

        IF staffdep IS NULL OR shiftdep IS NULL OR staffdep <> shiftdep THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'This nurse cannot do a shift that is not in their department';
        END IF;

    ELSEIF stafftype = 'administrative staff' THEN
        SELECT department_name
        INTO staffdep
        FROM ADMINISTRATIVE_STAFF
        WHERE staff_id = p_staff_id;

        IF staffdep IS NULL OR shiftdep IS NULL OR staffdep <> shiftdep THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'This administrative staff cannot do a shift that is not in their department';
        END IF;
    END IF;
END$$

CREATE TRIGGER shift_staff_correct_department_ins
BEFORE INSERT ON DUTY_TEAM
FOR EACH ROW
BEGIN
    CALL check_staff_correct_department(NEW.staff_id, NEW.shift_id);
END$$

CREATE TRIGGER shift_staff_correct_department_upd
BEFORE UPDATE ON DUTY_TEAM
FOR EACH ROW
BEGIN
    CALL check_staff_correct_department(NEW.staff_id, NEW.shift_id);
END$$

CREATE PROCEDURE get_waiting_patients(IN num_of_patients INT)
BEGIN
    SELECT p.AMKA,
           p.first_name,
           p.last_name,
           tr.urgency_level,
           tr.arrival_time
    FROM TRIAGE tr
    JOIN PATIENTS p ON tr.AMKA = p.AMKA
    WHERE tr.service_time IS NULL
    ORDER BY tr.urgency_level ASC, tr.arrival_time ASC
    LIMIT num_of_patients;
END$$

DELIMITER ;

CREATE INDEX idx_shifts_date_slot ON SHIFTS(shift_date, slot);

CREATE INDEX idx_triage_waiting ON TRIAGE(service_time, urgency_level, arrival_time);

CREATE INDEX idx_triage_urgency ON TRIAGE(urgency_level);