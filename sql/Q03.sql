SELECT 
p.AMKA,
SUM(h.current_cost) AS total_cost,
h.department_name

FROM patients p
JOIN triage t ON p.AMKA=t.AMKA
JOIN hospitalization h ON h.triage_id=t.triage_id
GROUP BY p.AMKA, h.department_name
HAVING COUNT(*)>3;