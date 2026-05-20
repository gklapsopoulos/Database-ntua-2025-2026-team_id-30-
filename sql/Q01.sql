SELECT YEAR(h.admission_date) AS year, 
    h.department_name AS department_name, 
    h.drg_code AS KEN, 
    p.insurance_provider AS insurance_provider,
    COUNT(*) AS hospitalization_count,
    COUNT(*) * 
    (
    SELECT cost
    FROM DRG
    WHERE drg_code = h.drg_code 
    ) AS base_cost,
    SUM(current_cost) - COUNT(*) * 
    (
    SELECT cost
    FROM DRG
    WHERE drg_code = h.drg_code 
    ) AS extra_cost,
    SUM(current_cost) AS Total_Cost 
FROM hospitalization h 
JOIN triage AS t ON h.triage_id = t.triage_id
JOIN patients p ON p.AMKA = t.AMKA
WHERE h.discharge_date IS NOT NULL
GROUP BY YEAR(h.admission_date), 
    h.department_name,
    h.drg_code, 
    p.insurance_provider;