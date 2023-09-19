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

##  FILE UPLOAD: 
All to this point, all the Facts table and dimension table can be accessed through the query but I am still having challenge uploading the files because of the size.
Also, commiting the file is not going because of the size.
So far my internet is failing me so I will have to go to
a place with strong network. But I will keep trying.

Link to files below.

1. [Dimension Data](https://drive.google.com/file/d/13O2GwAkNWR4qTPxYFHixz_-Cj-c3lDaY/view?usp=sharing).

2. [Farm Fact Metrics](https://drive.google.com/file/d/1yATZ-W-8NillhicYiEf7gKBp0yeyAput/view?usp=sharing).

3. [Crop Metrics](https://drive.google.com/file/d/1_wnLjN1KUKs2mBEfgPF1tjbKHKmIypUb/view?usp=sharing).

4. [Irrigation Metrics](https://drive.google.com/file/d/1-4qo_sXRLpquAI01Ad8UJGORpTuDRlrB/view?usp=sharing).

5. [Pest Metrics](https://drive.google.com/file/d/1-4qo_sXRLpquAI01Ad8UJGORpTuDRlrB/view?usp=sharing).

6. [Soil Metrics](https://drive.google.com/file/d/1RIO1Y1qIhJVDjZXjdmgmbYfxryhjdZiU/view?usp=sharing).

7. [Weather Metrics](https://drive.google.com/file/d/1BEdxsXIpxjvyqdddtphRBZhPKIw1iJTH/view?usp=sharing).

8. [Location Data](https://drive.google.com/file/d/15iqKwD7dzx8LujriBHLABBF2LkhQP2qj/view?usp=sharing).