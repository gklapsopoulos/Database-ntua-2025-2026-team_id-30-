WITH urgency_level_stats AS (
    SELECT 
        tr.urgency_level,
        COUNT(*) AS number_of_cases,
        AVG(TIMESTAMPDIFF(MINUTE, tr.arrival_time, tr.service_time)) AS avg_wait_time,
        (COUNT(ho.hospitalization_id) * 100.0 / COUNT(*)) AS admission_percentage
    FROM triage tr
    LEFT OUTER JOIN hospitalization ho ON tr.triage_id = ho.triage_id
    GROUP BY tr.urgency_level
),
department_urg_level_stats AS (
    SELECT 
        tr.urgency_level,
        ho.department_name,
        COUNT(*) AS dept_referrals
    FROM triage tr
    LEFT OUTER JOIN hospitalization ho ON tr.triage_id = ho.triage_id
    GROUP BY tr.urgency_level, ho.department_name
)
SELECT 
    uls.urgency_level,
    uls.number_of_cases,
    uls.admission_percentage,
    CASE WHEN ds.department_name IS NULL THEN 'Not Admitted' ELSE ds.department_name END AS department_name,
    ds.dept_referrals
FROM urgency_level_stats uls
JOIN department_urg_level_stats ds ON uls.urgency_level = ds.urgency_level
ORDER BY uls.urgency_level ASC, ds.dept_referrals DESC;