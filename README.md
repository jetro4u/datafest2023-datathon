## Overview
This dataset simulates real-time agricultural sensor data, providing a rich source of information to design and construct a robust data engineering solution. The primary objective of this project is to extract, transform, and load (ETL) the raw sensor data into structured fact and dimension tables in any data warehouse.

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
Define foreign keys in fact Tables to establish relationships with dimension Tables. Activities here was
also covered after task two was completed.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day2-task3.sql).

#  Day 3: Additional Fact Tables and Optimization

## Task 1: Indexing and Optimization
Implement appropriate indexing strategies to optimize query performance.
Analyze the query patterns and optimize the data model accordingly.
Perform data quality checks and address any anomalies.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day3-task1.sql).

## Task 2: Indexing and Optimization
Document the data model, including schema structure, table relationships, and data dictionary.
Conduct final testing to ensure the accuracy and consistency of the data.
Prepare the data warehouse for querying by data analysts and scientists.
[Check code here](https://github.com/jetro4u/datafest2023-datathon/blob/main/day3-task2.sql).

#  FILE UPLOAD: 
Because of the size of this files, I will provide link to download the files below.

## SUB DIMENSION FILES
Sub Dimension Files such as Irrigation Method, Crop Type
Link [Click here to download](https://drive.google.com/file/d/1ZGZnIJV-XT7tWBy9bCwPKoZvWOHi88AA/view?usp=sharing). 


# DIMENSION FILES

[Crop and Soil Dimension](https://drive.google.com/file/d/1P1mVb9eiFnRWhCzawGWXNqSmwlXWn-Dz/view?usp=sharing). 

[Irrigation ans Sensor](https://drive.google.com/file/d/1Y6PvJTpG2xKyD-Viz-8UWzo8X7LykgTU/view?usp=sharing). 

[Pest and Weather](https://drive.google.com/file/d/1ltZ7cwoM4ZRm-CVibQtNSLuV8aVJy8oo/view?usp=sharing). 


Sub Dimension Files such as Irrigation Method, Crop Type
Link [Location and Time](https://drive.google.com/file/d/1Wq466C8P1BfQhlNzPtoPzqODubk7fTNA/view?usp=sharing). 
