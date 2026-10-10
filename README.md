# 🛒 E-Commerce Business Intelligence & Customer Analytics

**An end-to-end data analytics and business intelligence project using Python, PostgreSQL, SQL, and Power BI.**

## 📌 Project Overview

This project focuses on analyzing e-commerce sales, customer purchasing behavior, product performance, profitability, delivery operations, returns, cancellations, marketing channels, and customer satisfaction.

The objective is to transform structured transactional data into meaningful business insights through data preparation, SQL-based analysis, KPI development, and interactive Power BI visualizations.

The project includes a six-page Power BI dashboard designed to support business performance monitoring, identify analytical trends, and facilitate data-driven decision-making.

## 🎯 Project Objectives

- Analyze overall sales, revenue, and profitability performance.
- Understand customer purchasing behavior and customer segments.
- Evaluate product and category-level sales and profitability.
- Monitor order cancellations, returns, and delivery performance.
- Compare marketing channel performance and customer types.
- Analyze customer ratings and review sentiment.
- Develop interactive KPIs and business intelligence reports.

## 🛠️ Tools & Technologies

### 1. Python — Data Cleaning & Preprocessing

Used Python to inspect datasets, prepare structured data, perform data cleaning, validate data types, handle missing values, check duplicates, and support exploratory data analysis.

**Key capabilities:**
- Pandas for data manipulation and preprocessing
- NumPy for numerical operations
- Data inspection and quality checks
- Missing-value and duplicate analysis
- Data transformation and preparation

### 2. PostgreSQL — Relational Database Management

Used PostgreSQL to store and organize e-commerce data across orders, order items, customer records, and product catalog tables. The database supports structured querying, aggregation, and validation of transactional data.

**Key capabilities:**
- Relational table management
- Structured data storage
- Data types and table organization
- Aggregation and filtering
- Data integrity validation

### 3. SQL — Data Analysis & Validation

Used SQL to query transactional datasets, aggregate business metrics, analyze sales and profitability, examine customer behavior, and evaluate operational performance.

**Key capabilities:**
- JOINs and relational data analysis
- GROUP BY and aggregate functions
- Common Table Expressions (CTEs)
- Conditional logic and CASE statements
- Date-based analysis
- Business KPI calculations
- Data-quality and consistency checks

### 4. Power BI — Interactive Business Intelligence

Developed a six-page interactive Power BI dashboard to present business performance across sales, customers, products, operations, profitability, marketing, and customer satisfaction.

**Key capabilities:**
- Interactive dashboards and reports
- KPI cards and business performance indicators
- Trend and category analysis
- Slicers and interactive filtering
- Comparative visualizations
- Business performance monitoring

### 5. DAX — KPI Development & Business Metrics

Created DAX measures to calculate business performance indicators and enable dynamic analysis within Power BI.

**Key capabilities:**
- Revenue and profit calculations
- Total orders and customer metrics
- Average Order Value (AOV)
- Profit margin analysis
- Cancellation and return rates
- Repeat-customer metrics
- Filter-context-based calculations

### 6. Power Query — Data Transformation

Used Power Query to prepare imported datasets for reporting and organize tables for the Power BI data model.

**Key capabilities:**
- Data type conversion
- Column transformations
- Duplicate handling
- Data preparation
- Query organization
- Data-model preparation

## 📊 Power BI Dashboard

The dashboard contains six analytical pages, each focused on a different business function.

### 1. Executive Overview

Provides a high-level view of overall e-commerce performance.

**Key metrics and analyses:**
- Total Revenue
- Total Profit
- Total Orders
- Total Customers
- Profit Margin
- Monthly Revenue and Profit Trends
- Sales by Product Category
- Sales by Region
- Revenue and Profit by Customer Segment

**Business purpose:** Monitor overall performance and identify major sales and profitability trends.

### 2. Customer & Sales Analytics

Focuses on customer behavior, purchasing patterns, customer segments, and sales performance.

**Key metrics and analyses:**
- Total Customers
- Repeat Customers
- Repeat-Customer Rate
- Average Orders per Customer
- Average Customer Lifetime Value
- Revenue and Profit by Marketing Channel
- Revenue Contribution by Customer Segment
- Revenue and Profit by Customer Type
- Average Order Value and Margin by Segment

**Business purpose:** Understand customer contribution, purchasing patterns, and differences between customer groups.

### 3. Product Analytics

Evaluates product and category performance to understand sales contribution and profitability.

**Key metrics and analyses:**
- Product Sales
- Product Cost
- Product Profit
- Product Units Sold
- Product Profit Margin
- Sales Contribution by Category
- Profit Contribution by Category
- Brand Performance
- Category-Level Profitability Comparisons

**Business purpose:** Identify high-performing categories, compare product profitability, and support product performance evaluation.

### 4. Operations & Delivery Analytics

Examines order fulfillment, delivery performance, returns, and cancellations.

**Key metrics and analyses:**
- Total Orders
- Cancelled Orders
- Cancellation Rate
- Returned Orders
- Return Rate
- Delivery Performance Distribution
- Late Delivery Rate by Warehouse
- Returned Orders by Return Reason
- Cancellation Rate by Sales Channel

**Business purpose:** Monitor operational performance and identify areas that may require further investigation.

### 5. Profitability & Risk Analytics

Focuses on profit margins, loss-making orders, and profitability across business dimensions.

