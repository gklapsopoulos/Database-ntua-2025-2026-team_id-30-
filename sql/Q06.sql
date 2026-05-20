SELECT h.department_name,
       h.admission_date,
       h.discharge_date,
       h.admission_diagnosis,
       d1.description, 
       h.discharge_diagnosis, 
       d2.description, 
       h.current_cost, 
       he.total_expierience
FROM HOSPITALIZATION h 
JOIN  TRIAGE t ON h.triage_id = t.triage_id
JOIN DIAGNOSES d1 ON h.admission_diagnosis = d1.diagnosis_code
JOIN DIAGNOSES d2 ON h.discharge_diagnosis = d2.diagnosis_code 
JOIN EVALUATION_HOSPITALIZATION he ON h.hospitalization_id = he.hospitalization_id 
WHERE t.AMKA = 10061102069;