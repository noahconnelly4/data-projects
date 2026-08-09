# SQL Superstore Analysis

## Project Overview
This project analyses the Superstore dataset using SQL Server and Power BI to evaluate business performance across profitability, sales, customer retention, and discount strategy.

The analysis was designed around the following business questions:

1. Which region-category combinations generate the highest revenue and profit?
2. Which products are winning and which are losing money?
3. What is our customer retention rate by cohort?
4. How has monthly profit changed over time, and is cumulative profit growing consistently?
5. How do discounts affect sales and profitability across sub-categories?
6. Who are the VIP customers in each region?


## Tools Used
- **Local SQL Server / SSMS** for data exploration and analysis
- **Power BI** for visualization and dashboarding
- **GitHub** for project documentation


## Dataset
- **Dataset:** Superstore Dataset
- **Source:** Kaggle


## Data Exploration and Quality
- **5,009 unique orders**
- **793 unique customers**
- **Date Range:** 2014-2017
- **1 null value** found in `Profit`
- no major structural issues


## Key Insights
- Some sub-categories were highly profitable, while others were losing money.
- Earlier customer cohorts were retained well, but new customer acquisition declines over time.
- Profit grew steadily over time, though month to month profits varies.
- Certain high discounting sub-categories tended to reduce profitability.


## Dashboard
[View dashboard (PDF)](./dashboard/dashboard-preview.pdf) · [Power BI file (.pbix)](./dashboard/dashboard-preview.pbix)


## Repo structure
```
queries/     -- SQL scripts (data exploration + business analysis)
dashboard/   -- Power BI file + PDF export
```
