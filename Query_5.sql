-- Business Question:  Which regions are expected to see the highest demand growth for specific product categories next quarter?

-- This query forecasts the next quarter’s demand growth for specific product categories across regions. 
-- Firstly, aggregating quarterly sales quantities by region and product category using historical data. 
-- The LAG function calculates the previous quarter's sales for each region and category.
-- The average growth rate is then calculated for each region and product category. 
-- Finally, the latest quarter's sales quantities are adjusted using these growth rates to project demand for the next quarter. 
-- The results are ranked by forecasted demand.



WITH QuarterlySales AS (
    SELECT 
        c.country2 AS Region,
        p.Product_Family AS ProductCategory,
        YEAR(s.Date_Time) AS SaleYear,
        DATEPART(QUARTER, s.Date_Time) AS SaleQuarter,
        SUM(s.quantity) AS TotalQuantity
    FROM Sales s
    JOIN [Customer Accounts Info] c ON s.Account_id = c.Account_id
    JOIN Products p ON s.Product_id = p.Product_Name_id
    GROUP BY c.country2, p.Product_Family, YEAR(s.Date_Time), DATEPART(QUARTER, s.Date_Time)
),
LaggedSales AS (
    SELECT 
        qs.Region,
        qs.ProductCategory,
        qs.SaleYear,
        qs.SaleQuarter,
        qs.TotalQuantity,
        LAG(qs.TotalQuantity) OVER (PARTITION BY qs.Region, qs.ProductCategory ORDER BY qs.SaleYear, qs.SaleQuarter) AS PreviousQuarterQuantity
    FROM QuarterlySales qs
),
GrowthRates AS (
    SELECT 
        ls.Region,
        ls.ProductCategory,
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
        gr.ProductCategory,
        AVG(gr.GrowthRate) AS AvgGrowthRate
    FROM GrowthRates gr
    GROUP BY gr.Region, gr.ProductCategory
),
Forecast AS (
    SELECT 
        ag.Region,
        ag.ProductCategory,
        MAX(gr.TotalQuantity) AS LatestQuantity,
        ag.AvgGrowthRate
    FROM GrowthRates gr
    JOIN AverageGrowth ag ON gr.Region = ag.Region AND gr.ProductCategory = ag.ProductCategory
    GROUP BY ag.Region, ag.ProductCategory, ag.AvgGrowthRate
)
SELECT 
    fc.Region,
    fc.ProductCategory,
    fc.LatestQuantity * (1 + COALESCE(fc.AvgGrowthRate, 0)) AS ForecastedDemand
FROM Forecast fc
ORDER BY ForecastedDemand DESC;

