# Data Warehouse and Analytics project 


Welcome to the **Data Warehouse and Analytics Project** repository!

This project demonstrates a comprehensive data warehousing and analytics solution — from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics.

-----
## Data Warehouse Architecture
<img width="1253" height="712" alt="datawarehouse diagram png" src="https://github.com/user-attachments/assets/2c47c544-a5e7-4db0-a4ab-f98a7598fe04" />

This architecture represents the end-to-end data pipeline:

Sources: CRM and ERP data (CSV files)
Bronze Layer: Raw data ingestion without transformation
Silver Layer: Data cleaning, standardization, and normalization
Gold Layer: Business-ready data using star schema and aggregations
Consumption: Used for BI reporting and machine learning

This layered approach ensures scalability, data quality, and efficient analytics.

## 📖 Project Overview

This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.

---

##  Project Requirements

###  Building the Data Warehouse (Data Engineering)

####  Objective

Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

####  Specifications

* **Data Sources:** Import data from two source systems (ERP and CRM) provided as CSV files.
* **Data Quality:** Cleanse and resolve data quality issues prior to analysis.
* **Integration:** Combine both sources into a single, user-friendly data model designed for analytical queries.
* **Scope:** Focus on the latest dataset only; historization of data is not required.
* **Documentation:** Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

###  BI: Analytics & Reporting (Data Analytics)

####  Objective

Develop SQL-based analytics to deliver detailed insights into:

* **Customer Behavior**
* **Product Performance**
* **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.

---

## 📂 Repository Structure
```
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                               # Project documentation and architecture details
│   ├── data_architecture.drawio        # Draw.io file shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_flow.drawio                # Draw.io file for the data flow diagram
│   ├── data_models.drawio              # Draw.io file for data models (star schema)
│  
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository

```
---


## 📄 License

This project is licensed under the **MIT License**. You are free to use, modify, and share this project with proper attribution.

---
## About Me

I'm Atharva Sutar, a BSc Computer Science student and aspiring Data Engineer, passionate about building data-driven solutions and sharing knowledge in an engaging way.

## 👤 About Me
 I'm **Atharva Sutar**, a BSc Computer Science student and aspiring Data Engineer, passionate about building data-driven solutions and sharing knowledge in an engaging way.
