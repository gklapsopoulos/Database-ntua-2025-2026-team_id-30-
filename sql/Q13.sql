WITH RECURSIVE supervisor_chain AS (

    SELECT 
        d.staff_id AS start_doc,
        d.staff_id AS current_doc,
        d.supervisor,
        dr.description AS doctor_ranks,
        0 AS lvl
    FROM doctor d
    JOIN doctor_ranks dr
        ON dr.rank = d.rank

    UNION ALL


    SELECT 
        sc.start_doc,
        d.staff_id AS current_doc,
        d.supervisor,
        dr.description AS doctor_ranks,
        sc.lvl + 1 AS lvl
    FROM supervisor_chain sc
    JOIN doctor d
        ON d.staff_id = sc.supervisor
    JOIN doctor_ranks dr
        ON dr.rank = d.rank
)

SELECT *
FROM supervisor_chain
ORDER BY start_doc, lvl;