use Northwind

Create Table salesman
(
	salesman_id int NOT NULL Primary key,
	name nvarchar(50) NOT NULL,
	city nvarchar(20) NOT NULL,
	commission int NOT NULL,
)

Create Table customer
(
	customer_id int NOT NULL Primary key,
	cust_name nvarchar(50) NOT NULL,
	city nvarchar(20) NOT NULL,
	grade int,
	salesman_id int,
	Foreign Key (salesman_id) References salesman(salesman_id)
)

Create Table orders
(
	ord_no int NOT NULL Primary Key,
	purch_amt money NOT NULL,
	ord_date date NOT NULL,
	customer_id int NOT NULL,
	salesman_id int NOT NULL,
	Foreign Key (customer_id) References customer(customer_id),
	Foreign Key (salesman_id) References salesman(salesman_id), 
)

Insert Into salesman values
	(5001, 'James', 'New York', 15),
	(5002, 'Nail', 'Paris', 13),
	(5003, 'Pit', 'London', 11),
	(5004, 'Lyon', 'Paris', 14),
	(5005, 'Paul', 'Rome', 13),
	(5006, 'Lauson', 'San Fransisco', 12),
	(5007, 'Harry', 'Amsterdam', 16),
	(5008, 'Albus', 'Cape Town', 12);


Insert Into customer values
	(3001, 'Nick', 'New York', 100, 5001),
	(3002, 'Brad Davis', 'New York', 200, 5001),
	(3003, 'Graham', 'California', 200, 5002),
	(3004, 'Julian', 'London', 300, 5002),
	(3005, 'Fabian', 'Paris', 300, 5004),
	(3006, 'Cameron', 'Berlin', 100, 5006),
	(3007, 'Jozy', 'Moscow', 200, 5005),
	(3008, 'Brad Guzan', 'London', NULL , 5003),
	(3009, 'Tony', 'Cape Town', 300, 5003),
	(3010, 'Peter', 'San Fransisco', NULL , 5006);


