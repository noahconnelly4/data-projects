-- ========================================
-- DATA EXPLORATION - Superstore Dataset
-- ========================================
USE Superstore

-- View sample data
SELECT TOP 10 * FROM dbo.Superstore

-- Overall dataset metrics
SELECT 
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT Order_ID) AS Unique_Orders,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,
    MIN(Order_Date) AS Earliest_Date,
    MAX(Order_Date) AS Latest_Date,
    COUNT(DISTINCT Region) AS Total_Regions,
    COUNT(DISTINCT Category) AS Total_Categories,
    COUNT(DISTINCT Sub_Category) AS Total_SubCategories
FROM dbo.Superstore

-- Check for nulls in ALL columns
SELECT 
    SUM(CASE WHEN Row_ID IS NULL THEN 1 ELSE 0 END) AS Null_Row_ID,
    SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS Null_Order_ID,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS Null_Order_Date,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Null_Customer_ID,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Null_Sales,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Null_Profit,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Null_Quantity
FROM dbo.Superstore

-- Sales and profit distribution
SELECT 
    MIN(Sales) AS Min_Sales, 
    MAX(Sales) AS Max_Sales,
    AVG(Sales) AS Avg_Sales,
    MIN(Profit) AS Min_Profit, 
    MAX(Profit) AS Max_Profit,
    AVG(Profit) AS Avg_Profit,
    MIN(Quantity) AS Min_Quantity,
    MAX(Quantity) AS Max_Quantity
FROM dbo.Superstore

-- Check for duplicates
SELECT COUNT(DISTINCT Row_ID) AS Unique_Rows,
    COUNT(*) AS Total_Rows
FROM dbo.Superstore

-- Unique values in categorical columns
SELECT 
    COUNT(DISTINCT Region) AS Unique_Regions,
    COUNT(DISTINCT Segment) AS Unique_Segments,
    COUNT(DISTINCT Category) AS Unique_Categories,
    COUNT(DISTINCT Sub_Category) AS Unique_SubCategories
FROM dbo.Superstore

-- Check discount range
SELECT 
    MIN(Discount) AS Min_Discount,
    MAX(Discount) AS Max_Discount,
    COUNT(CASE WHEN Discount > 0 THEN 1 END) AS Orders_With_Discount
FROM dbo.Superstore