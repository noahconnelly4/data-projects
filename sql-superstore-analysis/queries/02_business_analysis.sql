USE Superstore

-- ========================================
-- QUERY 1: SALES PERFORMANCE BY REGION & CATEGORY
-- Business Question: Which regions-category combinations generates the highest revenue and profit?
-- ========================================

SELECT 
	Region, 
	Category, 
	ROUND(SUM(Sales), 2)  AS Total_Sales,
	COUNT(*) AS Number_Of_Orders,
	ROUND(AVG(Sales), 2) AS Avg_Order_Value,
	ROUND(SUM(Profit), 2) AS Total_Profit,
	ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percent
FROM dbo.Superstore
WHERE Profit IS NOT NULL
GROUP BY Region, Category 
ORDER BY Total_Sales DESC;


-- ========================================
-- QUERY 2: TOP & BOTTOM SUB-CATEGORIES BY PROFIT
-- Business Question: Which products are winning and which are losing money?
-- ========================================

-- TOP 5
SELECT TOP 5
	Sub_Category,
	ROUND(SUM(Sales), 2) AS Total_Sales,
	ROUND(SUM(Profit), 2) AS Total_Profit,
	COUNT(*) AS Number_Of_Orders,
	ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percent
FROM dbo.Superstore
WHERE Profit IS NOT NULL
GROUP BY Sub_Category
Order BY Total_Profit DESC

-- BOTTOM 5
SELECT TOP 5
	Sub_Category,
	ROUND(SUM(Sales), 2) AS Total_Sales,
	ROUND(SUM(Profit), 2) AS Total_Profit,
	COUNT(*) AS Number_Of_Orders,
	ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percent
FROM dbo.Superstore
WHERE Profit IS NOT NULL
GROUP BY Sub_Category
Order BY Total_Profit ASC;


-- ========================================
-- QUERY 3: CUSTOMER COHORT RETENTION ANALYSIS
-- Business Question: What is our customer retention rate by cohort? 
-- ========================================

WITH customer_cohorts AS (
    SELECT 
        Customer_ID,
        MIN(YEAR(Order_Date)) AS First_Order_Year
    FROM dbo.Superstore
    WHERE Profit IS NOT NULL
    GROUP BY Customer_ID),
cohort_orders AS (
    SELECT DISTINCT
        cc.First_Order_Year,
        cc.Customer_ID,
        YEAR(s.Order_Date) AS Order_Year
    FROM customer_cohorts cc
    JOIN dbo.Superstore s ON cc.Customer_ID = s.Customer_ID
    WHERE s.Profit IS NOT NULL)
SELECT 
    First_Order_Year,
    COUNT(DISTINCT CASE WHEN Order_Year = 2014 THEN Customer_ID END) AS Year_2014,
    COUNT(DISTINCT CASE WHEN Order_Year = 2015 THEN Customer_ID END) AS Year_2015,
    COUNT(DISTINCT CASE WHEN Order_Year = 2016 THEN Customer_ID END) AS Year_2016,
    COUNT(DISTINCT CASE WHEN Order_Year = 2017 THEN Customer_ID END) AS Year_2017
FROM cohort_orders
GROUP BY First_Order_Year
ORDER BY First_Order_Year;


-- ========================================
-- QUERY 4: RUNNING TOTAL PROFIT
-- Business Question: How has monthly profit changed over time, and is cumulative profit growing consistently? 
-- ========================================

WITH monthly_profit AS(
    SELECT
        YEAR(Order_Date) AS Order_Year,
        Month(Order_Date) AS Order_Month,
        ROUND(SUM(Profit), 2) AS Monthly_Profit
    FROM dbo.Superstore
    WHERE Profit IS NOT NULL
    GROUP BY YEAR(Order_Date), MONTH(Order_Date))
SELECT
    Order_Year,
    Order_Month,
    Monthly_Profit,
    ROUND(SUM(Monthly_Profit) OVER (ORDER BY Order_Year, Order_Month), 2) AS Running_Total_Profit
FROM monthly_profit
ORDER BY Order_Year, Order_Month;


-- ========================================
-- QUERY 5: VIP CUSTOMERS BY PROFIT IN EACH REGION
-- Business Question: Who are the top customers in each region?
-- ========================================

WITH customer_profit AS (
    SELECT
        Region,
        Customer_ID,
        Customer_Name,
        ROUND(SUM(Profit), 2) AS Total_Profit
    FROM dbo.Superstore
    WHERE Profit IS NOT NULL
    GROUP BY Region, Customer_ID, Customer_Name),
    customers_ranked AS (
    SELECT 
        Region,
        Customer_ID,
        Customer_Name,
        RANK() OVER(PARTITION BY Region ORDER BY Total_Profit DESC) AS Profit_Rank,
        Total_Profit
    FROM customer_profit)
SELECT
    Region,
    Customer_ID,
    Customer_Name,
    Total_Profit,
    Profit_Rank
FROM customers_ranked
WHERE Profit_Rank <= 3
ORDER BY Region, Profit_Rank;


-- ========================================
-- QUERY 6: IMPACT OF DISCOUNT ON PROFITABILITY
-- Business Question: How do discounts affect on profitability across sub categories?
-- ========================================

WITH subcategory_discount AS (
    SELECT
        Sub_Category,
        ROUND(AVG(DISCOUNT), 2) AS Avg_Discount,
        ROUND(SUM(Sales), 2) AS Total_Sales,
        ROUND(SUM(Profit), 2) AS Total_Profit,
        COUNT(*) AS Number_Of_Orders
    FROM dbo.Superstore
    WHERE Profit IS NOT NULL
    GROUP BY Sub_Category)
SELECT
    Sub_Category,
    Avg_Discount,
    Total_Sales,
    Total_Profit,
    Number_Of_Orders,
    ROUND((Total_Profit / Total_Sales) *100, 2) AS Profit_Margin_Percent
FROM subcategory_discount
ORDER BY Avg_Discount DESC;
