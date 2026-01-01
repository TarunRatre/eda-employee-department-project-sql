-- =============================
-- 1. CREATE TABLES
-- =============================       

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,    
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    gender CHAR(1),
    age INT,
    salary INT,
    dept_id INT,
    join_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    budget INT,
    dept_id INT,
    start_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- =============================
-- 2. INSERT DATA
-- =============================

-- Departments Data
INSERT INTO Departments (dept_id, dept_name, location) VALUES
(1, 'HR', 'Mumbai'),
(2, 'Finance', 'Delhi'),
(3, 'IT', 'Bangalore'),
(4, 'Operations', 'Hyderabad'),
(5, 'Marketing', 'Chennai');

-- Employees Data
INSERT INTO Employees (emp_id, emp_name, gender, age, salary, dept_id, join_date) VALUES
(101, 'Tarun', 'M', 28, 45000, 3, '2020-05-10'),
(102, 'Riya', 'F', 26, 52000, 2, '2021-02-15'),
(103, 'Aman', 'M', 31, 61000, 3, '2019-11-21'),
(104, 'Priya', 'F', 29, 47000, 1, '2020-07-18'),
(105, 'John', 'M', 35, 78000, 4, '2018-01-04'),
(106, 'Sneha', 'F', 30, 55000, 5, '2021-12-10'),
(107, 'Arjun', 'M', 27, 49000, 3, '2022-03-25'),
(108, 'Kavya', 'F', 32, 68000, 4, '2019-08-12');

-- Projects Data
INSERT INTO Projects (project_id, project_name, budget, dept_id, start_date) VALUES
(201, 'Payroll System', 800000, 2, '2022-01-01'),
(202, 'HR Analytics', 300000, 1, '2021-09-10'),
(203, 'CRM Upgrade', 1200000, 5, '2023-03-15'),
(204, 'Inventory System', 1500000, 4, '2020-11-12'),
(205, 'Cloud Migration', 1800000, 3, '2022-08-01');

/* =========================================================
   INTERMEDIATE + ADVANCED SQL (50 QUESTIONS WITH SOLUTIONS)
   TABLES USED: Employees, Departments, Projects
   ========================================================= */

/* =========================
   INTERMEDIATE LEVEL (1–25)
   ========================= */

-- 1. List all employees with department name
SELECT e.emp_name, d.dept_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;

-- 2. Total number of employees
SELECT COUNT(*) AS total_employees FROM Employees;

-- 3. Employees earning more than 50,000
SELECT emp_name, salary
FROM Employees
WHERE salary > 50000;

-- 4. Department-wise employee count
SELECT d.dept_name, COUNT(e.emp_id) AS emp_count
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 5. Average salary of all employees
SELECT AVG(salary) AS avg_salary FROM Employees;

-- 6. Average salary department-wise
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 7. Highest salary in the company
SELECT MAX(salary) AS highest_salary FROM Employees;

-- 8. Lowest salary in IT department
SELECT MIN(e.salary) AS min_salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT';

-- 9. Employees joined after 2020
SELECT emp_name, join_date
FROM Employees
WHERE join_date > '2020-12-31';

-- 10. Male and Female employee count
SELECT gender, COUNT(*) AS count
FROM Employees
GROUP BY gender;

-- 11. Employees sorted by salary (high to low)
SELECT emp_name, salary
FROM Employees
ORDER BY salary DESC;

-- 12. Employees older than 30
SELECT emp_name, age
FROM Employees
WHERE age > 30;

-- 13. Total salary payout department-wise
SELECT d.dept_name, SUM(e.salary) AS total_salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 14. Departments with no employees
SELECT d.dept_name
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;

-- 15. Employees working in Bangalore
SELECT e.emp_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
WHERE d.location = 'Bangalore';

-- 16. Number of projects per department
SELECT d.dept_name, COUNT(p.project_id) AS project_count
FROM Departments d
LEFT JOIN Projects p ON d.dept_id = p.dept_id
GROUP BY d.dept_name;

-- 17. Projects started after 2021
SELECT project_name, start_date
FROM Projects
WHERE start_date > '2021-12-31';

-- 18. Total project budget
SELECT SUM(budget) AS total_budget FROM Projects;

-- 19. Department-wise project budget
SELECT d.dept_name, SUM(p.budget) AS total_budget
FROM Projects p
JOIN Departments d ON p.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 20. Employees whose name starts with 'A'
SELECT emp_name
FROM Employees
WHERE emp_name LIKE 'A%';

