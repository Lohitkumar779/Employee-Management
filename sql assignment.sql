USE EMPLOYEES;
CREATE TABLE employee (employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT NULL,
    salary INT CHECK (salary BETWEEN 30000 AND 120000),
    designation VARCHAR(50),
    department ENUM('IT', 'Sales', 'Marketing', 'HR')
);
INSERT INTO employee (employee_name, first_name, last_name, age, salary, designation, department) VALUES
('Alice Johnson', 'Alice', 'Johnson', 28, 45000, 'Software Engineer', 'IT'),
('Bob Smith', 'Bob', 'Smith', 35, 52000, 'Senior Engineer', 'IT'),
('Charlie Brown', 'Charlie', 'Brown', 40, 70000, 'Team Lead', 'IT'),
('David Lee', 'David', 'Lee', 50, 105000, 'Director', 'Sales'),
('Eva Davis', 'Eva', 'Davis', NULL, 110000, 'Director', 'Marketing'),
('Frank White', 'Frank', 'White', 42, 32000, 'Junior Associate', 'HR'),
('Grace Hall', 'Grace', 'Hall', 29, 34000, 'Junior Associate', 'Sales'),
('Hank Miller', 'Hank', 'Miller', 38, 48000, 'Analyst', 'Marketing'),
('Ivy King', 'Ivy', 'King', 45, 67000, 'Manager', 'HR'),
('Jackie Chan', 'Jackie', 'Chan', NULL, 90000, 'Manager', 'IT'),
('Kelly Ford', 'Kelly', 'Ford', 33, 40000, 'Consultant', 'Sales'),
('Leo Grant', 'Leo', 'Grant', 39, 60000, 'Senior Consultant', 'HR'),
('Mona Green', 'Mona', 'Green', 36, 55000, 'Senior Analyst', 'Marketing'),
('Nina Cole', 'Nina', 'Cole', 30, 75000, 'Manager', 'Sales'),
('Oscar Reed', 'Oscar', 'Reed', NULL, 115000, 'Director', 'HR'),
('Paul Scott', 'Paul', 'Scott', 46, 32000, 'Intern', 'IT'),
('Quincy Lane', 'Quincy', 'Lane', 41, 58000, 'Analyst', 'Marketing'),
('Rita Moore', 'Rita', 'Moore', 27, 30000, 'Junior Associate', 'Sales'),
('Steve Baker', 'Steve', 'Baker', NULL, 118000, 'Director', 'IT'),
('Tina Adams', 'Tina', 'Adams', 44, 105000, 'Director', 'HR'),
('Uma Clark', 'Uma', 'Clark', 37, 41000, 'Consultant', 'IT'),
('Vince Stone', 'Vince', 'Stone', 32, 49000, 'Analyst', 'Sales'),
('Wendy Lopez', 'Wendy', 'Lopez', NULL, 52000, 'Consultant', 'Marketing'),
('Xander Wright', 'Xander', 'Wright', 29, 43000, 'Software Engineer', 'IT'),
('Yara Torres', 'Yara', 'Torres', 34, 38000, 'Junior Associate', 'HR'),
('Zane Cooper', 'Zane', 'Cooper', 31, 87000, 'Manager', 'Sales'),
('Amy Brooks', 'Amy', 'Brooks', 47, 120000, 'Director', 'Marketing'),
('Ben Turner', 'Ben', 'Turner', NULL, 65000, 'Manager', 'HR'),
('Clara Fields', 'Clara', 'Fields', 43, 97000, 'Manager', 'IT'),
('Dan Fox', 'Dan', 'Fox', 36, 115000, 'Director', 'Marketing');


SELECT employee_name, age,salary FROM employee;
SELECT employee_name FROM employee WHERE age > 30;
SET SQL_SAFE_UPDATES = 0
UPDATE employee SET age = 25 WHERE age IS NULL;

UPDATE employee SET salary = salary * 1.15 WHERE age > 40;

UPDATE employee
SET employee_name = 'Robert White', first_name = 'Robert', last_name = 'White'
WHERE employee_id = 3;

DELETE FROM employee
WHERE employee_id = 5;

SELECT * FROM employee
ORDER BY salary DESC
LIMIT 10;



CREATE TABLE employee (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) ,
    last_name VARCHAR(50) ,
    age INT ,
    salary DECIMAL(10, 2) ,
    designation VARCHAR(50),
    dept_id INT,
    m_id INT -- Manager ID
);
INSERT INTO employee (first_name, last_name, age, salary, designation, dept_id, m_id) VALUES
('John', 'Doe', 35, 60000.00, 'Sales', 1, NULL),    -- A manager (no m_id)
('Jane', 'Smith', 28, 48000.00, 'Sales', 1, 1),    -- Reports to John
('Alice', 'Johnson', 40, 75000.00, 'Manager', 2, NULL),  -- A manager (no m_id)
('Bob', 'Brown', 30, 50000.00, 'Developer', 2, 3),  -- Reports to Alice
('Charlie', 'Davis', 45, 90000.00, 'Manager', 3, NULL),  -- Manager in Dept 3
('David', 'Wilson', 32, 55000.00, 'Sales', 1, 1),  -- Reports to John
('Emma', 'Taylor', 29, 72000.00, 'Developer', 2, 3),  -- Reports to Alice
('Frank', 'Moore', 33, 47000.00, 'Analyst', 3, 5),  -- Reports to Charlie
('Grace', 'Lee', 27, 51000.00, 'Sales', 1, 1),   -- Reports to John
('Hannah', 'White', 26, 65000.00, 'Developer', 3, 5);  -- Reports to Charlie


START TRANSACTION;
    UPDATE employee
    SET salary = salary * 1.10
    WHERE dept_id = 1;

    COMMIT;
    SELECT 'Transaction committed successfully' AS status;
    
SELECT first_name, last_name, salary
FROM employee
WHERE dept_id = 1;
DELIMITER //

CREATE PROCEDURE GetEmployeesByDepartment(IN dept INT)
    SELECT * FROM employee
    WHERE dept_id = dept;

DELIMITER ;
CALL GetEmployeesByDepartment(2);


CREATE PROCEDURE IncreaseSalaryByDepartment(
    IN dept INT,
    IN percent DECIMAL(5,2)
)
    UPDATE employee
    SET salary = salary * (1 + percent / 100)
    WHERE dept_id = dept;

CALL IncreaseSalaryByDepartment(2, 5);

SELECT e.*
FROM employee e
JOIN (
    SELECT dept_id, MAX(salary) AS max_salary
    FROM employee
    GROUP BY dept_id
) AS dept_max
ON e.dept_id = dept_max.dept_id AND e.salary = dept_max.max_salary;









