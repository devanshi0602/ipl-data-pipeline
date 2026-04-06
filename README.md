IPL Data Pipeline Project

An end-to-end IPL data engineering project built using Python, Apache Airflow, dbt, BigQuery, and Looker Studio.

This project shows how raw IPL match data can be ingested, transformed, tested, and visualized through a complete modern data pipeline. It is designed to be simple enough for students to understand while still being strong enough for a portfolio project.



Project Overview

The main goal of this project is to build an automated data pipeline for IPL data.

The pipeline performs the following steps:

1. ngestion 
   Raw IPL CSV data is loaded into BigQuery using Python.

2. Orchestration 
   Apache Airflow is used to schedule and manage the workflow.

3. Transformation  
   dbt is used to clean, transform, and structure the raw data into analytics-ready models.

4. Testing 
   dbt tests help validate data quality.

5. Visualization  
   The transformed data can be connected to **Looker Studio** to create charts, graphs, and dashboards for better readability and visibility.


Tech Stack

- Python – data ingestion
- Apache Airflow – workflow orchestration
- dbt – data transformation and testing
- BigQuery – cloud data warehouse
- Docker – containerized setup
- Looker Studio – dashboarding and reporting



Project Structure

ipl-pipeline/
│
├── airflow/              # Airflow setup, DAGs, Docker files
├── ingestion/            # Python scripts to load IPL data into BigQuery
├── dbt_ipl/              # dbt project for transformations and tests
├── credentials/          # service account credentials (not pushed to GitHub)
├── data/                 # raw datasets if stored locally
└── README.md
