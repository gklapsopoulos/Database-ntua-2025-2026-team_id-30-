WITH number_of_diagnoses_per_year AS (
    SELECT 
        admission_diagnosis AS diagnosis_category, 
        COUNT(*) AS number_of_cases, 
        YEAR(admission_date) AS diag_year
    FROM HOSPITALIZATION
    GROUP BY admission_diagnosis, YEAR(admission_date)
    HAVING COUNT(*) >= 5
)
SELECT DISTINCT nd1.diagnosis_category, nd1.diag_year AS year1, nd1.diag_year+1 AS year2, nd1.number_of_cases
FROM number_of_diagnoses_per_year nd1
WHERE EXISTS (
    SELECT 1 
    FROM  number_of_diagnoses_per_year nd2
    WHERE nd1.diagnosis_category = nd2.diagnosis_category
      AND nd1.number_of_cases = nd2.number_of_cases       
      AND nd1.diag_year = nd2.diag_year - 1            
);