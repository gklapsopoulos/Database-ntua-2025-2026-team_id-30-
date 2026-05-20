SELECT s.AMKA,
    s.last_name,
    s.first_name,
    (
        SELECT AVG(evaluation)
        FROM DOCTOR_EVALUATION de
        WHERE de.doctor_id = s.staff_id
        )AS  average_doctor_evaluation,
    (
        SELECT AVG(total_expierience)
        FROM EVALUATION_HOSPITALIZATION eh
        WHERE eh.hospitalization_id IN (
            SELECT hp.hospitalization_id AS hospitalization_id
            FROM SURGERY sur
            NATURAL JOIN HOSPITALIZATION_PROCEDURE hp
            WHERE sur.surgeon_id = s.staff_id 

            UNION 

            SELECT hospitalization_id AS hospitalization_id
            FROM HOSPITALIZATION_TEST
            WHERE s.staff_id = staff_id

            UNION 

            SELECT hospitalization_id AS hospitalization_id
            FROM PRESCRIPTION
            WHERE s.staff_id = staff_id
        )
    ) AS average_total_expierience
FROM STAFF s 
WHERE s.staff_id = '5';