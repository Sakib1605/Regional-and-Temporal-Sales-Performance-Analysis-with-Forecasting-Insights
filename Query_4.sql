-- Business Question: Which product categories are expected to generate the highest revenue next year?

-- This query forecasts next year’s revenue for product categories by analyzing historical sales. 
-- It calculates year-over-year growth rates using the LAG function and averages them for long-term trends.
-- The latest year’s revenue is then adjusted by the average growth rate to predict next year’s revenue and ranking categories by projected performance.

WITH YearlySales AS (
    SELECT 
        p.Product_Family AS ProductCategory,
        YEAR(s.Date_Time) AS SaleYear,
        SUM(s.Sales_USD) AS TotalRevenue
    FROM Sales s
    JOIN Products p ON s.Product_id = p.Product_Name_id
    GROUP BY p.Product_Family, YEAR(s.Date_Time)
),
LaggedSales AS (
    SELECT 
        ys.ProductCategory,
        ys.SaleYear,
        ys.TotalRevenue,
        LAG(ys.TotalRevenue) OVER (PARTITION BY ys.ProductCategory ORDER BY ys.SaleYear) AS PreviousYearRevenue
    FROM YearlySales ys
),
GrowthRates AS (
    SELECT 
        ls.ProductCategory,
        ls.SaleYear,
        ls.TotalRevenue,
        ls.PreviousYearRevenue,
        CASE 
            WHEN ls.PreviousYearRevenue IS NOT NULL 
            THEN (CAST(ls.TotalRevenue AS FLOAT) - ls.PreviousYearRevenue) / ls.PreviousYearRevenue
            ELSE 0
        END AS GrowthRate
    FROM LaggedSales ls
),
AverageGrowth AS (
    SELECT 
        gr.ProductCategory,
        AVG(gr.GrowthRate) AS AvgGrowthRate
    FROM GrowthRates gr
    GROUP BY gr.ProductCategory
),
Forecast AS (
    SELECT 
        ag.ProductCategory,
        MAX(gr.TotalRevenue) AS LatestRevenue,
        ag.AvgGrowthRate
    FROM GrowthRates gr
    JOIN AverageGrowth ag ON gr.ProductCategory = ag.ProductCategory
    GROUP BY ag.ProductCategory, ag.AvgGrowthRate
)
SELECT 
    ProductCategory,
    LatestRevenue * (1 + COALESCE(AvgGrowthRate, 0)) AS ForecastedRevenue
FROM Forecast
ORDER BY ForecastedRevenue DESC;