Insert Into orders values
	(7001, 150.5, '2012-10-05', 3003, 5002),
	(7002, 270.65, '2012-09-10', 3008, 5003),
	(7003, 65.26, '2012-10-05', 3001, 5001),
	(7004, 110.5, '2012-08-17', 3006, 5006),
	(7005, 948.5, '2012-09-10', 3003, 5002),
	(7006, 2400.6, '2012-07-27', 3002, 5001),
	(7007, 5760, '2012-09-10', 3001, 5001),
	(7008, 1983.43, '2012-10-10', 3005, 5004),
	(7009, 2480.4, '2012-10-10', 3006, 5006),
	(7010, 250.45, '2012-06-27', 3004, 5002),
	(7011, 75.29, '2012-08-17', 3007, 5005),
	(7012, 3045.6, '2012-04-25', 3001, 5001);


	--Que 1
	Select name as Salesman,cust_name,customer.city 
	from salesman
	INNER JOIN customer
	ON salesman.city=customer.city


	--Que 2
	Select ord_no, purch_amt, cust_name, city 
	from customer
	INNER JOIN Orders
	ON customer.customer_id=orders.customer_id
	where purch_amt between 500 and 2000

	--Que 3
	Select cust_name as [Customer Name],customer.city,name as Salesman,Commission 
	from salesman
	INNER JOIN customer
	ON salesman.salesman_id= customer.salesman_id
	
	--Que 4
	Select cust_name as [Customer Name],customer.city as [Customer City],name as Salesman,Commission 
	from salesman
	INNER JOIN customer
	ON salesman.salesman_id= customer.salesman_id
	where commission>12;

	--Que 5
	Select cust_name as [Customer Name],customer.city as [Customer City],name as Salesman,
	salesman.city as [Salesman City],Commission 
	from salesman
	INNER JOIN customer
	ON salesman.salesman_id= customer.salesman_id
	where salesman.city!=customer.city and commission>12;

	
	--Que 6
	Select ord_no, ord_date,purch_amt, cust_name as [Customer Name], Grade, 
	name as Salesman , Commission 
	from Orders
	INNER JOIN customer
	ON customer.customer_id=orders.customer_id
	INNER JOIN salesman 
	ON salesman.salesman_id= customer.salesman_id

	--Que 7
	Select salesman.salesman_id,Name,salesman.city,commission,customer.customer_id,cust_name,grade,
	ord_no , purch_amt,ord_date
	from salesman
	INNER JOIN customer
	ON salesman.salesman_id= customer.salesman_id
	INNER JOIN Orders
	ON customer.customer_id=orders.customer_id
	order by salesman_id


	--Que 8
	Select cust_name as [Customer Name],customer.city as [Customer City],Grade,Name as Salesman , 
	salesman.city as [Salesman City]
	from customer
	INNER JOIN salesman
	ON salesman.salesman_id=customer.salesman_id
	order by customer_id

	--Que 9
	Select cust_name as [Customer Name],customer.city as [Customer City],Grade,Name as Salesman , 
	salesman.city as [Salesman City]
	from customer
	INNER JOIN salesman
	ON salesman.salesman_id=customer.salesman_id
	where grade<300
	order by customer_id

	--Que 10
	Select cust_name as [Customer Name],customer.city as [Customer City],ord_no as [Order Number],
	ord_date as [Order Date],Purch_amt as [Order Amount]
	from customer
	Left Outer JOIN orders
	ON orders.customer_id=customer.customer_id
	order by ord_date

	--Que 11
	Select cust_name as [Customer Name],customer.city as [Customer City],ord_no as [Order Number],
	ord_date as [Order Date],Purch_amt as [Order Amount],name as [Salesman Name],Commission
	from customer
	Left Outer JOIN orders
	ON customer.customer_id=orders.customer_id
	Left Outer JOIN salesman
	ON customer.salesman_id=salesman.salesman_id

	
	--Que 12
	SELECT name as [Salesman Name],cust_name as [Customer Name]
	FROM salesman s
	LEFT OUTER JOIN customer c
    ON s.salesman_id=c.salesman_id
	ORDER BY s.salesman_id ASC;

	--Que 13
	SELECT name as [Salesman Name],cust_name as [Customer Name],customer.city,Grade,ord_no as [Order Number],
	ord_date as [Date],purch_amt as [Amount]
	FROM salesman 
	Left Outer JOIN customer 
    ON salesman.salesman_id=customer.salesman_id
	Left Outer JOIN orders
	ON customer.customer_id=orders.customer_id

	--Que 14
	SELECT s.salesman_id,name as [Salesman Name],s.city,s.commission,cust_name as [Customer Name],o.purch_amt as [Order Amount],c.Grade
	FROM salesman s
	LEFT OUTER JOIN customer c
    ON s.salesman_id=c.salesman_id
	LEFT OUTER JOIN orders o
    ON c.customer_id=o.customer_id
	where o.purch_amt>=2000 and c.Grade is not null

	--Que 15
	SELECT s.salesman_id,name as [Salesman Name],s.city,s.commission,cust_name as [Customer Name],o.purch_amt as [Order Amount],c.Grade
	FROM salesman s
	LEFT OUTER JOIN customer c
    ON s.salesman_id=c.salesman_id
	LEFT OUTER JOIN orders o
    ON c.customer_id=o.customer_id
	where o.purch_amt>=2000 and c.Grade is not null

	--Que 16
	Select cust_name as [Customer Name],customer.city , ord_no as [Order Number],ord_date as [Order_date],
	purch_amt as [Purchase Amount] 
	FROM customer 
	FULL OUTER JOIN orders 
    ON customer.customer_id= orders.customer_id
    AND customer.grade IS NOT NULL;

	--Que 17
	SELECT *
	FROM salesman s
	CROSS JOIN customer c;

	--Que 18
	SELECT s.name AS Salesman,
    c.cust_name AS [Customer Name]
	FROM salesman s
	CROSS JOIN customer c
	WHERE s.city IS NOT NULL;

	--Que 19
	SELECT s.name AS "Salesman", c.cust_name AS "Customer Name"
	FROM salesman s
	CROSS JOIN customer c
	WHERE s.city IS NOT NULL
    AND c.grade IS NOT NULL;


	--Que 20
	SELECT s.name AS "Salesman",c.cust_name AS "Customer Name"
	FROM salesman s
	CROSS JOIN customer c
	WHERE s.city IS NOT NULL
    AND s.city != c.city
    AND c.grade IS NOT NULL;