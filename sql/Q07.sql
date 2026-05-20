SELECT act.substance_name, 
    COUNT(ap.AMKA) AS num_of_allergic_patients,
    (
    SELECT COUNT(*)
    FROM MEDICATION_SUBSTANCE
    WHERE substance_id = act.substance_id
    ) AS num_of_medication_with_substance
FROM ALLERGIC_PATIENTS AS ap
RIGHT OUTER JOIN ACTIVE_SUBSTANCE AS act ON ap.substance_id = act.substance_id 
GROUP BY act.substance_id
ORDER BY num_of_allergic_patients DESC;