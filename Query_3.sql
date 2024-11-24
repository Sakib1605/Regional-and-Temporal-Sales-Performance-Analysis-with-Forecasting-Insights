--Business Question: What is the projected revenue for the next month?

-- This query forecasts next month's revenue by first aggregating monthly sales and calculating month-over-month growth rates using the LAG function.
-- It then computes the average growth rate across all months and applies it to the latest month's sales to project future revenue.
-- This method uses historical trends for a data-driven forecast.

WITH MonthlySales AS (
    SELECT 
        YEAR(Date_Time) AS SaleYear,
        MONTH(Date_Time) AS SaleMonth,
        SUM(Sales_USD) AS TotalSales
    FROM Sales
    GROUP BY YEAR(Date_Time), MONTH(Date_Time)
),
GrowthRates AS (
    SELECT 
        SaleYear,
        SaleMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY SaleYear, SaleMonth) AS PreviousMonthSales,
        CASE 
            WHEN LAG(TotalSales) OVER (ORDER BY SaleYear, SaleMonth) IS NOT NULL 
            THEN (CAST(TotalSales AS FLOAT) - LAG(TotalSales) OVER (ORDER BY SaleYear, SaleMonth)) /
                 LAG(TotalSales) OVER (ORDER BY SaleYear, SaleMonth)
            ELSE 0 
        END AS GrowthRate
    FROM MonthlySales
),
AverageGrowth AS (
    SELECT AVG(GrowthRate) AS AvgGrowthRate FROM GrowthRates
    WHERE GrowthRate IS NOT NULL
),
Forecast AS (
    SELECT 
        TOP 1 TotalSales * (1 + COALESCE((SELECT AvgGrowthRate FROM AverageGrowth), 0)) AS ForecastedRevenue
    FROM MonthlySales
    ORDER BY SaleYear DESC, SaleMonth DESC
)
SELECT 
    ForecastedRevenue AS NextMonthForecast
FROM Forecast;




