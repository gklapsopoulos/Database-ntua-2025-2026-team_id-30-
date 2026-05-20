WITH doc_surgeries AS (
    SELECT sur.surgeon_id, COUNT(*) AS total_surgeries
    FROM SURGERY sur
    JOIN HOSPITALIZATION_PROCEDURE hp ON sur.surgery_id = hp.procedure_hospitalization_id
    WHERE YEAR(hp.procedure_start_time) = YEAR(CURRENT_DATE)
    GROUP BY sur.surgeon_id
)
SELECT 
    s.AMKA, 
    s.first_name, 
    s.last_name,
    COALESCE(ds.total_surgeries, 0) AS surgeries_done
FROM STAFF s
JOIN DOCTOR d ON s.staff_id = d.staff_id
LEFT OUTER JOIN doc_surgeries ds ON s.staff_id = ds.surgeon_id
WHERE COALESCE(ds.total_surgeries, 0) <= (
    SELECT MAX(total_surgeries)-5 
    FROM doc_surgeries
);