-- Business Question: What is the projected total sales order quantity for the next quarter across all regions?


-- This query forecasts the next quarter’s total sales order quantity for each region based on historical data. 
-- Firstly, aggregating sales quantities by region, year, and quarter. 
-- Using the LAG function,  calculate the previous quarter’s sales for each region and computation of quarter-over-quarter growth rates.
-- The query then calculates the average growth rate for each region.
-- Finally, the most recent quarter’s sales are adjusted using the average growth rate to project the total order quantity for the next quarter across all regions. 
-- Regions are ranked by their forecasted quantities.

WITH QuarterlySales AS (
    SELECT 
        c.country2 AS Region,
        YEAR(s.Date_Time) AS SaleYear,
        DATEPART(QUARTER, s.Date_Time) AS SaleQuarter,
        SUM(s.quantity) AS TotalQuantity
    FROM Sales s
    JOIN [Customer Accounts Info] c ON s.Account_id = c.Account_id
    GROUP BY c.country2, YEAR(s.Date_Time), DATEPART(QUARTER, s.Date_Time)
),
LaggedSales AS (
    SELECT 
        qs.Region,
        qs.SaleYear,
        qs.SaleQuarter,
        qs.TotalQuantity,
        LAG(qs.TotalQuantity) OVER (PARTITION BY qs.Region ORDER BY qs.SaleYear, qs.SaleQuarter) AS PreviousQuarterQuantity
    FROM QuarterlySales qs
),
GrowthRates AS (
    SELECT 
        ls.Region,
        ls.SaleYear,
        ls.SaleQuarter,
        ls.TotalQuantity,
        ls.PreviousQuarterQuantity,
        CASE 
            WHEN ls.PreviousQuarterQuantity IS NOT NULL 
            THEN (CAST(ls.TotalQuantity AS FLOAT) - ls.PreviousQuarterQuantity) / ls.PreviousQuarterQuantity
            ELSE 0
        END AS GrowthRate
    FROM LaggedSales ls
),
AverageGrowth AS (
    SELECT 
        gr.Region,
        AVG(gr.GrowthRate) AS AvgGrowthRate
    FROM GrowthRates gr
    GROUP BY gr.Region
),
Forecast AS (
    SELECT 
        ag.Region,
        MAX(gr.TotalQuantity) AS LatestQuantity,
        ag.AvgGrowthRate
    FROM GrowthRates gr
    JOIN AverageGrowth ag ON gr.Region = ag.Region
    GROUP BY ag.Region, ag.AvgGrowthRate
)
SELECT 
    fc.Region,
    fc.LatestQuantity * (1 + COALESCE(fc.AvgGrowthRate, 0)) AS ForecastedQuantity
FROM Forecast fc
ORDER BY ForecastedQuantity DESC;

