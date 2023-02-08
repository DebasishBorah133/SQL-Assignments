-- Que 1

create procedure sp_AvgFreightByID
    -- inputted customer
    @CustomerID nvarchar(5),
    -- returned average freight
    @AverageFreight money output
as
begin
   select @AverageFreight = AVG(Freight) 
   from Orders
   where customer_id = @CustomerID
end
go

/*
declare @AvgFreight money
execute sp_AvgFreightByID @CustomerID='vinet',@AverageFreight=@AvgFreight out
print @AvgFreight

declare @AvgFreight money
execute sp_AvgFreightByID @CustomerID='victe',@AverageFreight=@AvgFreight out
print @AvgFreight 
*/
/*
Create trigger trValidateFreight
on Orders
for Insert,Update
AS
Begin
	declare @AvgFreight money
	execute sp_AvgFreightByID @CustomerID='vinet',@AverageFreight=@AvgFreight out

	if (@AvgFreight>@temp)
		print "Your Freight is greater than AvgFreight"
	else
		print "Correct"
End
*/


CREATE TRIGGER tr_Orders_ForInsertUpdate
ON orders
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @AverageFreightValue real, @InsertedFreight real
	DECLARE @CustomerId char(5)
	DECLARE @errorText  NVARCHAR(100)
	SELECT 
		@CustomerId = customer_id, 
		@InsertedFreight = freight 
		FROM inserted

	EXECUTE sp_AvgFreightByID @CustomerId , @AverageFreight = @AverageFreightValue OUTPUT

	IF @InsertedFreight > @AverageFreightValue
	BEGIN
		SET @errorText = 'Frieght Value cannot be greater than Average Fright value = '+CAST(@AverageFreightValue AS NVARCHAR)
		RAISERROR(@errorText,16,1)
		ROLLBACK TRAN
	END

END


INSERT INTO orders VALUES
(10, 'VINET', 5, '1996-07-04', '1996-08-01', '1996-07-16', 3, 32.38, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France');

UPDATE Orders
SET freight = 200
WHERE order_id = 10248;















--Que 2 
/*
create procedure sp_GetEmployeeSaleByCountry
as
begin
   --
   Select 
   e.employee_id,e.first_name,e.last_name,o.ship_country,count(o.order_id) as [Total Sales]
   from employees e 
   Join orders o
   On e.employee_id=o.employee_id
   Join order_details od
   On o.order_id=od.order_id
   Group by o.ship_country,e.employee_id,e.first_name,e.last_name
   --order by ship_country
   --order by e.employee_id
end
*/

--Que 2 
create procedure spEmpSalesByCountry
	@country varchar(50)
	as
	select e.first_name, e.last_name, count(o.customer_id) as total_sales, e.country from employees e
	JOIN orders o
	on e.employee_id = o.employee_id
	where  e.country = @country
	group by e.country, e.first_name, e.last_name

	-- Execution
	execute spEmpSalesByCountry 'USA'
	execute spEmpSalesByCountry 'UK'



--Que 3

create procedure spSalesByYear
	@year varchar(4)
	as 
	select e.first_name, e.last_name, count(o.customer_id) as total_sales,
	year(o.order_date) as sales_year from employees e
	join orders o
	on e.employee_id = o.employee_id
	where year(o.order_date) = @year
	group by year(o.order_date), e.first_name, e.last_name
	go

	-- Execution
	execute spSalesByYear '1998'
	execute spSalesByYear '1996'



--Que 4
create procedure spSalesByCategory
	@category nvarchar(50)
	as 
	Begin
		select  c.category_id,c.category_name,count( od.order_id) as total_sales
		from categories c
		JOIN products p on p.category_id = c.category_id
		Join order_details od on p.product_id=od.product_id
		where c.category_name = @category
		group by c.category_id,c.category_name
	End

	-- Execution
	execute spSalesByCategory 'Beverages'
	execute spSalesByCategory 'Condiments'


	
 --Que 5
	Create procedure sptenMostExpensiveProduct
	as 
	Begin
		Select top 10 o.product_id,p.product_name,p.unit_price 
		From products p
		JOIN order_details o 
		ON p.product_id=o.product_id
		group by o.product_id,p.product_name,p.unit_price
		order by unit_price desc
	End

	-- Execution
	execute sptenMostExpensiveProduct


	--Que 6

CREATE PROCEDURE spInsertCustomerOrderDetails
@CustomerId char(5), @EmployeeId int , 
@ShipVia int ,@Freight real, @ShipCountry nvarchar(15),
@ProductId int, @Quantity int, @Discount real
AS
BEGIN
	DECLARE @OrderId int, @UnitPrice real
	BEGIN TRAN
	set @OrderId = (select max(order_id) from orders) + 1
	set @UnitPrice = (select unit_price from products where product_id = @ProductId)
	
	BEGIN TRY
		INSERT INTO orders VALUES (@OrderId, @CustomerId, @EmployeeId, GETDATE(), @ShipVia, @Freight, @ShipCountry)
		INSERT INTO order_details VALUES (@OrderId, @ProductId, @UnitPrice, @Quantity, @Discount)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() as Error
		ROLLBACK TRAN
	END CATCH
END

execute spInsertCustomerOrderDetails 120,101,12,13.5,'Spain',1001,12,5 


--Que 7

CREATE PROCEDURE spUpdateCustomerOrderDetails
@CustomerId char(5), @EmployeeId int , 
@ShipVia int ,@Freight real, @ShipCountry nvarchar(15),
@ProductId int, @Quantity int, @Discount real
AS
BEGIN
	DECLARE @OrderId int, @UnitPrice real
	BEGIN TRAN
	set @OrderId = (select max(order_id) from orders) + 1
	set @UnitPrice = (select unit_price from products where product_id = @ProductId)
	
	BEGIN TRY
		INSERT INTO orders VALUES (@OrderId, @CustomerId, @EmployeeId, GETDATE(), @ShipVia, @Freight, @ShipCountry)
		INSERT INTO order_details VALUES (@OrderId, @ProductId, @UnitPrice, @Quantity, @Discount)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() as Error
		ROLLBACK TRAN
	END CATCH
END

execute spUpdateCustomerOrderDetails 120,101,12,13.5,'Spain',1001,12,5 
