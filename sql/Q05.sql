SELECT d.staff_id, st.first_name, st.last_name, COUNT(*) AS total_surgeries
FROM doctor d
JOIN staff st ON st.staff_id=d.staff_id
JOIN surgery s ON s.surgeon_id=d.staff_id 
WHERE st.age<35
GROUP BY d.staff_id
ORDER BY COUNT(*) DESC;