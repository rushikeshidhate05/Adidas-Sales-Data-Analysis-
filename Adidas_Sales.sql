CREATE DATABASE adidas_sales;
USE adidas_sales;

select * from adidas_data
limit 10;

-- 1. Total Sales,Unit Sold and Profit 
SELECT 
    SUM(Total_Sales) AS Total_Sales,
    SUM(Operating_Profit) AS Total_Profit,
    SUM(Units_Sold) AS Total_Units
FROM adidas_data;

-- 2.Top 5 Cities by Average Sales
SELECT 
    City, 
    ROUND(AVG(Total_Sales), 2) AS Avg_Sales
FROM adidas_data
GROUP BY City
ORDER BY Avg_Sales DESC
LIMIT 5;

-- 3.Total Sales by Region
SELECT 
    Region, 
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM adidas_data
GROUP BY Region
ORDER BY Total_Sales DESC;

-- 4️.Top 5 Retailers by Sales
SELECT 
    Retailer, 
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM adidas_data
GROUP BY Retailer
ORDER BY Total_Sales DESC
LIMIT 5;

-- 5.Sales by Product Category
SELECT 
    Product_Category, 
    ROUND(SUM(Total_Sales), 2) AS Total_Sales,
    ROUND(SUM(Operating_Profit), 2) AS Total_Profit
FROM adidas_data
GROUP BY Product_Category
ORDER BY Total_Sales DESC;

-- 6.Profit Margin by Region
SELECT 
    Region,
    ROUND(AVG(Operating_Margin) * 100, 2) AS Avg_Operating_Margin_Percentage
FROM adidas_data
GROUP BY Region
ORDER BY Avg_Operating_Margin_Percentage DESC;

-- 7.Monthly Sales Trend
SELECT 
    YEAR(Invoice_Date) AS Year,
    MONTHNAME(Invoice_Date) AS Month,
    ROUND(SUM(Total_Sales), 2) AS Monthly_Sales
FROM adidas_data
GROUP BY Year, Month
ORDER BY Year, FIELD(Month,
    'January','February','March','April','May','June',
    'July','August','September','October','November','December');

-- 8.Top Performing States by Profit
SELECT 
    State, 
    ROUND(SUM(Operating_Profit), 2) AS Total_Profit
FROM adidas_data
GROUP BY State
ORDER BY Total_Profit DESC
LIMIT 10;

-- 9. Most Popular Sales Method
SELECT 
    Sales_Method, 
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM adidas_data
GROUP BY Sales_Method
ORDER BY Total_Sales DESC;

-- 10.Average Profit per Unit Sold
SELECT 
    ROUND(SUM(Operating_Profit) / SUM(Units_Sold), 2) AS Avg_Profit_Per_Unit
FROM adidas_data;

-- 11.Region-Wise Sales by Product Category
SELECT 
    Region,
    Product_Category,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales,
    ROUND(SUM(Operating_Profit), 2) AS Total_Profit
FROM adidas_data
GROUP BY Region, Product_Category
ORDER BY Region, Total_Sales DESC;

-- 12.Gender-Wise Sales Performance
SELECT 
    Gender_Type,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales,
    ROUND(SUM(Operating_Profit), 2) AS Total_Profit,
    ROUND(AVG(Operating_Margin) * 100, 2) AS Avg_Margin_Percentage
FROM adidas_data
GROUP BY Gender_Type
ORDER BY Total_Sales DESC;

-- 13.Year-over-Year (YoY) Sales Growth
SELECT 
    YEAR(Invoice_Date) AS Year,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales,
    LAG(ROUND(SUM(Total_Sales), 2)) OVER (ORDER BY YEAR(Invoice_Date)) AS Prev_Year_Sales,
    ROUND(
        ((SUM(Total_Sales) - LAG(SUM(Total_Sales)) OVER (ORDER BY YEAR(Invoice_Date))) 
        / LAG(SUM(Total_Sales)) OVER (ORDER BY YEAR(Invoice_Date))) * 100, 2
    ) AS YoY_Growth_Percentage
FROM adidas_data
GROUP BY YEAR(Invoice_Date)
ORDER BY Year;

-- 14.Top 5 Most Profitable Product Categories by Region
SELECT 
    Region,
    Product_Category,
    ROUND(SUM(Operating_Profit), 2) AS Total_Profit
FROM adidas_data
GROUP BY Region, Product_Category
ORDER BY Region, Total_Profit DESC
LIMIT 10;

-- 15.Profitability Efficiency (Profit per $1 of Sales)
SELECT 
    Product_Category,
    ROUND(SUM(Operating_Profit) / SUM(Total_Sales), 3) AS Profit_Per_Dollar
FROM adidas_data
GROUP BY Product_Category
ORDER BY Profit_Per_Dollar DESC;
