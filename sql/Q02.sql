SELECT s.last_name,
       s.first_name,
       s.AMKA,

        CASE 
            WHEN EXISTS 
            (
                SELECT 1 
                FROM SHIFTS sh
                JOIN DUTY_TEAM dt ON dt.shift_id  = sh.shift_id
                WHERE s.staff_id = dt.staff_id 
                AND YEAR(sh.shift_date) = YEAR(CURRENT_DATE)
                AND sh.shift_date < CURRENT_DATE
                AND sh.shift_status = "full" 
            )
            THEN 'YES'
            ELSE 'NO'
            END  AS shift_current_year,
       (
        SELECT COUNT(*) 
        FROM SURGERY
        WHERE surgeon_id = s.staff_id
       ) 
       AS surgery_count
FROM staff s
JOIN doctor d ON s.staff_id = d.staff_id
WHERE d.specialty = "Neurosurgeon";