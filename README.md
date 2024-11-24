# **Regional and Temporal Sales Performance Analysis with Forecasting Insights Using Power BI and SQL**

---


### **Introduction:**  
This project aimed to deliver actionable insights into sales performance, profitability trends, and regional growth opportunities through an advanced combination of data visualization and forecasting. Utilizing Power BI, an interactive dashboard was created to summarize historical sales data and highlight key performance metrics. In parallel, SQL queries were used to perform forecast analysis, addressing specific business questions related to future sales, demand, and profitability. This comprehensive approach equips stakeholders with the tools and insights needed to drive strategic decisions and operational efficiencies.

---

### **Objectives:**  
- Develop an interactive Power BI dashboard to present historical sales trends and regional performance visually.  
- Utilize SQL to perform advanced forecasting to answer specific business questions.  
- Provide a clear understanding of future sales demand, product performance, and regional growth potential.  
- Enable data-driven decision-making for improved profitability and operational planning.

---

### **Datasets:**

1. **Sales Dataset:** Contains transactional data, including `Sales_USD`, `quantity`, `COGS_USD` (Cost of Goods Sold), and `Date_Time` of sales.  
2. **Products Dataset:** Product-level attributes, including `Product_Family`, `Product_Group`, and `Product_Name`.  
3. **Customer Accounts Info Dataset:** Provides customer and regional details, including `Region`, `country2`, and `Account_id`.

---