-- 21. Employees earning between 50k and 70k
SELECT emp_name, salary
FROM Employees
WHERE salary BETWEEN 50000 AND 70000;

-- 22. Oldest employee
SELECT TOP 1 emp_name, age
FROM Employees
ORDER BY age DESC;

-- 23. Newest employee
SELECT TOP 1 emp_name, join_date
FROM Employees
ORDER BY join_date DESC;

-- 24. Department with maximum employees
SELECT TOP 1 d.dept_name, COUNT(e.emp_id) AS emp_count
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY emp_count DESC;

-- 25. Employees without department (data check)
SELECT emp_name
FROM Employees
WHERE dept_id IS NULL;


/* =========================
   ADVANCED LEVEL (26–50)
   ========================= */

-- 26. Employee with highest salary (subquery)
SELECT emp_name, salary
FROM Employees
WHERE salary = (SELECT MAX(salary) FROM Employees);

-- 27. Employees earning above average salary
SELECT emp_name, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- 28. Department-wise max salary
SELECT d.dept_name, MAX(e.salary) AS max_salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 29. Second highest salary
SELECT MAX(salary) AS second_highest
FROM Employees
WHERE salary < (SELECT MAX(salary) FROM Employees);

-- 30. Employees working in department having highest budget
SELECT emp_name
FROM Employees
WHERE dept_id = (
    SELECT TOP 1 dept_id             
    FROM Projects
    GROUP BY dept_id
    ORDER BY SUM(budget) DESC
    --LIMIT 1
);

-- 31. Rank employees by salary
SELECT emp_name, salary,
RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM Employees;

-- 32. Dense rank employees by salary
SELECT emp_name, salary,
DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM Employees;

-- 33. Row number based on joining date
SELECT emp_name, join_date,
ROW_NUMBER() OVER (ORDER BY join_date) AS row_num
FROM Employees;

-- 34. Top 2 highest paid employees
SELECT emp_name, salary
FROM (
    SELECT emp_name, salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employees
) t
WHERE rnk <= 2;

-- 35. Department-wise salary ranking
SELECT emp_name, dept_id, salary,
RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS dept_rank
FROM Employees;

-- 36. Running total of salaries
SELECT emp_name, salary,
SUM(salary) OVER (ORDER BY salary) AS running_total
FROM Employees;

-- 37. Employees earning more than department average
SELECT emp_name, salary
FROM Employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);

-- 38. Correlated subquery example
SELECT emp_name
FROM Employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);

-- 39. Department having highest average salary
SELECT TOP 1 dept_id
FROM Employees
GROUP BY dept_id
ORDER BY AVG(salary) DESC;

-- 40. Employees in departments with more than 2 employees
SELECT emp_name
FROM Employees
WHERE dept_id IN (
    SELECT dept_id
    FROM Employees
    GROUP BY dept_id
    HAVING COUNT(*) > 2
);

-- 41. Employees not assigned to any project department
SELECT emp_name
FROM Employees
WHERE dept_id NOT IN (SELECT dept_id FROM Projects);

-- 42. Project with highest budget
SELECT TOP 1 project_name, budget
FROM Projects
ORDER BY budget DESC;

-- 43. Department with no projects
SELECT d.dept_name
FROM Departments d
LEFT JOIN Projects p ON d.dept_id = p.dept_id
WHERE p.project_id IS NULL;

-- 44. Employees joined in same year
SELECT emp_name,YEAR(join_date) AS [JOIN YEAR]
FROM Employees
WHERE YEAR(join_date) IN (  SELECT YEAR(join_date)
							FROM Employees
							GROUP BY YEAR(join_date)
							HAVING COUNT(*) > 1
						);

-- 45. Count employees by joining year
SELECT YEAR(join_date) AS join_year, COUNT(*) AS count
FROM Employees
GROUP BY YEAR(join_date);

-- 46. Salary difference from company average
SELECT emp_name, salary,
salary - (SELECT AVG(salary) FROM Employees) AS diff_from_avg
FROM Employees;

SELECT emp_name,salary,salary - AVG(salary) OVER()
FROM Employees;

-- 47. First employee in each department
SELECT emp_name, dept_id
FROM (
    SELECT emp_name, dept_id,
    ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY join_date) AS rn
    FROM Employees
) t
WHERE rn = 1;

