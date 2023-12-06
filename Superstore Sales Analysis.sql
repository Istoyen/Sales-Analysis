
---1.	Total sales revenue in the dataset 

	SELECT SUM([Sales]) AS total_sales_revenue 
	FROM [dbo].[Superstore]; 

	SELECT SubCategory, SUM(Sales) AS total_sales_revenue 
	FROM [dbo].[Superstore]
	GROUP BY SubCategory
	ORDER BY total_sales_revenue 
	DESC; 


-- 2. Most commonly used ship mode 
SELECT TOP 2 ShipMode, COUNT(*) AS ship_mode_count
FROM [dbo].[Superstore]
GROUP BY ShipMode
ORDER BY ship_mode_count DESC

SELECT TOP 5 [CustomerName], SUM(Sales) AS total_purchases 
FROM [dbo].[Superstore]
GROUP BY [CustomerName]
ORDER BY total_purchases DESC;


-- 3. Category with the highest average sales SELECT Category, AVG(Sales) 
SELECT Category, AVG(Sales) AS avg_category_sales 
FROM [dbo].[Superstore] 
GROUP BY Category 
ORDER BY avg_category_sales 
DESC 

SELECT SubCategory, SUM(Sales) AS total_sales_revenue 
FROM Superstore
GROUP BY SubCategory
ORDER BY total_sales_revenue 
DESC; 


--Step 2: Sales Prediction
 ------Identify the last date in the dataset.
 --The query used the CONVERT function to change the format of the maximum OrderDate from a datetime to a date-only format, 
 --thereby removing the time component.

SELECT CONVERT(DATE, MAX(OrderDate)) AS last_date 
FROM [dbo].[Superstore];


------Calculate the average daily sales for the last 30 days.
SELECT CAST(OrderDate AS DATE) AS order_date, AVG(Sales) AS avg_daily_sales
FROM [dbo].[Superstore]
WHERE OrderDate >= (
    SELECT DATEADD(DAY, -30, MAX(OrderDate))
    FROM [dbo].[Superstore]
)
AND OrderDate <= (
    SELECT MAX(OrderDate)
    FROM [dbo].[Superstore]
)
GROUP BY CAST(OrderDate AS DATE)
ORDER BY order_date;

----Predict the total sales for the next 7 days.

SELECT 
    CONVERT(DATE, OrderDate) AS prediction_start_date, 
    CONVERT(DATE, DATEADD(DAY, 1, OrderDate)) AS day_1,
    CONVERT(DATE, DATEADD(DAY, 2, OrderDate)) AS day_2, 
    CONVERT(DATE, DATEADD(DAY, 3, OrderDate)) AS day_3, 
    CONVERT(DATE, DATEADD(DAY, 4, OrderDate)) AS day_4, 
    CONVERT(DATE, DATEADD(DAY, 5, OrderDate)) AS day_5, 
    CONVERT(DATE, DATEADD(DAY, 6, OrderDate)) AS day_6, 
    CONVERT(DATE, DATEADD(DAY, 7, OrderDate)) AS day_7,
    ROUND(AVG(sales), 2) AS predicted_daily_sales 
FROM [dbo].[Superstore]
GROUP BY OrderDate;


---TABLEAU VISUALIZATION
-- 1. Total sales by region 
SELECT Region, SUM(Sales) AS total_sales 
FROM [dbo].[Superstore]
GROUP BY Region 
ORDER BY total_sales 
DESC; 

---2. Seasonality of sales over a year
SELECT DATEPART(MONTH, OrderDate) AS order_month, 
SUM(Sales) AS total_monthly_sales 
FROM [dbo].[Superstore] 
GROUP BY DATEPART(MONTH, OrderDate) 
ORDER BY order_month;

----3. Correlation matrix between different product categories
SELECT Category, SubCategory, AVG(Sales) AS avg_sales 
FROM [dbo].[Superstore] 
GROUP BY Category, SubCategory;


