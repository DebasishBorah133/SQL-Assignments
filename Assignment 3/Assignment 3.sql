-- Create Table

CREATE TABLE Department
(
	dept_id INT NOT NULL PRIMARY KEY,
	dept_name NVARCHAR(50) NOT NULL 
);


CREATE TABLE Employee
(
	emp_id INT NOT NULL PRIMARY KEY,
	dept_id INT NOT NULL,
	mngr_id INT,
	emp_name NVARCHAR(50) NOT NULL,
	salary MONEY NOT NULL,
	FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);


--Insert Queries

INSERT INTO Department VALUES
	(1001,'Finance'),
	(2001,'Audit'),
	(3001,'Marketing'),
	(4001,'Production');

INSERT INTO Employee VALUES
	(101,1001,NULL,'Kayling',6000),
	(102,3001,101,'Blaze',2750),
	(103,1001,101,'Clare',2550),
	(104,2001,101,'Jonas',2957),
	(105,2001,104,'Scarlet',3100),
	(106,2001,104,'Frank',3100),
	(107,2001,106,'Sandrine',900),
	(108,3001,102,'Adelyn',1700),
	(109,3001,102,'Wade',1350),
	(110,3001,102,'Madden',1350),
	(111,3001,102,'Tucker',1600),
	(112,2001,105,'Adnres',1200),
	(113,3001,102,'Julius',1050),
	(114,1001,103,'Marker',1400);



	--Que 1
	select emp_name,Salary,dept_id from Employee
	where Salary in (select max(salary) from Employee group by dept_id)


	--Que 2
	SELECT dept_name AS "Department Name",
	COUNT(employee.dept_id) as "Number Of People"
	FROM Department
	LEFT JOIN Employee
	ON Department.dept_id=Employee.dept_id
	GROUP BY dept_name
	HAVING COUNT(employee.dept_id)<3

	--Que 3
	SELECT dept_name AS "Department Name",COUNT(employee.dept_id) AS "Number Of People"
	from Department
	LEFT JOIN Employee
	ON Department.dept_id=Employee.dept_id
	GROUP BY dept_name


	--Que 4
	SELECT dept_name AS "Department Name",ISNULL(SUM(salary),0) AS "Total Salary"
	FROM Department
	LEFT JOIN Employee
	ON Department.dept_id=Employee.dept_id
	GROUP BY dept_name