**Key metrics and analyses:**
- Total Revenue
- Total Profit
- Profit Margin
- Loss-Making Orders
- Loss-Making Order Rate
- Profit by Customer Segment
- Revenue vs. Profit by Product Category
- Category-Level Profitability Analysis
- Profitability Benchmark Comparison

**Business purpose:** Evaluate profitability patterns and identify areas for deeper financial analysis.

*Note: Any benchmark displayed in the dashboard should be interpreted as an analytical reference unless independently established as a business target.*

### 6. Marketing & Customer Satisfaction

Analyzes marketing channel performance alongside customer ratings and sentiment.

**Key metrics and analyses:**
- Total Revenue
- Total Profit
- Average Customer Rating
- Positive Review Sentiment
- Return Rate
- Revenue Mix by Marketing Channel and Customer Type
- Customer Sentiment by Segment
- Customer Rating and Order Analysis
- Marketing Channel Performance

**Business purpose:** Explore relationships between marketing channels, customer groups, ratings, and review sentiment.

## 🔄 Project Workflow

The project follows a structured data analytics workflow.

1. **Data Collection:** Load the available e-commerce source datasets.
2. **Data Inspection:** Examine table structures, column names, data types, and data completeness.
3. **Data Cleaning:** Prepare datasets for analysis using Python and data transformation techniques.
4. **Database Management:** Organize the data into relational tables in PostgreSQL.
5. **SQL Analysis:** Query the data, aggregate metrics, and perform business and data-quality checks.
6. **Data Modeling:** Establish relationships between order, customer, product, and order-item tables in Power BI.
7. **KPI Development:** Create DAX measures for sales, profitability, customer, and operational metrics.
8. **Dashboard Development:** Build interactive reports with KPIs, filters, and analytical visualizations.
9. **Business Interpretation:** Examine trends and patterns to identify opportunities for further analysis.

## 📈 Key Business Metrics

| Metric | Description |
|---|---|
| Total Revenue | Sum of order-level net sales |
| Total Profit | Sum of order-level profit |
| Total Orders | Distinct count of orders |
| Total Customers | Distinct count of customers in the selected context |
| Average Order Value | Revenue divided by total orders |
| Profit Margin | Profit divided by revenue |
| Cancellation Rate | Cancelled orders divided by total orders |
| Return Rate | Returned orders divided by total orders |
| Repeat-Customer Rate | Repeat customers divided by the applicable customer denominator |
| Product Sales | Sum of item-level net sales |
| Product Profit | Sum of item-level profit |
| Product Margin | Product profit divided by product sales |

*Metric values can change according to the filters, date range, and calculation context applied in the dashboard.*

## 🗂️ Repository Structure

The repository is organized to separate data, analytical code, SQL scripts, dashboard files, and documentation.

```text
ecommerce-business-intelligence/
│
├── README.md
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── notebooks/
│   ├── data_cleaning.ipynb
│   └── exploratory_data_analysis.ipynb
│
├── sql/
│   ├── data_validation.sql
│   ├── business_analysis.sql
│   └── kpi_queries.sql
│
├── powerbi/
│   ├── dashboard.pdf
│   └── screenshots/
│
└── docs/
    ├── methodology.md
    └── data_dictionary.md
```

*This is the recommended structure. Keep only files that actually exist in the repository, and update filenames to match your uploaded files.*

Large datasets and dashboard files may be linked from the repository's Releases section when appropriate.

## 🚀 How to Explore the Project

1. Review this README to understand the project objectives and dashboard structure.
2. Browse the `notebooks/` directory for Python analysis and preprocessing.
3. Explore the `sql/` directory for SQL queries and validation scripts.
4. Open the dashboard PDF or screenshots in `powerbi/` to review the visualizations.
5. Refer to `docs/` for methodology and data definitions.

If the Power BI `.pbix` file is available in the repository's Releases section, download it and open it using Microsoft Power BI Desktop. Data-source configuration may be required to refresh the report on another computer.

## 💡 Skills Demonstrated

- Data Cleaning and Preprocessing
- Exploratory Data Analysis
- SQL Querying and Data Aggregation
- PostgreSQL Database Management
- Relational Data Modeling
- Power BI Dashboard Development
- DAX Measure Development
- KPI Definition and Monitoring
- Customer and Product Analytics
- Sales and Profitability Analysis
- Operational Performance Analysis
- Data Validation and Documentation
- Business Intelligence and Data Storytelling

## 📌 Dataset Information

The dataset is synthetic and intended for analytical, educational, and portfolio demonstration purposes.

The analysis demonstrates techniques for examining e-commerce transactions, customer behavior, product performance, and operational metrics. Findings should be interpreted within the context of the dataset rather than as verified results from a real company.

Dataset availability is subject to file-size restrictions and applicable licensing or redistribution permissions.

## 🔮 Potential Future Enhancements

- Develop automated data-quality reporting.
- Add customer cohort and retention analysis.
- Perform sales forecasting and trend modeling.
- Extend product-level profitability analysis.
- Add automated SQL validation workflows.
- Explore customer segmentation using machine learning.
- Improve documentation of metric definitions and data lineage.

## 👨‍💻 Author

**Yuvraj Ashar**

MBA — Business Analytics

**Areas of Interest:** Data Analytics | Business Intelligence | SQL | Power BI | Business Analysis

---

*This project demonstrates the application of data analytics and business intelligence tools to an e-commerce use case.*
