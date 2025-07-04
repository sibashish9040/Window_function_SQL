--Find the total sales across all orders
SELECT
SUM(Sales) AS total_sales
FROM SalesDB.Sales.Orders

--Find the total sales for each product
SELECT
ProductID,
SUM(Sales) AS total_sales
FROM SalesDB.Sales.Orders
GROUP BY ProductID

-- Find the total sales of all orders and 
--Find the total sales for each product
--Find the total sales for each combination of product and order status
--additionally provide details such as order_id and order date
SELECT
OrderID,
OrderDate,
ProductID,
OrderStatus,
Sales,
SUM(Sales) OVER() AS all_total_sales,
SUM(Sales) OVER(PARTITION BY ProductID) AS total_sales_by_prodID,
SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) AS sub_cat_sales
FROM SalesDB.Sales.Orders


-- Rank each order based on their sales from highest to lowest
-- additionally provide details such  as order id and order date
SELECT
OrderID,
OrderDate,
Sales,
RANK() OVER(ORDER BY sales DESC) AS SalesRank
FROM SalesDB.Sales.Orders

-- Find the number of orders
-- additionally provide details such as order_id and order date
SELECT
OrderID,
OrderDate,
COUNT(*) OVER () TOTALORDERS
FROM SalesDB.Sales.Orders

--check whether the table 'orders' contains any duplicate 
SELECT *
FROM (SELECT
--find the primary key and then perform query upon that
OrderID,
COUNT(*) OVER(PARTITION BY OrderID) CheckPK
FROM SalesDB.Sales.OrdersArchive
)t WHERE checkPK > 1


-- Find the total sales acorss all orders and the total sales for each product
-- additionally provide details sucha as order ID and order date
SELECT 
OrderID,
OrderDate,
Sales,
SUM(sales) OVER() TotalSales
FROM SalesDB.Sales.Orders

-- Find the percentage contribution of each product's sales to the total sales
SELECT
ProductID,
SUM(Sales) OVER() TotalSales,
ROUND(CAST(Sales AS float) / SUM(Sales) OVER() * 100,2) percentOfTotal
FROM SalesDB.Sales.Orders

-- Find the avergae sales across all orders
-- Find the average sales for each product
-- additionally provide details such as order id and order date
SELECT
OrderID,
OrderDate,
ProductID,
AVG(Sales) OVER() Overall_avg,
AVG(Sales) OVER(PARTITION BY ProductID) EachProdAvg
FROM SalesDB.Sales.Orders

--Find all orders where sales are higher than the average sales across all orders
SELECT *
FROM(SELECT
OrderID,
ProductID,
Sales,
AVG(sales) OVER() OverllAvg
FROM SalesDB.Sales.Orders)
t
WHERE sales > OverllAvg

-- MIN and MAX
SELECT
OrderID,
ProductID,
Sales,
MIN(sales) OVER() GlobalMin,
MAX(Sales) OVER() GlobalMax,
MIN(sales) OVER(PARTITION BY ProductID) LocalMin,
MAX(Sales) OVER(PARTITION BY ProductID) LocalMax
FROM SalesDB.Sales.Orders

-- Find the employee who has the highest salary
SELECT *
FROM(SELECT
*,
MAX(Salary) OVER() HighestSalary
FROM SalesDB.Sales.Employees)t
WHERE salary = HighestSalary

--Calculate the moving average(similar to sunning total) of sales for each product over time
SELECT 
ProductID,
OrderID,
OrderDate,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) OverallAvg,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) OverallMovingAvg
FROM SalesDB.Sales.Orders

--Calculate the moving average(similar to sunning total) of sales for each product over time, including only the next order
SELECT 
ProductID,
OrderID,
OrderDate,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) OverallAvg,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) OverallMovingAvg
FROM SalesDB.Sales.Orders

-- Rank the orders based on their sales from highest to lowest
SELECT
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER( ORDER BY Sales DESC) RankOfOrders
FROM SalesDB.Sales.Orders

-- Rank but rank can be repetitive for similar values
SELECT
OrderID,
ProductID,
Sales,
RANK() OVER( ORDER BY Sales DESC) RankOfOrders
FROM SalesDB.Sales.Orders

--Segment the orders into 3 categories; High, medium and low sales
SELECT*,
CASE 
WHEN Category=1 THEN 'High'
WHEN Category=2 THEN 'Medium'
WHEN Category =3 THEN 'Low'
END CategoryName
FROM
(
SELECT
OrderID,
ProductID,
Sales,
NTILE(3) OVER(ORDER BY Sales DESC) Category
FROM SalesDB.Sales.Orders)t

--Find the product that fall within the highest 40% of prices
SELECT
Product,
Price,
CUME_DIST() OVER(ORDER BY Price DESC) DistRank
FROM SalesDB.Sales.Products

-- Analyze the mont-over-month performance by finding the percentage change
-- in sales between the current and previous months
SELECT *,
CAST((Current_sales- Prev_month_sales) AS FLOAT) MoM_perf,
ROUND(CAST((Current_sales- Prev_month_sales) AS FLOAT)/Current_sales * 100, 2) Percentage_performance
FROM
(SELECT 
MONTH(OrderDate) Month_of_sales,
SUM(Sales) Current_sales,
LAG(SUM(Sales),1,0) OVER(ORDER BY MONTH(OrderDate)) Prev_month_sales
FROM SalesDB.Sales.Orders
GROUP BY MONTH(OrderDate))t