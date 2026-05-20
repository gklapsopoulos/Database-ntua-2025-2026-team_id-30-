WITH Patient_Yearly_Stay AS (
    SELECT 
        YEAR(h.admission_date) AS year, 
        p.first_name, 
        p.last_name, 
        p.AMKA, 
        SUM(DATEDIFF(h.discharge_date, h.admission_date)) AS total_days
    FROM PATIENTS p
    JOIN TRIAGE t ON p.AMKA = t.AMKA
    JOIN HOSPITALIZATION h ON t.triage_id = h.triage_id
    WHERE h.discharge_date IS NOT NULL
    GROUP BY YEAR(h.admission_date), p.AMKA, p.first_name, p.last_name
    HAVING SUM(DATEDIFF(h.discharge_date, h.admission_date)) > 15
),
Same_Durations AS (
    SELECT YEAR, total_days
    FROM Patient_Yearly_Stay
    GROUP BY YEAR, total_days
    HAVING COUNT(*) > 1
)
SELECT p1.*
FROM Patient_Yearly_Stay p1
JOIN Same_Durations p2 ON p1.YEAR = p2.YEAR AND p1.total_days = p2.total_days
ORDER BY p1.YEAR, p1.total_days, p1.last_name;