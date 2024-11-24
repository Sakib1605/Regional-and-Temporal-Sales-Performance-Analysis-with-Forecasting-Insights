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
