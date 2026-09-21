# South-Africa-GBV-Femicide-Analysis
SQL and Power BI analysis of South African gender-based violence and femicide data.




## Project Overview

Gender-based violence (GBV) and femicide remain important social issues in South Africa. This project uses data analysis to explore reported GBV and femicide patterns and present the findings through an interactive Power BI dashboard.

The project demonstrates an end-to-end data analytics workflow, from data preparation and SQL analysis to dashboard development and data storytelling.

---

## Project Objectives

The main objectives of this project were to:

* Explore patterns and trends in reported GBV cases.
* Analyze femicide-related data.
* Compare patterns across provinces and time periods where applicable.
* Identify areas with higher reported case volumes.
* Transform raw data into meaningful analytical insights.
* Build an interactive dashboard to communicate findings clearly.

---

##  Tools & Technologies

* **SQL Server Management Studio (SSMS)** — data cleaning, exploration and analysis
* **SQL** — querying, aggregation and analytical analysis
* **Power BI** — interactive dashboard and data visualization
* **DAX** — calculated measures and dashboard KPIs
* **Microsoft Excel / CSV** — dataset preparation and storage

---

##  Project Structure

```text
South-Africa-GBV-Femicide-Analysis/
│
├── data/
│   ├── GBV_data.csv
│   └── Femicide_data.csv
│
├── sql/
│   ├──analysis.sql
│   
│
├── powerbi/
│   └── GBV_Femicide_Dashboard.pbix
│
├── screenshots/
│   └── dashboard.png
│
└── README.md
```

---

## Data Preparation & Cleaning

The datasets were loaded into SQL Server and reviewed before analysis.

The data preparation process included:

* Reviewing table structures and data types.
* Identifying missing values.
* Checking for duplicate records.
* Reviewing inconsistent or invalid values.
* Standardizing fields where necessary.
* Preparing the datasets for analysis and visualization.

---

## SQL Analysis

SQL Server was used to perform exploratory and analytical queries on the GBV and femicide datasets.

The analysis included:

* Aggregations using `COUNT()`, `SUM()` and other aggregate functions.
* `GROUP BY` analysis.
* Filtering using `WHERE` and `HAVING`.
* `CASE` statements for categorization.
* `JOIN` operations between relevant datasets.
* Common Table Expressions (CTEs).
* Subqueries.
* Window functions.
* Time-based analysis.
* Province-level comparisons.

The SQL scripts are organized in the `/sql` folder.

---

## 📈 Power BI Dashboard

The final analysis was transformed into an interactive Power BI dashboard.

The dashboard provides visual analysis of:

* Reported GBV cases
* Femicide data
* Trends over time
* Provincial comparisons
* Key performance indicators
* Category-level patterns
* Interactive filtering





## Key Analytical Questions

The project was designed around questions such as:

1. How have reported GBV cases changed over time?
2. Which provinces recorded the highest number of reported cases?
3. What patterns can be observed in the femicide data?
4. How do reported GBV patterns differ across provinces?
5. What trends can be identified from the available data?
6. How can the data be presented in a way that makes important patterns easier to understand?

---

## Skills Demonstrated

This project demonstrates practical experience with:

**Data Analytics**

* Data cleaning
* Exploratory data analysis
* Data transformation
* Trend analysis
* Comparative analysis
* Data storytelling

**SQL**

* Joins
* CTEs
* Subqueries
* Window functions
* Aggregations
* Conditional logic
* Filtering and grouping

**Power BI**

* Data modelling
* DAX measures
* KPI cards
* Interactive filters
* Charts and visualizations
* Dashboard design

---




---

##  Author

**Mitchell Nzimande**

Aspiring Data Analyst | SQL | Power BI | Excel | Python

This project forms part of my data analytics portfolio and demonstrates my ability to transform raw data into analytical insights and interactive visualizations.
