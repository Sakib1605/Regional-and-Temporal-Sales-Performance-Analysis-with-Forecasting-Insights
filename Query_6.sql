-- Business Question: Which regions are expected to grow the most next year?


-- This query forecasts next year’s sales growth for each region by analyzing historical data. 
-- It aggregates yearly sales, calculates year-over-year growth rates using the LAG function, 
-- and computes the average growth rate for each region. 
-- The latest year’s sales are then adjusted by this growth rate to project next year’s sales and, ranking regions by their forecasted growth potential. 


WITH RegionalSales AS (
    SELECT 
        c.country2 AS Region,
        YEAR(s.Date_Time) AS SaleYear,
        SUM(s.Sales_USD) AS TotalSales
    FROM Sales s
    JOIN [Customer Accounts Info] c ON s.Account_id = c.Account_id
    GROUP BY c.country2, YEAR(s.Date_Time)
),
LaggedSales AS (
    SELECT 
        Region,
        SaleYear,
        TotalSales,
        LAG(TotalSales) OVER (PARTITION BY Region ORDER BY SaleYear) AS PreviousYearSales
    FROM RegionalSales
),
GrowthRates AS (
    SELECT 
        Region,
        SaleYear,
        TotalSales,
        PreviousYearSales,
        CASE 
            WHEN PreviousYearSales IS NOT NULL 
            THEN (CAST(TotalSales AS FLOAT) - PreviousYearSales) / PreviousYearSales
            ELSE 0
        END AS GrowthRate
    FROM LaggedSales
    WHERE PreviousYearSales IS NOT NULL
),
RegionalForecast AS (
    SELECT 
        Region,
        AVG(GrowthRate) AS AvgGrowthRate,
        MAX(TotalSales) AS LatestSales
    FROM GrowthRates
    GROUP BY Region
)
SELECT 
    Region,
    LatestSales * (1 + COALESCE(AvgGrowthRate, 0)) AS ForecastedSales
FROM RegionalForecast
ORDER BY ForecastedSales DESC;
