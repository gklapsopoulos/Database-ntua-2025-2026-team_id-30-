SELECT 
    sh.department_name,
    sh.shift_date,
    sh.slot,
    all_personnel.staff_type, 
    all_personnel.subtype,
    COUNT(*) AS number_of_personnel 
FROM SHIFTS sh
JOIN DUTY_TEAM dt ON sh.shift_id = dt.shift_id
JOIN 
(
    SELECT staff_id, 'doctor' AS staff_type, specialty AS subtype
    FROM DOCTOR

    UNION ALL

    SELECT staff_id, 'nurse' AS staff_type, `rank` AS subtype
    FROM NURSES

    UNION ALL

    SELECT staff_id, 'administrative staff' AS staff_type, role AS subtype
    FROM ADMINISTRATIVE_STAFF 
) AS all_personnel ON dt.staff_id = all_personnel.staff_id
WHERE sh.shift_date >= DATE '2026-05-18'
  AND sh.shift_date < DATE '2026-05-18' + INTERVAL 7 DAY
GROUP BY 
    sh.department_name, 
    sh.shift_date,
    sh.slot,
    all_personnel.staff_type, 
    all_personnel.subtype
ORDER BY 
    sh.department_name, 
    sh.shift_date, 
    sh.slot, 
    all_personnel.staff_type;