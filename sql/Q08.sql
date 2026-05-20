SET @dept_name = 'Cardiology';
SET @shift_day = '2026-05-10';

SELECT s.AMKA,
       s.last_name,
       s.first_name,
       s.staff_type 
FROM (
    SELECT dd.staff_id AS staff_id
    FROM DOCTOR_DEPARTMENT dd
    WHERE dd.department_name = @dept_name 

    UNION 

    SELECT n.staff_id 
    FROM NURSES n
    WHERE n.department_name = @dept_name

    UNION 

    SELECT adm.staff_id 
    FROM ADMINISTRATIVE_STAFF adm
    WHERE adm.department_name = @dept_name
    ) AS department_staff_id
JOIN STAFF s ON s.staff_id = department_staff_id.staff_id
WHERE NOT EXISTS(
    SELECT 1
    FROM DUTY_TEAM dt
    JOIN SHIFTS sh ON dt.shift_id = sh.shift_id
    WHERE s.staff_id = dt.staff_id
    AND sh.shift_date = @shift_day
    AND sh.department_name = @dept_name 
);