-- 48. Employees earning same salary
SELECT emp_name,salary 
FROM Employees
WHERE salary IN (SELECT salary
				FROM Employees
				GROUP BY salary
				HAVING COUNT(*) > 1); 

-- 49. Departments where avg salary > 55k
SELECT d.dept_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 55000;

-- 50. Complete employee, department & project summary
SELECT e.emp_name, d.dept_name, p.project_name
FROM Employees e
LEFT JOIN Departments d ON e.dept_id = d.dept_id
LEFT JOIN Projects p ON d.dept_id = p.dept_id;

/* =========================================================
   EXTRA ADVANCED SQL PRACTICE (51–80)
   REAL-WORLD + INTERVIEW SCENARIOS
   ========================================================= */

/* =========================
   ADVANCED + SCENARIO BASED
   ========================= */

-- 51. Employees whose salary is above their department average
SELECT emp_name, salary
FROM Employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);

-- 52. Department-wise total salary and total employees
SELECT d.dept_name,
       COUNT(e.emp_id) AS total_employees,
       SUM(e.salary) AS total_salary
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 53. Employees who joined first in the company
SELECT emp_name, join_date
FROM Employees
WHERE join_date = (SELECT MIN(join_date) FROM Employees);

SELECT TOP 1
		emp_name,
		join_date as [Joined first]
FROM Employees
ORDER BY join_date

-- 54. Employees who joined last in the company
SELECT emp_name, join_date
FROM Employees
WHERE join_date = (SELECT MAX(join_date) FROM Employees);

-- 55. Department-wise youngest employee
SELECT emp_name, dept_id, age
FROM (
    SELECT emp_name, dept_id, age,
           ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY age) AS rn
    FROM Employees
) t
WHERE rn = 1;

-- 56. Department-wise oldest employee
SELECT emp_name, dept_id, age
FROM (
    SELECT emp_name, dept_id, age,
           ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY age DESC) AS rn
    FROM Employees
) t
WHERE rn = 1;

-- 57. Employees earning more than their manager-like senior (older employee)
SELECT e1.emp_name
FROM Employees e1
JOIN Employees e2
ON e1.dept_id = e2.dept_id
AND e1.age < e2.age
AND e1.salary > e2.salary;

SELECT *
FROM Employees M
JOIN Employees E
	ON M.dept_id = E.dept_id
	AND M.salary < E.salary
	AND M.join_date < E.join_date

-- 58. Salary gap between highest and lowest salary
SELECT
MAX(salary) - MIN(salary) AS salary_gap
FROM Employees;

-- 59. Department where salary gap is maximum
SELECT TOP 1 dept_id,
MAX(salary) - MIN(salary) AS salary_gap
FROM Employees
GROUP BY dept_id
ORDER BY salary_gap DESC;
                                
-- 60. Employees who never worked on any project department
SELECT emp_name
FROM Employees
WHERE dept_id NOT IN (
    SELECT DISTINCT dept_id FROM Projects
);

--CHECK-- 61. Projects started in last 2 years (from 2023 perspective)
SELECT project_name, start_date
FROM Projects
WHERE start_date >= '2022-01-01'
AND start_date < '2024-01-01'
ORDER BY start_date DESC

-- 62. Count employees by age group
SELECT 
	CASE
		WHEN age < 30 THEN 'Below 30'
		WHEN age BETWEEN 30 AND 35 THEN '30-35'
		ELSE '35+'
	END as age_group,
	COUNT(*) as emp_count
FROM Employees
-- SQL server does not allow ALIAS in GROUP BY, so CASE expression must be repeted
GROUP BY 
	CASE
		WHEN age < 30 THEN 'Below 30'
		WHEN age BETWEEN 30 AND 35 THEN '30-35'
		ELSE '35+'
	END

