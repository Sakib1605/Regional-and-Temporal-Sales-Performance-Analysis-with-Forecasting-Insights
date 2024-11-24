-- Business Question: What is the expected profitability trend for the next quarter across regions?



-- This query forecasts the next quarter's profitability by analyzing historical cost and sales data for each region.
-- It calculates quarterly profit as the difference between total revenue and total cost for each region and uses the LAG function to determine the previous quarter’s profit. 
-- Quarter-over-quarter profit growth rates are then calculated and averaged to identify regional trends. 
-- the most recent quarter’s profit is adjusted using the average growth rate to project profitability for the next quarter. 
-- The regions are ranked by their forecasted profit.

WITH QuarterlyProfit AS (
    SELECT 
        c.country2 AS Region,
        YEAR(s.Date_Time) AS SaleYear,
        DATEPART(QUARTER, s.Date_Time) AS SaleQuarter,
        SUM(s.Sales_USD) AS TotalRevenue,
        SUM(s.COGS_USD) AS TotalCost,
        SUM(s.Sales_USD) - SUM(s.COGS_USD) AS Profit
    FROM Sales s
    JOIN [Customer Accounts Info] c ON s.Account_id = c.Account_id
    GROUP BY c.country2, YEAR(s.Date_Time), DATEPART(QUARTER, s.Date_Time)
),
LaggedProfit AS (
    SELECT 
        qp.Region,
        qp.SaleYear,
        qp.SaleQuarter,
        qp.Profit,
        LAG(qp.Profit) OVER (PARTITION BY qp.Region ORDER BY qp.SaleYear, qp.SaleQuarter) AS PreviousQuarterProfit
    FROM QuarterlyProfit qp
),
GrowthRates AS (
    SELECT 
        lp.Region,
        lp.Profit,
        lp.PreviousQuarterProfit,
        CASE 
            WHEN lp.PreviousQuarterProfit IS NOT NULL 
            THEN (CAST(lp.Profit AS FLOAT) - lp.PreviousQuarterProfit) / lp.PreviousQuarterProfit
            ELSE 0
        END AS GrowthRate
    FROM LaggedProfit lp
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
        MAX(lp.Profit) AS LatestProfit,
        ag.AvgGrowthRate
    FROM LaggedProfit lp
    JOIN AverageGrowth ag ON lp.Region = ag.Region
    GROUP BY ag.Region, ag.AvgGrowthRate
)
SELECT 
    fc.Region,
    fc.LatestProfit * (1 + COALESCE(fc.AvgGrowthRate, 0)) AS ForecastedProfit
FROM Forecast fc
ORDER BY ForecastedProfit DESC;
