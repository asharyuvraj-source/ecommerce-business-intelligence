# E-Commerce Business Intelligence & Customer Analytics

**An End-to-End Data Analytics Project | Python • PostgreSQL • SQL • Power BI**

Transforming e-commerce data into actionable business insights through data preparation, SQL analysis, KPI development, customer analytics, and interactive dashboard reporting.

## Project Overview

This project demonstrates an end-to-end business intelligence workflow designed to analyze e-commerce sales performance, customer purchasing behavior, product profitability, operational efficiency, and marketing effectiveness.

Using Python, PostgreSQL, SQL, and Microsoft Power BI, the project organizes structured data into analytical datasets, develops business KPIs, and presents findings through a six-page interactive dashboard.

**Project type:** Business Intelligence & Data Analytics  
**Dataset:** Synthetic e-commerce data  
**Tools:** Python, Pandas, NumPy, PostgreSQL, SQL, Power Query, Power BI, DAX

## Business Objectives

- Evaluate revenue, profit, sales trends, and order performance.
- Understand customer segments, repeat purchasing, and customer lifetime value.
- Compare product categories, sales volume, costs, and profitability.
- Analyze order cancellations, returns, and delivery performance.
- Examine marketing-channel performance and customer satisfaction.
- Translate business data into clear, decision-supporting visualizations.

## Technology Stack

| Technology | Application |
|---|---|
| Python | Data inspection, preparation, and cleaning |
| Pandas & NumPy | Data manipulation and quality checks |
| PostgreSQL | Structured data storage and querying |
| SQL | Data validation, aggregations, and business analysis |
| Power Query | Data transformation for reporting |
| Power BI | Interactive dashboard and business reporting |
| DAX | KPI measures and analytical calculations |

## Project Workflow

1. **Data Inspection & Preparation** — Examine dataset structure, data types, missing values, and duplicate records.
2. **Data Cleaning & Validation** — Prepare analytical datasets and apply relevant quality checks.
3. **Database Management** — Organize structured datasets in PostgreSQL.
4. **SQL Business Analysis** — Analyze sales, customer, product, and operational performance.
5. **Data Modeling** — Organize order, order-item, customer, product, and date tables for Power BI.
6. **KPI Development** — Define measures for revenue, profit, order volume, margins, returns, cancellations, and delivery performance.
7. **Dashboard Development** — Present the analysis in six dashboard pages.

## Power BI Dashboard

The dashboard is organized into six analytical views.

### 1. Executive Overview
Provides a high-level view of revenue, profit, order volume, customer activity, and sales trends across key business dimensions.

### 2. Customer & Sales Analytics
Examines customer segments, repeat purchasing, sales channels, customer types, ratings, and customer lifetime value.

### 3. Product Analytics
Compares product sales, units sold, costs, profit, and product-level profitability.

### 4. Operations & Delivery
Evaluates cancellations, returns, delivery performance, warehouse operations, and recorded return reasons.

### 5. Profitability & Risk
Highlights profit margins, loss-making orders, and areas requiring further profitability analysis.

### 6. Marketing & Customer Satisfaction
Explores marketing-channel performance, customer ratings, and review sentiment.

## Selected Analytical Findings

The following figures are based on the current project analysis and should be interpreted in the context of its synthetic dataset.

| Metric | Analyzed Result |
|---|---:|
| Order-level revenue | 177.13M |
| Order-level profit | 76.15M |
| Distinct orders | 138,116 |
| Distinct ordering customers | 24,911 |
| Order-level profit margin | 42.99% |
| Cancellation rate | 6.08% |
| Return rate | 6.85% |
| Loss-making orders | 1,296 |
| Product-level sales | 192.40M |
| Product-level profit | 82.70M |

**Metric interpretation:** Order-level and product-level financial measures use different data grains. They are presented separately and should not be treated as interchangeable.

## Repository Structure

```text
ecommerce-business-intelligence/
├── README.md
├── data/
│   ├── raw/
│   │   └── README.md
│   └── cleaned/
│       └── README.md
├── docs/
│   ├── methodology.md
│   └── data_dictionary.md
├── notebooks/
│   └── data_cleaning.ipynb
├── sql/
│   └── ecommerce_sales_analysis.sql
└── powerbi/
    ├── README.md
    ├── Ecommerce_Analysis.pdf
    └── screenshots/
```

Large datasets and other large project files may be provided through the repository's **Releases** section.

## Key Skills Demonstrated

- Data cleaning and preparation
- Exploratory data analysis
- SQL querying and business aggregations
- PostgreSQL data management
- Relational data modeling
- DAX measures and KPI development
- Sales and profitability analysis
- Customer segmentation and repeat-purchase analysis
- Operational and delivery analytics
- Dashboard design and business communication

## Project Deliverables

- Python notebook for data preparation and analysis
- SQL scripts for business analysis
- Methodology and data dictionary documentation
- Power BI dashboard exported as PDF
- Raw and cleaned dataset references
- Six-page dashboard covering core business functions

## Limitations & Interpretation

- The dataset is synthetic and does not represent verified performance for a real company.
- The results are descriptive; observed patterns do not establish causation.
- Marketing ROI requires reliable marketing-spend data.
- KPI interpretation depends on the underlying data definitions and calculation logic.

## Intended Audience

This project is relevant to **Data Analyst, Business Analyst, BI Analyst, Reporting Analyst, and Power BI Developer** opportunities. It demonstrates the application of data preparation, SQL, analytical modeling, KPI design, and dashboard reporting to a business-oriented problem.

---

**Developed as a Business Intelligence & Data Analytics portfolio project.**