-- 63. Employees earning exactly department average salary
SELECT emp_name, salary
FROM Employees e
WHERE salary = (
    SELECT AVG(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);

-- 64. Department with minimum total salary payout
SELECT TOP 1 dept_id, SUM(salary) AS total_salary
FROM Employees
GROUP BY dept_id
ORDER BY total_salary;

-- 65. Employees having same age in same department
SELECT dept_id, age, COUNT(*) AS count
FROM Employees
GROUP BY dept_id, age
HAVING COUNT(*) > 1;
--- If Name Requared
SELECT *
FROM Employees
WHERE EXISTS (
			SELECT 1
			FROM Employees e
			WHERE dept_id= e.dept_id
			AND age = e.age
			GROUP BY e.dept_id,e.age
			HAVING COUNT(*) > 1
);

-- 66. Percentage contribution of each employee salary
SELECT emp_name, salary,
ROUND(salary* 100 / SUM(salary) OVER () , 2) AS salary_percentage
FROM Employees;

SELECT emp_name, salary,
CAST(salary*100.0/SUM(salary) OVER() AS DECIMAL (5,2) ) AS PERCENTAG
FROM Employees;

-- 66.1 Percentage contribution of each employee salary In their Department
--CTE
WITH DeptTotal as (
	SELECT dept_id,
           SUM(salary) as Total_Salary
	FROM Employees
	GROUP BY dept_id )

SELECT	e.dept_id,
		e.emp_name,
		e.salary,
		CAST((e.salary*100.0/dt.Total_Salary) as DECIMAL(5,2)) as Salary_Percentage
FROM Employees e
JOIN DeptTotal as dt
	ON dt.dept_id = e.dept_id;

-- 67. Employees whose salary is in top 30%
SELECT emp_name, salary
FROM (
    SELECT emp_name, salary,
    NTILE(10) OVER (ORDER BY salary DESC) AS bucket
    FROM Employees
) t
WHERE bucket <= 3;

SELECT *,Perc_Dist*100 AS Perc_Dist1 
FROM (
	SELECT emp_name,salary,
	CUME_DIST() OVER (ORDER BY salary DESC) as Perc_Dist
	FROM Employees)t
--WHERE Perc_Dist <= 0.3;

SELECT *,CONCAT(Perc_Dist*100, '%') AS Perc_Dist1
FROM (
	SELECT emp_name,salary,
	PERCENT_RANK() OVER (ORDER BY salary DESC) as Perc_Dist
	FROM Employees)t
--WHERE Perc_Dist <= 0.3

-- 68. Department-wise cumulative salary
SELECT emp_name, dept_id, salary,
SUM(salary) OVER (PARTITION BY dept_id ORDER BY salary) AS cumulative_salary
FROM Employees;

-- 69. Employees with salary increase simulation (10%)
SELECT emp_name,
salary AS old_salary,
salary * 1.10 AS new_salary
FROM Employees;

-- 70. Departments where average age > company average age
SELECT dept_id
FROM Employees
GROUP BY dept_id
HAVING AVG(age) > (SELECT AVG(age) FROM Employees);

-- 71. Employees whose name length is more than 4 characters
SELECT emp_name
FROM Employees
WHERE LEN(emp_name) > 4;

-- 72. Year-wise hiring trend
SELECT YEAR(join_date) AS year, COUNT(*) AS hires
FROM Employees
GROUP BY YEAR(join_date)
ORDER BY year;

-- 73. Employees working in departments located in metro cities
SELECT e.emp_name, d.location
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
WHERE d.location IN ('Mumbai', 'Delhi', 'Bangalore', 'Chennai');

-- 74. Highest paid employee per department
SELECT emp_name, dept_id, salary
FROM (
    SELECT emp_name, dept_id, salary,
    RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rnk
    FROM Employees
) t
WHERE rnk = 1;

-- 75. Employees with salary closer to department average
SELECT emp_name, dept_id, salary,
ABS(salary - AVG(salary) OVER (PARTITION BY dept_id)) AS diff
FROM Employees
ORDER BY diff;

-- 76. Department-wise employee percentage
SELECT dept_id,
COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS emp_percentage
FROM Employees
GROUP BY dept_id;

-- 77. Projects budget ranking
SELECT project_name, budget,
RANK() OVER (ORDER BY budget DESC) AS budget_rank
FROM Projects;

-- 78. Department having project with earliest start date
SELECT TOP 1 dept_id
FROM Projects
ORDER BY start_date;

-- 79. Employees whose salary is greater than all HR employees
SELECT emp_name
FROM Employees
WHERE salary > ALL (
    SELECT salary
    FROM Employees
    WHERE dept_id = (
        SELECT dept_id FROM Departments WHERE dept_name = 'HR'
    )
);

-- 80. Full business summary (Employees + Departments + Projects)
SELECT
e.emp_id,
e.emp_name,
d.dept_name,
d.location,
p.project_name,
p.budget
FROM Employees e
LEFT JOIN Departments d ON e.dept_id = d.dept_id
LEFT JOIN Projects p ON d.dept_id = p.dept_id;
