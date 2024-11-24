# **Project Title:**  
**Strategic Sales and Profitability Forecasting Using Power BI and SQL**

---

## **Project Report**

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

## **Approach and Methodology**

### **1. Power BI Dashboard for Historical Sales Analysis**  
The Power BI dashboard provided a detailed and interactive view of historical sales trends, product category performance, and regional contributions:

- **Key Metrics Displayed:**  
  - Total Sales: $30.08M  
  - Gross Profit: $11.96M  
  - Total Quantity Sold: 1.24M  
  - Number of Customers: 949  
  - Unique Products Sold: 1,000  

- **Interactive Visualizations:**  
  - **Year-to-Date (YTD) Analysis:** A bar chart comparing YTD metrics by month, highlighting growth or decline.  
  - **Product Performance:** Pie charts visualizing gross profit and sales contribution by product categories (Indoor, Outdoor, Landscape).  
  - **Regional Analysis:** A geographical map showing sales distribution by region and a bar chart of the top-performing countries.  
  - **Cost and Profit Trends:** A line chart comparing sales, costs, and gross profit over time.  

- **Filters and Slicers:**  
  Users can filter data by year, month, region, product type, and performance measures, enabling customized analysis.

---

### **2. SQL-Based Forecast Analysis**  
SQL was employed to complement the Power BI dashboard by addressing specific forecasting questions using advanced data analysis techniques:

---

### **Business Questions Addressed**

1. **What is the projected total sales order quantity for the next quarter across all regions?**  
   SQL analyzed historical quarterly growth rates and applied trend analysis to forecast next quarter’s total sales order quantity.  
   **Insight:** High-demand regions such as North America and Europe are expected to drive sales growth in the upcoming quarter.

2. **Which product categories are expected to generate the highest revenue next year?**  
   Historical revenue trends by product category were analyzed, and SQL queries forecasted the revenue for the upcoming year.  
   **Insight:** Landscape and Indoor product categories are projected to dominate revenue generation, guiding production and marketing focus.

3. **Which regions are expected to see the highest demand growth for specific product categories next quarter?**  
   SQL evaluated demand growth by region and product category using quarterly trends.  
   **Insight:** The United States and Europe showed the highest demand growth for Outdoor and Landscape product categories.

4. **What is the projected revenue for the next month?**  
   Month-over-month revenue growth trends were calculated using SQL to forecast revenue for the upcoming month.  
   **Insight:** Revenue is expected to grow steadily, supporting financial planning and short-term target setting.

5. **Which regions are expected to grow the most next year?**  
   SQL forecasted next year’s regional growth by analyzing historical growth rates and trends.  
   **Insight:** Regions like China and Southeast Asia demonstrated strong growth potential, making them strategic investment opportunities.

6. **What is the expected profitability trend for the next quarter across regions?**  
   SQL combined sales and cost data to calculate and forecast profitability trends for each region.  
   **Insight:** North America and Europe are expected to lead in profitability, driven by higher sales and cost efficiencies.

---



## **Conclusion:**  
This project effectively utilized Power BI for interactive historical data visualization with SQL for advanced forecasting. The Power BI dashboard provided a detailed overview of sales trends, regional performance, and product insights, while SQL queries enabled precise forecasting to answer critical business questions. Together, these tools provided stakeholders with actionable insights, enabling strategic decision-making to optimize operations, enhance profitability, and support business growth.  

The integration of Power BI and SQL in this project demonstrates the power of combining visualization and analytics tools to drive data-informed decisions in a dynamic business environment.  
