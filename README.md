## Overview
This dataset simulates real-time agricultural sensor data, providing a rich source of information to design and construct a robust data engineering solution. The primary objective of this project is to extract, transform, and load (ETL) the raw sensor data into structured fact and dimension tables within our snowflake data warehouse.

#  Day 1: Data Ingestion and Schema Setup

## Task 1: Data Ingestion
Load the raw data from all source tables (SensorDataRaw, WeatherDataRaw, SoilDataRaw, CropDataRaw, PestDataRaw, IrrigationDataRaw, LocationDataRaw) into staging tables within the Data Warehouse Schema.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day1-task1.sql).

## Task 2: Schema Setup, Data Cleansing and Transformation
Create the schema for the data warehouse.
Cleanse and preprocess the data in the staging tables.
Handle missing values, data type conversions, and data quality checks.
Transform the data into a format suitable for fact and dimension Tables.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day1-task2.sql).


#  Day 2: Dimension Tables and Initial Fact Tables

## Task 1: Create Dimension Tables
Based on the cleaned and transformed data, create dimension Tables for attributes such as Location, Time, Crop Type, Pest Type, and Irrigation Method.
Populate these dimension tables.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day2-task1.sql).

## Task 2: Create Fact Tables
Identify fact Tables based on key performance indicators (KPIs) or metrics of you think would be useful for the data consumers.
Create and populate the initial fact tables using the cleaned and transformed data.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day2-task2.sql).

##  Task 3: Define Primary Keys and Foreign Keys
Define primary keys for dimension Tables.
Define foreign keys in fact Tables to establish relationships with dimension Tables.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day2-task3.sql).