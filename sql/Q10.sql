SELECT ms1.substance_id AS substance_id_1, 
       ms2.substance_id AS substance_id_2,
       asub1.substance_name AS substance_name_1,
       asub2.substance_name AS substance_name_2,
       COUNT(DISTINCT p1.hospitalization_id) AS frequency 
FROM MEDICATION_SUBSTANCE ms1
JOIN PRESCRIPTION p1 ON p1.medication_id = ms1.medication_id
JOIN PRESCRIPTION p2 ON p2.hospitalization_id = p1.hospitalization_id
JOIN MEDICATION_SUBSTANCE ms2 ON p2.medication_id = ms2.medication_id AND ms1.substance_id < ms2.substance_id
JOIN ACTIVE_SUBSTANCE asub1 ON ms1.substance_id = asub1.substance_id 
JOIN ACTIVE_SUBSTANCE asub2 ON ms2.substance_id = asub2.substance_id 
GROUP BY ms1.substance_id, ms2.substance_id
ORDER BY frequency DESC
LIMIT 3;