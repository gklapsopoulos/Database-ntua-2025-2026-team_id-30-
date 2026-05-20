-- Load all data from the single final CSV folder.
-- Run after schema and triggers.

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/MEDIA_STAFF.csv'
INTO TABLE MEDIA_STAFF
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(media_id, description, URL);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/MEDIA_OPERATING_ROOMS.csv'
INTO TABLE MEDIA_OPERATING_ROOMS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(media_id, description, URL);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/MEDIA_DEPARTMENT.csv'
INTO TABLE MEDIA_DEPARTMENT
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(media_id, description, URL);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/STAFF.csv'
INTO TABLE STAFF
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(staff_id, AMKA, email, hire_date, age, last_name, first_name, staff_type, media_id, working_status);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/STAFF_PHONE.csv'
INTO TABLE STAFF_PHONE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(phone, staff_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/DOCTOR_RANKS.csv'
INTO TABLE DOCTOR_RANKS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(`rank`, description);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/DOCTOR.csv'
INTO TABLE DOCTOR
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(supervisor, medical_license_number, specialty, `rank`, staff_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/DEPARTMENT.csv'
INTO TABLE DEPARTMENT
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(department_name, description, floor, building, bed_count, director_id, media_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/NURSES.csv'
INTO TABLE NURSES
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(`rank`, staff_id, department_name);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/ADMINISTRATIVE_STAFF.csv'
INTO TABLE ADMINISTRATIVE_STAFF
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(role, office, staff_id, department_name);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/DOCTOR_DEPARTMENT.csv'
INTO TABLE DOCTOR_DEPARTMENT
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(department_name, staff_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/PATIENTS.csv'
INTO TABLE PATIENTS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(AMKA, last_name, first_name, father_name, age, gender, weight, height, street, street_number, city, insurance_provider, email, profession, nationality);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/PATIENT_PHONE.csv'
INTO TABLE PATIENT_PHONE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(phone, AMKA);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/PATIENT_RELATIVES.csv'
INTO TABLE PATIENT_RELATIVES
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(relative_id, last_name, first_name, relationship, AMKA);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/RELATIVE_PHONE.csv'
INTO TABLE RELATIVE_PHONE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(phone, relative_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/BEDS.csv'
INTO TABLE BEDS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(bed_number, type, status, department_name);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/SHIFTS.csv'
INTO TABLE SHIFTS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(shift_id, shift_date, slot, department_name, shift_status);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/DUTY_TEAM.csv'
INTO TABLE DUTY_TEAM
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(staff_id, shift_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/DIAGNOSES.csv'
INTO TABLE DIAGNOSES
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(diagnosis_code, description);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/DRG.csv'
INTO TABLE DRG
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(drg_code, description, cost, average_length_of_stay);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/LAB_TESTS.csv'
INTO TABLE LAB_TESTS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(test_type, test_code, description, cost);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/MEDICAL_PROCEDURES.csv'
INTO TABLE MEDICAL_PROCEDURES
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(procedure_code, description, category, cost);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/MEDICATION.csv'
INTO TABLE MEDICATION
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(medication_id, product_name, route_of_administration, product_authorisation_country, marketing_authorisation_holder, pharmacovigilance_system_master_file_location, pharmacovigilance_email, pharmacovigilance_phone);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/ACTIVE_SUBSTANCE.csv'
INTO TABLE ACTIVE_SUBSTANCE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(substance_id, substance_name);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/MEDICATION_SUBSTANCE.csv'
INTO TABLE MEDICATION_SUBSTANCE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(medication_id, substance_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/ALLERGIC_PATIENTS.csv'
INTO TABLE ALLERGIC_PATIENTS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(substance_id, AMKA);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/OPERATING_ROOM.csv'
INTO TABLE OPERATING_ROOM
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(room_id, media_id, description);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/TRIAGE.csv'
INTO TABLE TRIAGE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(triage_id, urgency_level, arrival_time, service_time, AMKA, staff_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/HOSPITALIZATION.csv'
INTO TABLE HOSPITALIZATION
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(hospitalization_id, triage_id, department_name, bed_id, admission_diagnosis, discharge_diagnosis, admission_date, discharge_date, current_cost, drg_code);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/TRIAGE_SYMPTOMS.csv'
INTO TABLE TRIAGE_SYMPTOMS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(symptom, triage_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/HOSPITALIZATION_TEST.csv'
INTO TABLE HOSPITALIZATION_TEST
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(test_id, test_date, result, test_code, hospitalization_id, staff_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/HOSPITALIZATION_PROCEDURE.csv'
INTO TABLE HOSPITALIZATION_PROCEDURE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(procedure_hospitalization_id, procedure_start_time, procedure_end_time, procedure_duration, procedure_code, hospitalization_id, room_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/SURGERY.csv'
INTO TABLE SURGERY
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(surgeon_id, surgery_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/SURGERY_STAFF.csv'
INTO TABLE SURGERY_STAFF
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(staff_id, procedure_hospitalization_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/PRESCRIPTION.csv'
INTO TABLE PRESCRIPTION
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(prescription_start_date, prescription_end_date, dosage, frequency, medication_id, staff_id, AMKA, hospitalization_id);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/EVALUATION_HOSPITALIZATION.csv'
INTO TABLE EVALUATION_HOSPITALIZATION
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(hospitalization_id, cleanliness, nursing_care_quality, food_quality, total_expierience);

LOAD DATA INFILE 'C:/Users/keman/OneDrive/Dokumenty/dedomena_final/DOCTOR_EVALUATION.csv'
INTO TABLE DOCTOR_EVALUATION
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(hospitalization_id, doctor_id, evaluation);