## **Dashboard Overview**
![Regional-and-Temporal-Sales-Performance-Analysis-with-Forecasting-Insights](https://raw.githubusercontent.com/Sakib1605/Regional-and-Temporal-Sales-Performance-Analysis-with-Forecasting-Insights/refs/heads/main/Regional%20%26%20Temporal%20Analysis.png)  
*Figure: Regional and Temporal Sales Performance Analysis Dashboard*

## **Approach and Methodology**


### **Dashboard Analysis Report**

This report presents a professional analysis of the Power BI dashboard, highlighting the business questions addressed by each visualization and explaining how each plot contributes to actionable insights.

---

### **1. Business Question: How does year-to-date (YTD) sales performance compare to the previous year?**
### **Visualization: YTD minus PYTD by Month (Bar Chart)**  
- **Explanation:**  
  This visualization compares the current year-to-date (YTD) sales performance to the previous year by month. Positive and negative bar segments clearly highlight monthly growth or decline.  
  - **Insight:**  
    The chart identifies specific months where performance improved or declined, providing insights into seasonal trends and opportunities to address underperforming periods.

---

### **2. Business Question: What is the contribution of each product type to total order quantities?**
### **Visualization: Order Quantity by Product Type (Pie Chart)**  
- **Explanation:**  
  This pie chart displays the proportion of order quantities fulfilled by each product type (Indoor, Outdoor, Landscape).  
  - **Insight:**  
    It reveals the relative importance of each product category, helping prioritize production, marketing, and inventory strategies.

---

### **3. Business Question: Which product types generate the highest gross profit?**
### **Visualization: Gross Profit by Product Type (Pie Chart)**  
- **Explanation:**  
  This visualization breaks down gross profit by product category, highlighting the profitability contribution of each product type.  
  - **Insight:**  
    It identifies the most profitable categories, aiding in resource allocation and financial planning.

---

### **4. Business Question: What are the monthly trends in sales, costs, and gross profit?**
### **Visualization: Cost of Goods and Total Sales by Month (Line Chart)**  
- **Explanation:**  
  This line chart tracks monthly trends in total sales, cost of goods sold (COGS), and gross profit over time.  
  - **Insight:**  
    It provides a detailed view of profitability trends, showing how costs and revenue impact gross profit. This helps in identifying months with high profitability or cost spikes that need attention.

---

### **5. Business Question: How do year-to-date sales compare across product types over time?**
### **Visualization: YTD vs PYTD by Month & Product Type (Stacked Bar Chart)**  
- **Explanation:**  
  This chart compares year-to-date (YTD) sales across months, broken down by product types.  
  - **Insight:**  
    It highlights product-specific trends and performance variations across months, supporting strategic planning for product portfolios.

---

### **6. Business Question: How do regional sales contribute to total performance?**
### **Visualization: Sales Performance by Region (Geographical Map)**  
- **Explanation:**  
  This map visualizes sales contributions geographically, with bubble sizes representing the total sales volume for each region.  
  - **Insight:**  
    It identifies high-performing regions, providing insights into geographic markets that drive overall performance or require growth strategies.

---

### **7. Business Question: Which regions are the top contributors to sales?**
### **Visualization: Top 5 Countries Based on Sales (Bar Chart)**  
- **Explanation:**  
  This bar chart ranks the top-performing countries based on their total sales.  
  - **Insight:**  
    It highlights key markets and enables comparative analysis of country-level contributions to overall sales, supporting decisions about resource allocation and market focus.

- **Filters and Slicers:**  
  Users can filter data by year, month, region, product type, and performance measures, enabling customized analysis.

---
## ** **Forecast Analysis Report**

This report presents a professional analysis of key business questions using advanced SQL queries. Each business question is addressed with detailed analysis and supported by the SQL query used for the insights.

---
### **Business Questions Addressed**
##### **Question 1. What is the projected total sales order quantity for the next quarter across all regions?**

#### **Analysis:**  
This query forecasts the next quarter's profitability by analyzing historical cost and sales data for each region. Firstly, calculating quarterly profit as the difference between total revenue and total cost for each region and uses the LAG function to determine the previous quarter’s profit. Quarter-over-quarter profit growth rates are then calculated and averaged to identify regional trends. The most recent quarter’s profit is adjusted using the average growth rate to project profitability for the next quarter. The regions are ranked by their forecasted profit.

### **SQL Query:**
```sql
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

```

##### **Question 2: What is the projected total sales order quantity for the next quarter across all regions?**

##### **Analysis:**  
-- This query forecasts the next quarter’s total sales order quantity for each region based on historical data. 
-- Firstly, aggregating sales quantities by region, year, and quarter. 
-- Using the LAG function,  calculate the previous quarter’s sales for each region and computation of quarter-over-quarter growth rates.
-- The query then calculates the average growth rate for each region.
-- Finally, the most recent quarter’s sales are adjusted using the average growth rate to project the total order quantity for the next quarter across all regions.  
-- Regions are ranked by their forecasted quantities.

##### **SQL Query:**
```sql

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

```

##### **Question 3: What is the projected revenue for the next month?**

##### **Analysis:**  
-- This query forecasts next month's revenue by first aggregating monthly sales and calculating month-over-month growth rates using the LAG function.
-- It then computes the average growth rate across all months and applies it to the latest month's sales to project future revenue.
-- This method uses historical trends for a data-driven forecast.

##### **SQL Query:**
```sql

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
```

##### **Question 4: Which product categories are expected to generate the highest revenue next year?**

##### **Analysis:**  
-- This query forecasts next year’s revenue for product categories by analyzing historical sales. 
-- It calculates year-over-year growth rates using the LAG function and averages them for long-term trends.
-- The latest year’s revenue is then adjusted by the average growth rate to predict next year’s revenue and ranking categories by projected performance.


##### **SQL Query:**
```sql
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

```


##### **Question 5: Which regions are expected to see the highest demand growth for specific product categories next quarter?**

##### **Analysis:**  
-- This query forecasts the next quarter’s demand growth for specific product categories across regions. 
-- Firstly, aggregating quarterly sales quantities by region and product category using historical data. 
-- The LAG function calculates the previous quarter's sales for each region and category.
-- The average growth rate is then calculated for each region and product category. 
-- Finally, the latest quarter's sales quantities are adjusted using these growth rates to project demand for the next quarter. 
-- The results are ranked by forecasted demand.


##### **SQL Query:**
```sql

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

```

##### **Question 6: Which regions are expected to grow the most next year?**

##### **Analysis:**  
-- This query forecasts next year’s sales growth for each region by analyzing historical data. 
-- It aggregates yearly sales, calculates year-over-year growth rates using the LAG function, 
-- and computes the average growth rate for each region. 
-- The latest year’s sales are then adjusted by this growth rate to project next year’s sales and, ranking regions by their forecasted growth potential. 


##### **SQL Query:**
```sql



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

```


---



## **Conclusion:**  
This project effectively utilized Power BI for interactive historical data visualization with SQL for advanced forecasting. The Power BI dashboard provided a detailed overview of sales trends, regional performance, and product insights, while SQL queries enabled precise forecasting to answer critical business questions. Together, these tools provided stakeholders with actionable insights, enabling strategic decision-making to optimize operations, enhance profitability, and support business growth.  

The integration of Power BI and SQL in this project demonstrates the power of combining visualization and analytics tools to drive data-informed decisions in a dynamic business environment.  
