#===============
# TP 4
#-------

USE hr;

# (1)
SELECT e.last_name, department_id, d.department_name
FROM employees AS e
NATURAL JOIN departments AS d;

# (2)
SELECT DISTINCT j.job_title
FROM employees AS e
JOIN jobs AS j USING (job_id)
WHERE e.department_id=30;

# (3)
SELECT e.last_name, d.department_name, l.state_province
FROM employees AS e
JOIN departments AS d ON e.department_id=d.department_id
JOIN locations AS l ON d.location_id=l.location_id
WHERE e.commission_pct IS NOT NULL;
# OR
SELECT e.last_name, d.department_name, r.region_name
FROM employees AS e
JOIN departments AS d ON e.department_id=d.department_id
JOIN locations AS l ON d.location_id=l.location_id
JOIN countries AS c ON c.country_id=l.country_id
JOIN regions AS r ON c.region_id=r.region_id
WHERE e.commission_pct IS NOT NULL;

# (4)
SELECT e.last_name, d.department_name
FROM employees AS e
JOIN departments AS d USING (department_id)
WHERE LOWER(e.last_name) LIKE "%a%";

# (5)
SELECT e.last_name, j.job_title, e.department_id, d.department_name
FROM employees AS e
JOIN jobs AS j ON e.job_id=j.job_id
JOIN departments AS d ON e.department_id=d.department_id
JOIN locations AS l ON d.location_id=l.location_id
WHERE l.city="Seattle";

# (6)
SELECT e.last_name AS "Employee",
	e.employee_id AS "Emp#",
	ee.last_name AS "Manager",
	e.manager_id AS "Mgr#"
FROM employees AS e
JOIN employees AS ee ON e.manager_id=ee.employee_id;

# (7)
SELECT e.last_name AS "Employee",
	e.employee_id AS "Emp#",
	ee.last_name AS "Manager",
	e.manager_id AS "Mgr#"
FROM employees AS e
LEFT OUTER JOIN employees AS ee ON e.manager_id=ee.employee_id;

# (8)
SELECT e.department_id AS "Dep#",
	e.last_name AS "Employee",
	ee.last_name AS "Collegue"
FROM employees AS e
RIGHT OUTER JOIN employees AS ee ON e.department_id=ee.department_id
WHERE e.last_name<>ee.last_name;

# (9)
DESC jobs;
SELECT e.last_name, j.job_title, d.department_name, e.salary,
	CONCAT(j.min_salary, " -- ", j.max_salary) AS "Interval"
FROM employees AS e
JOIN jobs AS j ON e.job_id=j.job_id
JOIN departments AS d ON e.department_id=d.department_id;

# (10)
SELECT e.last_name, e.hire_date
FROM employees AS e
WHERE e.hire_date > (
	SELECT e.hire_date
    FROM employees AS e
    WHERE e.email = "JKING"
);

# (11)
SELECT e.last_name AS "Employee",
	e.hire_date AS "Emp Hiredate",
    ee.last_name AS "Manager",
    ee.hire_date AS "Mgr Hiredate"
FROM employees AS e
JOIN employees AS ee ON e.manager_id=ee.employee_id
WHERE e.hire_date < ee.hire_date;